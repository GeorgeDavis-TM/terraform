#!/bin/bash
curl -L -X POST 'https://us-west-2-api.cloudconformity.com/v1/settings/communication' \
-H 'Authorization: ApiKey 3psDUjz38cLwhgRtm12BiRH8vrjSGvVHH8gF6nePpahgVUvnZ9Dm4f1VkJ1bv7kP' \
-H 'Content-Type: application/vnd.api+json' \
--data-raw '{
    "data": [
        {
            "type": "settings",
            "attributes": {
                "type": "communication",
                "enabled": true,
                "filter": {
                    "riskLevels": [
                        "HIGH",
                        "VERY_HIGH",
                        "EXTREME"
                    ],
                    "statuses": [
                        "FAILURE"
                    ],
                    "tags": [
                        "${cgw-az-uuid}"
                    ]
                },
                "configuration": {
                    "arn": "${cgw-aws-cf-stack-arn}"
                },
                "channel": "sns",
                "manual": true
            },
            "relationships": {
                "account": {
                    "data": {
                        "type": "accounts",
                        "id": "${cgw-az-conformity-acct-id}"
                    }
                }
            }
        }
    ]
}'