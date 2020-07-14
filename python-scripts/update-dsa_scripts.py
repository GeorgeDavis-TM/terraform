#!/usr/bin/python3
import requests
import json

url = 'https://app.deepsecurity.trendmicro.com/api/agentdeploymentscripts'
headerData = {
    'api-version': 'v1',
    'api-secret-key': '0953E2DB-3281-8CBF-F530-77BE500BF5B5:1A288641-9A46-743A-AB5C-177627B23BEE:Bb6Znk4thtItsfwF2ARs0LCZ5PNIvtwfEQ+xJxMfEXg=',
    'Content-Type': 'application/json'
}
linuxRawData = {
    "platform": "linux",
    "validateCertificateRequired": "true",
    "validateDigitalSignatureRequired": "true",
    "activationRequired": "true"
}
windowsRawData = {
    "platform": "windows",
    "validateCertificateRequired": "true",
    "validateDigitalSignatureRequired": "true",
    "activationRequired": "true"
}
solarisRawData = {
    "platform": "solaris",
    "validateCertificateRequired": "true",
    "validateDigitalSignatureRequired": "true",
    "activationRequired": "true"
}
aixRawData = {
    "platform": "aix",
    "validateCertificateRequired": "true",
    "validateDigitalSignatureRequired": "true",
    "activationRequired": "true"
}

# print(type(headerData))
# print(type(rawData))
# print(type(json.dumps(rawData)))

res = requests.post(url, headers=headerData, data=json.dumps(linuxRawData))

f = open('shell-scripts/dsa_deploy_linux.sh', 'w+')
f.write(json.loads(res.text)["scriptBody"])
f.close()

res = requests.post(url, headers=headerData, data=json.dumps(windowsRawData))

f = open('shell-scripts/dsa_deploy_windows.ps1', 'w+')
f.write(json.loads(res.text)["scriptBody"])
f.close()

res = requests.post(url, headers=headerData, data=json.dumps(solarisRawData))

f = open('shell-scripts/dsa_deploy_solaris.sh', 'w+')
f.write(json.loads(res.text)["scriptBody"])
f.close()

res = requests.post(url, headers=headerData, data=json.dumps(aixRawData))

f = open('shell-scripts/dsa_deploy_aix.sh', 'w+')
f.write(json.loads(res.text)["scriptBody"])
f.close()

# curl -L -X POST 'https://app.deepsecurity.trendmicro.com/api/agentdeploymentscripts' \
# -H 'Content-Type: application/json' \
# -H 'api-version: v1' \
# -H 'api-secret-key: 0953E2DB-3281-8CBF-F530-77BE500BF5B5:1A288641-9A46-743A-AB5C-177627B23BEE:Bb6Znk4thtItsfwF2ARs0LCZ5PNIvtwfEQ+xJxMfEXg=' \
# -H 'Cookie: AWSALB=wizN52bgDYK/zdVSPkSqoa+DJbjQ+v66kbyHWxZuJ4yZJsZ/hXcFk66GnK5OjDw9onHIGYrzrmt28kuWMop+7gGdeAe7iNDtgFfOCgsyUXKLNxxU3Z3qC3JSU/P+; AWSALBCORS=wizN52bgDYK/zdVSPkSqoa+DJbjQ+v66kbyHWxZuJ4yZJsZ/hXcFk66GnK5OjDw9onHIGYrzrmt28kuWMop+7gGdeAe7iNDtgFfOCgsyUXKLNxxU3Z3qC3JSU/P+' \
# --data-raw '{
#     "platform": "linux",
#     "validateCertificateRequired": true,
#     "validateDigitalSignatureRequired": true,
#     "activationRequired": true
# }'
