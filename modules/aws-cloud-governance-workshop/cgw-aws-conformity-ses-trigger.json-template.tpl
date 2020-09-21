{
  "Source":"Cloud Governance Workshop Team <george_davis@trendmicro.com>",
  "Template":"CgwConformitySesTemplate",
  "ConfigurationSetName": "CgwConformitySesConfigSet",
  "Destinations": [
    ${cgw-aws-conformity-ses-email-destinations}
  ],
  "DefaultTemplateData": "{ \"teamUuid\":\"${cgw-aws-uuid}\", \"resolutionPageUrl\":\"${cgw-aws-conformity-url}\", \"ruleId\": \"${cgw-aws-conformity-rule-id}\", \"ruleTitle\": \"${cgw-aws-conformity-rule-title}\", \"link\": \"${cgw-aws-resource-link}\", \"status\": \"${cgw-aws-conformity-status}\", \"message\": \"${cgw-aws-conformity-message}\", \"riskLevel\": \"${cgw-aws-conformity-risk-level}\", \"categories\": \"${cgw-aws-conformity-categories}\" }"
}