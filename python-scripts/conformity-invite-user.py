#!/usr/local/bin/python3

import sys
import requests
import json

print('\n\n\tNumber of arguments:', len(sys.argv), 'arguments.')
print('\n\tArgument List:', str(sys.argv))

conformityEndpointUrl = "https://us-west-2-api.cloudconformity.com/v1"

headersJson = {
    "Authorization": "ApiKey 2fKhT2bUzFEEDfM6rdysSuSRzqdEDyH48XnRqnp3PCVn6vTx8Q923EH6FmNTrPhB",
    "Content-Type": "application/vnd.api+json"
}

getAllUsersResponse = requests.get(conformityEndpointUrl + "/users", headers=headersJson)

## print(getAllUsersResponse.text)

getAllUsersResponseJsonObj = json.loads(getAllUsersResponse.text)

userEmailAddressDict = {}

for user in getAllUsersResponseJsonObj["data"]:

    tempDict = { user["attributes"]["email"]: user["id"]}

    ## print(tempDict)

    userEmailAddressDict.update(tempDict)

## print(str(userEmailAddressDict.keys()))

newUserId = None

if sys.argv[1] not in userEmailAddressDict.keys():

    inviteUserBodyJson = {
        "data": {
            "attributes": {
                "firstName": "CGWConformity",
                "lastName": "User",
                "role": "USER",
                "email": sys.argv[1]
            }
        }
    }

    inviteUserResponse = requests.post(conformityEndpointUrl + "/users", headers=headersJson, json=inviteUserBodyJson)

    ## print(inviteUserResponse.status_code)

    inviteUserResponseJsonObj = json.loads(inviteUserResponse.text)

    print("\n\nUser created successfully...")
    print("\n\nNew User ID - " + inviteUserResponseJsonObj["data"]["id"] + "\n")

    newUserId = inviteUserResponseJsonObj["data"]["id"]

else:

    newUserId = userEmailAddressDict[sys.argv[1]]

if newUserId != None:

    defaultUserAccessListBodyJson = {
        "data": {
            "role": "USER",
            "accessList": [
                {
                    "account": "1oQb4IA7",
                    "level": "NONE"
                },
                {
                    "account": "6RSBdHc7r",
                    "level": "NONE"
                }
            ]
        }
    }

    userUpdateAccessListBodyJson = defaultUserAccessListBodyJson

    for account in userUpdateAccessListBodyJson["data"]["accessList"]:
        if sys.argv[2] == account["account"]:
            account["level"] = "READONLY"

    userUpdateAccessListResponse = requests.patch(conformityEndpointUrl + "/users/" + newUserId, headers=headersJson, json=userUpdateAccessListBodyJson)

    if userUpdateAccessListResponse.status_code == 200:

        print("\n\nUser access updated successfully...\n\n")