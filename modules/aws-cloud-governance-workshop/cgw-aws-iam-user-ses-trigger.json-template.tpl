{
    "Source":"Cloud Governance Workshop Team <george_davis@trendmicro.com>",
    "Template":"CgwIamUserSesTemplate",
    "ConfigurationSetName": "CgwIamUserSesConfigSet",
    "Destinations": [
      ${cgw-aws-iam-user-ses-email-destinations}
    ],
    "DefaultTemplateData": "{ \"cgwWorkshopWebUrl\":\"${cgw-workshop-web}\", \"teamUuid\":\"cgw-aws-${cgw-aws-uuid}\", \"awsConsoleUrl\": \"${cgw-aws-console-url}\", \"awsAccountId\": \"${cgw-aws-account-id}\", \"awsIamUserName\": \"${cgw-aws-iam-user}\", \"awsIamUserConsolePassword\": \"${cgw-aws-iam-user-console-password}\" }"
  }