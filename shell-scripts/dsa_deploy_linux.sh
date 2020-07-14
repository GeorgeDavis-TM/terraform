#!/bin/bash

ACTIVATIONURL='dsm://agents.deepsecurity.trendmicro.com:443/'
MANAGERURL='https://app.deepsecurity.trendmicro.com:443'
CURLOPTIONS='--silent --tlsv1.2'
linuxPlatform='';
isRPM='';

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo You are not running as the root user.  Please try again with root privileges.;
    logger -t You are not running as the root user.  Please try again with root privileges.;
    exit 1;
fi;

if ! type curl >/dev/null 2>&1; then
    echo "Please install CURL before running this script."
    logger -t Please install CURL before running this script
    exit 1
fi

# Detect Linux platform
platform='';  # platform for requesting package
runningPlatform='';   # platform of the running machine
majorVersion='';
platform_detect() {
 isRPM=1
 if !(type lsb_release &>/dev/null); then
    distribution=$(cat /etc/*-release | grep '^NAME' );
    release=$(cat /etc/*-release | grep '^VERSION_ID');
 else
    distribution=$(lsb_release -i | grep 'ID' | grep -v 'n/a');
    release=$(lsb_release -r | grep 'Release' | grep -v 'n/a');
 fi;
 if [ -z "$distribution" ]; then
    distribution=$(cat /etc/*-release);
    release=$(cat /etc/*-release);
 fi;

 releaseVersion=${release//[!0-9.]};
 case $distribution in
     *"Debian"*)
        platform='Debian_'; isRPM=0; runningPlatform=$platform;
        if [[ $releaseVersion =~ ^7.* ]]; then
           majorVersion='7';
        elif [[ $releaseVersion =~ ^8.* ]]; then
           majorVersion='8';
        elif [[ $releaseVersion =~ ^9.* ]]; then
           majorVersion='9';
        elif [[ $releaseVersion =~ ^10.* ]]; then
           majorVersion='10';
        fi;
        ;;

     *"Ubuntu"*)
        platform='Ubuntu_'; isRPM=0; runningPlatform=$platform;
        if [[ $releaseVersion =~ ([0-9]+)\.(.*) ]]; then
           majorVersion="${BASH_REMATCH[1]}.04";
        fi;
        ;;

     *"SUSE"* | *"SLES"*)
        platform='SuSE_'; runningPlatform=$platform;
        if [[ $releaseVersion =~ ^11.* ]]; then
           majorVersion='11';
        elif [[ $releaseVersion =~ ^12.* ]]; then
           majorVersion='12';
        elif [[ $releaseVersion =~ ^15.* ]]; then
           majorVersion='15';
        fi;
        ;;

     *"Oracle"* | *"EnterpriseEnterpriseServer"*)
        platform='Oracle_OL'; runningPlatform=$platform;
        if [[ $releaseVersion =~ ^5.* ]]; then
           majorVersion='5'
        elif [[ $releaseVersion =~ ^6.* ]]; then
           majorVersion='6';
        elif [[ $releaseVersion =~ ^7.* ]]; then
           majorVersion='7';
        elif [[ $releaseVersion =~ ^8.* ]]; then
           majorVersion='8';
        fi;
        ;;

     *"CentOS"*)
        platform='RedHat_EL'; runningPlatform='CentOS_';
        if [[ $releaseVersion =~ ^5.* ]]; then
           majorVersion='5';
        elif [[ $releaseVersion =~ ^6.* ]]; then
           majorVersion='6';
        elif [[ $releaseVersion =~ ^7.* ]]; then
           majorVersion='7';
        elif [[ $releaseVersion =~ ^8.* ]]; then
           majorVersion='8';
        fi;
        ;;

     *"CloudLinux"*)
        platform='CloudLinux_'; runningPlatform=$platform;
        if [[ $releaseVersion =~ ([0-9]+)\.(.*) ]]; then
           majorVersion="${BASH_REMATCH[1]}";
        fi;
        ;;

     *"Amazon"*)
        platform='amzn'; runningPlatform=$platform;
        if [[ $(uname -r) == *"amzn2"* ]]; then
           majorVersion='2';
        elif [[ $(uname -r) == *"amzn1"* ]]; then
           majorVersion='1';
        fi;
        ;;

     *"RedHat"* | *"Red Hat"*)
        platform='RedHat_EL'; runningPlatform=$platform;
        if [[ $releaseVersion =~ ^5.* ]]; then
           majorVersion='5';
        elif [[ $releaseVersion =~ ^6.* ]]; then
           majorVersion='6';
        elif [[ $releaseVersion =~ ^7.* ]]; then
           majorVersion='7';
        elif [[ $releaseVersion =~ ^8.* ]]; then
           majorVersion='8';
        fi;
        ;;

 esac

 if [[ -z "${platform}" ]] || [[ -z "${majorVersion}" ]]; then
    echo Unsupported platform is detected
    logger -t Unsupported platform is detected
    false
 else
    archType='i386'; architecture=$(arch);
    if [[ ${architecture} == *"x86_64"* ]]; then
       archType='x86_64';
    fi

    linuxPlatform="${platform}${majorVersion}/${archType}/";
 fi
}

platform_detect
if [[ -z "${linuxPlatform}" ]] || [[ -z "${isRPM}" ]]; then
    echo Unsupported platform is detected
    logger -t Unsupported platform is detected
    exit 1
fi

echo Downloading agent package...
if [[ $isRPM == 1 ]]; then package='agent.rpm'
    else package='agent.deb'
fi
curl -H "Agent-Version-Control: on" $MANAGERURL/software/agent/${runningPlatform}${majorVersion}/${archType}/$package?tenantID=30958 -o /tmp/$package $CURLOPTIONS

echo Installing agent package...
rc=1
if [[ $isRPM == 1 && -s /tmp/agent.rpm ]]; then
    output=$(rpm --checksig /tmp/agent.rpm)
    rc=$?
    if [[ ${rc} != 0 ]] || [[ ${output} != *"pgp"* &&  ${output} != *"signatures"* ]]; then
        echo The digital signature on the agent installer is invalid.
        exit 1
    fi
    rpm -ihv /tmp/agent.rpm
    rc=$?
elif [[ -s /tmp/agent.deb ]]; then
    output=$(dpkg-sig --verify /tmp/agent.deb)
    rc=$?
    if [[ ${rc} != 0 ]] || [[ ${output} != *"GOODSIG"* ]] ; then
        echo The digital signature on the agent installer is invalid.
        exit 1
    fi
    dpkg -i /tmp/agent.deb
    rc=$?
else
    echo Failed to download the agent package. Please make sure the package is imported in the Deep Security Manager
    logger -t Failed to download the agent package. Please make sure the package is imported in the Deep Security Manager
    exit 1
fi
if [[ ${rc} != 0 ]]; then
    echo Failed to install the agent package
    logger -t Failed to install the agent package
    exit 1
fi

echo Install the agent package successfully

sleep 15
/opt/ds_agent/dsa_control -r
/opt/ds_agent/dsa_control -a $ACTIVATIONURL "tenantID:0953E2DB-3281-8CBF-F530-77BE500BF5B5" "token:7FD27CAC-B26B-A4C6-49B1-70B3FD13477D"
# /opt/ds_agent/dsa_control -a dsm://agents.deepsecurity.trendmicro.com:443/ "tenantID:0953E2DB-3281-8CBF-F530-77BE500BF5B5" "token:7FD27CAC-B26B-A4C6-49B1-70B3FD13477D"