#!/bin/bash

ACTIVATIONURL='dsm://agents.deepsecurity.trendmicro.com:443/'
SOURCEURL='https://app.deepsecurity.trendmicro.com:443/';
AGENTSEGMENT='software/agent/';
CURL='curl ';
CURL_OPTIONS=' --insecure --silent --tlsv1.2 -o ';
CURL_MAJOR_MIN=7;
CURL_MINOR_MIN=34;
FILENAME='agent.bff.gz';
PACKAGE="/tmp/${FILENAME}";
platform='AIX';
version=`uname -v`;
release=`uname -r`;
CURL_HEADER='-H "Agent-Version-Control: on" ';
CURL_QUERYSTRING="?tenantID=81444&aixVersion=${version}&aixRelease=${release}";
if [ ${version} -eq "7" ] && [ ${release} -eq "2" ]; then
    # Special case for AIX 7.2 for DS9.0 agent. AIX7.1 and AIX7.2 both use the same AIX7.1 package
    release=1;
fi
old_platform=${platform}_${version}.${release};
arch='/powerpc/';
function log() {
    echo "$1";
    logger -p user.err -t ds-agent "$1";  # /var/adm/messages
}

if type curl > /dev/null 2>&1; then
    curl_major="`curl --version | paste -s - | sed 's/curl \([0-9]*\)\..*/\1/g'`";
    curl_minor="`curl --version | paste -s - | sed 's/curl [0-9]*\.\([0-9]*\)\..*/\1/g'`";
    if [ -z "${curl_major}" ] || [ -z "${curl_minor}" ]; then
        log "The version of curl you are using does not support TLS 1.2, which is required to install an agent using a deployment script. Upgrade to curl ${CURL_MAJOR_MIN}.${CURL_MINOR_MIN}.0 or later.";
        false;
    elif [ ${curl_major} -lt ${CURL_MAJOR_MIN} ] || ([ ${curl_major} -eq ${CURL_MAJOR_MIN} ] && [ ${curl_minor} -lt ${CURL_MINOR_MIN} ]); then
        log "The version of curl you are using does not support TLS 1.2, which is required to install an agent using a deployment script. Upgrade to curl ${CURL_MAJOR_MIN}.${CURL_MINOR_MIN}.0 or later.";
        false;
    elif [ "`/usr/bin/id | sed 's/.*uid=\([0-9]*\).*/\1/g'`" != "0" ]; then
        log "You are not running as the root user. Please try again with root privileges.";
        false;
    else
        echo "Downloading agent package ...";

            # First Try to download with new package name
            downloadAction=$CURL$CURL_HEADER\"$SOURCEURL$AGENTSEGMENT$platform$arch$FILENAME$CURL_QUERYSTRING\"$CURL_OPTIONS$PACKAGE;
            rm -rf "${PACKAGE}";
            echo "$downloadAction";
            eval ${downloadAction};
            file $PACKAGE | grep "gzip";
        if [ $? -ne 0 ]; then
            # Download with the new package name failed. Try with the old package name;
            platform=$old_platform;
            downloadAction=$CURL$CURL_HEADER\"$SOURCEURL$AGENTSEGMENT$platform$arch$FILENAME$CURL_QUERYSTRING\"$CURL_OPTIONS$PACKAGE;
            rm -rf "${PACKAGE}";
            echo "$downloadAction";
            eval ${downloadAction};
            file $PACKAGE | grep "gzip";
            if [ $? -ne 0 ]; then
                log "Failed to download agent package";
                exit 1;
            fi
        fi
        echo "Installing agent package ...";

        rc=1;
        gunzip -f "${PACKAGE}";
        /usr/sbin/installp -a -d /tmp/agent.bff ds_agent;
        rc=$?;
        rm -rf "/tmp/agent.bff";
        if [ ${rc} -eq 0 ]; then
            echo "Install the agent package successfully.";

            sleep 15
            /opt/ds_agent/dsa_control -r
            /opt/ds_agent/dsa_control -a $ACTIVATIONURL "tenantID:0C0F6851-AB41-04C6-D6A8-5479A257E932" "token:09C86B32-AED2-35D9-8807-A4C47BFA6257" "policyid:265"
            # /opt/ds_agent/dsa_control -a dsm://agents.deepsecurity.trendmicro.com:443/ "tenantID:0C0F6851-AB41-04C6-D6A8-5479A257E932" "token:09C86B32-AED2-35D9-8807-A4C47BFA6257" "policyid:265"
        else
            log "Failed to install the agent package.";
            false;
        fi
    fi
else
    log "Please install CURL before running this script.";
    false;
fi
