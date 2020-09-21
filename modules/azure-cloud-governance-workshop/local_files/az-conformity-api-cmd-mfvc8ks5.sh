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
                        "mfvc8ks5"
                    ]
                },
                "configuration": {
                    "arn": "arn:aws:sns:us-east-2:666402644145:cgw-aws-sns-mfvc8ks5-EmailSNSTopic-1KZNVVJ9I52I2"
                },
                "channel": "sns",
                "manual": true
            },
            "relationships": {
                "account": {
                    "data": {
                        "type": "accounts",
                        "id": "6RSBdHc7r"
                    }
                }
            }
        }
    ]
}'