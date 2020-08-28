locals {
  dsaScriptName = join(
    "",
    [
      "dsa_deploy_",
      data.aws_ami.ubuntu-1804.platform == "windows" ? "windows" : "linux",
      data.aws_ami.ubuntu-1804.platform == "windows" ? ".ps1" : ".sh"
    ]
  )
  dsaSourcePath      = join("", ["./shell-scripts/", local.dsaScriptName])
  dsaDestinationPath = join("", ["/tmp/", local.dsaScriptName])

  vmUser          = "ec2-user"
  vmPass          = "ec2-user"
  mysqlDbRootUser = "root"
  mysqlDbRootPass = "Windows1!Windows1!"
  mysqlHostIP     = "3.20.89.105"

  conformityAwsAccountId = "1oQb4IA7"

  cgwWorkshopWebUrl = "http://3.20.89.105:4200"
  awsConsoleUrl     = "https://us-east-1.signin.aws.amazon.com/"
  awsAccountId      = "666402644145"

  cgwAwsConformitySesTemplateName = "CgwConformitySesTemplate"
  cgwAwsConformitySesSubjectPart  = "Cloud One Conformity Alert! - Cloud Governance Workshop"
  cgwAwsConformitySesHtmlPart     = "<style>.email-footer{font-family: 'Arial'; font-size: 1rem; padding-top: 1rem; font-weight: bold;}p{font-family: 'Arial';}table{border-collapse: collapse; font-family: 'Arial';}.marginLeft{margin-left: 2rem;}table, th, td{border: 0; padding: 1rem; color: black;}tr:nth-child(even){background: #ffb3b3;}tr:nth-child(odd){background: #ffcccc;}td:first-child{font-weight: bold;}.link{text-decoration: none;}.logo{max-height: 3rem; max-width: auto;}.title{margin: 0 1rem 3rem 0; font-size: 1.5rem; font-weight: bold; font-family: 'Arial'; width: 100%;}.alertTitle{padding: 1rem 1.5rem; background-color: #ff3333; font-size: 1.25rem; font-weight: bold; font-family: 'Arial';}</style><table> <tr> <td><img class='logo' src='https://www.trendmicro.com/content/dam/trendmicro/global/en/global/logo/logo-desktop.png'/></td><td class='title'>Cloud Governance Workshop</td></tr></table><p class='alertTitle'> Trend Micro Cloud One Conformity Alert</p><table class='marginLeft'> <tr> <td>Team ID</td><td>{{teamUuid}}</td></tr><tr> <td>Rule ID</td><td><a href='{{resolutionPageUrl}}' class='link'>{{ruleId}}</a> </td></tr><tr> <td>Rule Title</td><td>{{ruleTitle}}</td></tr><tr> <td>Resource</td><td><a href='{{link}}' class='link'>{{resource}}</a></td></tr><tr> <td>Status</td><td>{{status}}</td></tr><tr> <td>Message</td><td>{{message}}</td></tr><tr> <td>Risk Level</td><td>{{riskLevel}}</td></tr><tr> <td>Category</td><td>{{categories}}</td></tr></table><p class='email-footer marginLeft'><a href='{{resolutionPageUrl}}' class='link' target='_blank'>Click here to open Cloud One Conformity &#187;</a></p>"
  cgwAwsConformitySesTextPart     = "\nCloud Governance Workshop\n\n\tTrend Micro Cloud One Conformity Alert!\n\n\tTeam ID - {{teamUuid}}\n\tRule ID - {{ruleId}} [{{resolutionPageUrl}}]\n\tRule Title - {{ruleTitle}}\n\tResource - {{resource}} [{{link}}]\n\tStatus - {{status}}\n\tMessage - {{message}}\n\tRisk Level - {{riskLevel}}\n\tCategory - {{categories}}\n\n\nCopy this URL to open Cloud One Conformity for the related audit and remediation knowledge base - {{resolutionPageUrl}}\n"

  cgwAwsIamUserSesTemplateName = "CgwIamUserSesTemplate"
  cgwAwsIamUserSesSubjectPart  = "Greetings, Welcome to Cloud Governance Workshop!"
  cgwAwsIamUserSesHtmlPart     = "<style>.email-footer{font-family: 'Monotype Corsiva'; font-size: 1.5rem; padding-left: 0.5rem;}p{font-family: 'Arial';}table{border-collapse: collapse; font-family: 'Arial';}.marginLeft{margin-left: 2rem;}table, th, td{border: 0; padding: 1rem; color: black;}.color-purple{background-color: #b3b3ff;}tr:nth-child(even){background: #ffd699;}tr:nth-child(odd){background: #ffb84d;}td:first-child{font-weight: bold;}.link{text-decoration: none;}.bg-yellow{background-color: #FFFF00; padding: 0.5rem;}.logo{max-height: 3rem; max-width: auto;}.title{margin: 0 1rem 3rem 0; font-size: 1.5rem; font-weight: bold; font-family: 'Arial'; width: 100%;}</style><table class='color-green'> <tr> <td><img class='logo' src='https://www.trendmicro.com/content/dam/trendmicro/global/en/global/logo/logo-desktop.png'/></td><td class='title'>Cloud Governance Workshop</td></tr></table><p> Welcome to the workshop hosted by Trend Micro!</p><p> The workshop is a piece of work that needs fixing. <span class='bg-yellow'>Keep in mind, you can't fix what you cant see.</span></p><p> You can login to the workshop <a href='{{cgwWorkshopWebUrl}}'>here</a></p><p> Here is your Team ID</p><table class='marginLeft'> <tr> <td class='color-purple'>Team ID</td><td class='color-purple'>{{teamUuid}}</td></tr></table><p> You can login with the following AWS credentials to access your personalized environment.</p><table class='marginLeft'> <col> <col> <tr> <td>AWS Console URL</td><td><a href='{{awsConsoleUrl}}' class='link'>{{awsConsoleUrl}}</a> </td></tr><tr> <td>AWS Account Id</td><td>{{awsAccountId}}</td></tr><tr> <td>AWS IAM User Name</td><td>{{awsIamUserName}}</td></tr><tr> <td>AWS Console Password</td><td>{{awsIamUserConsolePassword}}</td></tr></table><p class='email-footer'><i>Happy hunting!</i></p><img src='https://camo.githubusercontent.com/f27ba69fc07b16e7850d29721e1966e86a7a3818/68747470733a2f2f692e696d6775722e636f6d2f4c6d5876784e312e676966'/>"
  cgwAwsIamUserSesTextPart     = "\nCloud Governance Workshop\n\nWelcome to the workshop hosted by Trend Micro!\n\nThe workshop is a piece of work that needs fixing.\n\nKeep in mind, you can't fix what you cant see.\n\n\tYou can login to the workshop here - {{cgwWorkshopWebUrl}}\n\nHere is your Team ID - {{teamUuid}}\n\nYou can login with the following AWS credentials to access your personalized environment.\n\n\tAWS Console URL - {{awsConsoleUrl}}\n\n\tAWS Account Id - {{awsAccountId}}\n\n\tAWS IAM User Name - {{awsIamUserName}}\n\n\tAWS Console Password - {{awsIamUserConsolePassword}}\n\n\tHappy hunting!\n"
  # cgwAwsIamUserSesEmailDestinations = [
  #   for name in local.teamMembers : replace(templatefile("cgw-aws-common-ses-email-destination.json-template.tpl", {
  #     to-email-address = jsonencode(name)
  #     template-data    = join("", ["{ \"cgwWorkshopWebUrl\": \"", local.cgwWorkshopWebUrl, "\", \"teamUuid\":\"cgw-aws-", ${cgw-aws-uuid}, "\", \"awsConsoleUrl\": \"", local.awsConsoleUrl, "\", \"awsAccountId\": \"", local.awsAccountId, "\", \"awsIamUserName\": \"", ${cgw-aws-iam-user}, "\", \"awsIamUserConsolePassword\": \"", ${cgw-aws-iam-user-console-password}, "\" }"])
  #   }))
  # ]
}