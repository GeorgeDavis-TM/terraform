locals {
  cgwAwsConformitySesTemplateName = "CgwConformitySesTemplate"
  cgwAwsConformitySesSubjectPart  = "Cloud One Conformity Alert! - Cloud Governance Workshop"
  cgwAwsConformitySesHtmlPart     = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'><html xmlns='http://www.w3.org/1999/xhtml' xmlns:v='urn:schemas-microsoft-com:vml' xmlns:o='urn:schemas-microsoft-com:office:office' style='width: 100%;'><head><!--[if gte mso 9]><xml> <o:OfficeDocumentSettings> <o:AllowPNG/> <o:PixelsPerInch>96/o:PixelsPerInch /o:OfficeDocumentSettings </xml><![endif]--> <title>Trend Micro</title> <link rel='shortcut icon' href='/favicon.ico' type='image/x-icon'/> <link rel='icon' href='/favicon.ico' type='image/x-icon'/> <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/> <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'/> <meta name='robots' content='noindex,nofollow'/> <meta http-equiv='X-UA-Compatible' content='IE=edge'/> <style>html,body{height:100%; margin:0; padding:0; font-family:Arial, sans-serif;}p{padding-top: 0px; margin-top: 0px; margin-bottom: 7px;}a{color:#cc0000; text-decoration: none;}.w30{width:30%;}.w40{width:40%;}.m_hero2 .background{background-size: cover !important;}/*.td_footer a{color:#333333 !important; font-weight:bold;}*/ .td_black_footer a{color:#ffffff !important; font-weight:bold;}#c3c1Text img{width:100% !important;}@media (max-width: 600px){.banner_tb{height:65% !important;}.banner_tb_space{height:65% !important;}#centralContainer{width:100% !important;}.cta{padding-right:0px !important;}.c1{margin-bottom:20px !important;}.w50{width:33%;padding:20px 0px 0px 20px !important;}.w30{padding: 10px 0px 10px 0px !important;}.w40{padding: 10px 0px 10px 0px !important;}.w100{width:100% !important;display:block !important;}.w90{width: 90% !important;}.mobCenter{text-align: center !important;padding-left:0 !important;padding-right:0 !important;margin: auto !important;}.mobPadding{padding-left: 20px !important;padding-right: 20px !important;}.mobBtnPad{width:10px !important;}.mobBottomPad{margin-bottom: 20px !important;}.mobBottomPadImg{margin-bottom: 20px !important;}.mobBackground{background-image:none !important;height:auto !important;}.full, .t100, .p100, .p100.spaced{width: 100% !important;}.imgBanner100{width:100% !important;}#rightLogoHeader{padding-top:50px !important;}.headerTextc{margin-bottom:25px !important;}.headerImgwithText{padding-bottom:10px !important;}.mobMarginT{padding-top:20px !important;}.mobMarginB{padding-bottom:20px !important;}.mobMarginTopZero{margin-top:0px !important;}.mobPLZ{padding-left:0px !important;}.mobPRZ{padding-right:0px !important;}}@media (max-width: 300px){.mobBottomPadImg{width: 100% !important;}}</style> </head> <body style='background-color:#F3F3F3;'><div id='preheader' style='display:none; font-size:1px; color:#ffffff; line-height:1px; max-height:0px; max-width:0px; opacity:0; overflow:hidden; '>{{my.preheader}}&nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌</div><table id='outer' border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td> <table id='centralContainer' border='0' cellspacing='0' cellpadding='0' width='600' align='center'> <tbody> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color:#ffffffFFF;'> <tbody class='mktoContainer' id='mktoContainer'><tr class='mktoModule' id='logoAndText'> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color:#ffffff;'> <tbody> <tr> <td class='w100 mobCenter' style='text-align:left; padding:20px 0px 20px 20px;'><a href='{{my.home_page}}'> <img src='https://resources.trendmicro.com/rs/945-CXD-062/images/logo-email.png' width='140' border='0'/></a> </td><td class='mktoText w100 mobCenter headerTextc' id='headerText' style='padding: 0 20px; text-align:right; font-size: 14px;'><p><span style='font-size: 18px;'><strong>Cloud Governance Workshop</strong></span><br/></p></td></tr></tbody> </table> </td></tr><tr class='mktoModule m_hero' id='hero'> <td class='banner_tb' width='100%'> <div class='mktoImg' id='bannerImage' mktolockimgsize='true'><a><img border='0' style='border:none;' width='600' src='https://resources.trendmicro.com/rs/945-CXD-062/images/Corporate Workshop Email Banner.png' class='w100'/></a></div></td></tr><tr class='mktoModule' id='oneColModuleCTA'> <td style='padding: 20px 20px 20px 20px; background-color:#ffffff;'> <table cellspacing='0' cellpadding='0' border='0' width='100%'> <tbody> <tr> <td class='w100' width='100%' style='vertical-align:top;'> <table cellspacing='0' cellpadding='0' border='0' width='100%'> <tbody> <tr> <td style='text-align:left; padding:0px; color: #4d4d4f; font-size: 14px; line-height:24px;'><h3> Trend Micro Cloud One Conformity Alert</h3><table cellspacing='0' cellpadding='0' border='0' width='534' id='ext4-ext-gen2675' height='134' style='caret-color: #000000; color: #000000; font-family: Arial, sans-serif; font-style: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration: none;'> <tbody id='ext4-ext-gen2674'> <tr id='ext4-ext-gen2683'> <td id='ext4-ext-gen2682' style='text-align: left; padding: 0px; color: #4d4d4f; font-size: 14px; line-height: 24px;'> <div class='mktoText pointerCursor' id='7606469' mktoname='Column1 - Text' style='cursor: pointer !important; line-height: 24px;'> <table width='530' height='124' style='height: 124px; background-color: #333333; float: left;' border='0'> <tbody><tr style='background-color: #cccccc;'> <td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'><strong>Team Name</strong></span></td><td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'>&nbsp;{{teamUuid}}</span></td></tr><tr style='background-color: #a6a1a1;'> <td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='font-size: 12px;'><strong><span style='color: #ffffff;'>Rule Id</span></strong></span></td><td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'>&nbsp;<a href='{{resolutionPageUrl}}' target='_blank' id='' style='color: #ffffff; text-decoration: none; cursor: pointer !important;'>{{ruleId}}</a></span></td></tr><tr style='background-color: #cccccc;'> <td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='font-size: 12px;'><strong><span style='color: #ffffff;'>Rule Title</span></strong></span></td><td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'>&nbsp;{{ruleTitle}}</span></td></tr><tr style='background-color: #a6a1a1;'><td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='font-size: 12px;'><strong><span style='color: #ffffff;'>Resource</span></strong></span></td><td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'>&nbsp;<a href='{{link}}' target='_blank' id='' style='color: #ffffff; text-decoration: none; cursor: pointer !important;'>{{resource}}</a></span></td></tr><tr style='background-color: #cccccc;'> <td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'><strong>Status</strong></span></td><td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'>&nbsp;{{status}}</span></td></tr><tr style='background-color: #a6a1a1;'> <td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'><strong>Message</strong></span></td><td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'>&nbsp;{{message}}</span></td></tr><tr style='background-color: #cccccc;'> <td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'><strong>Risk Level</strong></span></td><td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'>&nbsp;{{riskLevel}}</span></td></tr><tr style='background-color: #a6a1a1;'> <td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'><strong>Category</strong></span></td><td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'>&nbsp;{{categories}}</span></td></tr></tbody> </table></div></td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table><div style='margin-top: 2rem;'><h4><a href='{{resolutionPageUrl}}' class='link' target='_blank'>Click here to open Trend Micro Cloud One Conformity &#187;</a></h4></div></td></tr><tr class='mktoModule' id='footerSocial'> <td style='background-color: #333333; padding: 10px 20px;'> <table align='left' style='text-align:left;'> <tbody> <tr height='20'> <td width='40' style='width:40px; text-align:left;'><a href='{{my.linkedin_URL}}'><img src='https://resources.trendmicro.com/rs/945-CXD-062/images/email_social_footer_linkedin.png' height='20' width='20' style='height:20px; width:20px;'/></a></td><td width='40' style='width:40px; text-align:left;'><a href='{{my.twitter_URL}}'><img src='https://resources.trendmicro.com/rs/945-CXD-062/images/email_social_footer_tw.png' height='20' width='20' style='height:20px; width:20px;'/></a></td><td width='40' style='width:40px; text-align:left;'><a href='{{my.facebook_URL}}'><img src='https://resources.trendmicro.com/rs/945-CXD-062/images/email_social_footer_fb.png' height='20' width='20' style='height:20px; width:20px;'/></a></td><td width='40' style='width:40px; text-align:left;'><a href='{{my.youtube_URL}}'><img src='https://resources.trendmicro.com/rs/945-CXD-062/images/email_social_footer_yt.png' height='20' width='20' style='height:20px; width:20px;'/></a></td><td width='40' style='width:40px; text-align:left;'><a href='{{my.rss_URL}}'><img src='https://resources.trendmicro.com/rs/945-CXD-062/images/email_social_footer_rss.png' height='20' width='20' style='height:20px; width:20px;'/></a></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table> </body></html>"
  cgwAwsConformitySesTextPart     = "\nCloud Governance Workshop\n\n\tTrend Micro Cloud One Conformity Alert!\n\n\tTeam ID - {{teamUuid}}\n\tRule ID - {{ruleId}} [{{resolutionPageUrl}}]\n\tRule Title - {{ruleTitle}}\n\tResource - {{resource}} [{{link}}]\n\tStatus - {{status}}\n\tMessage - {{message}}\n\tRisk Level - {{riskLevel}}\n\tCategory - {{categories}}\n\n\nCopy this URL to open Trend Micro Cloud One Conformity for the related audit and remediation knowledge base - {{resolutionPageUrl}}\n"

  cgwAwsIamUserSesTemplateName = "CgwIamUserSesTemplate"
  cgwAwsIamUserSesSubjectPart  = "Greetings, Welcome to Cloud Governance Workshop!"
  cgwAwsIamUserSesHtmlPart     = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'><html xmlns='http://www.w3.org/1999/xhtml' xmlns:v='urn:schemas-microsoft-com:vml' xmlns:o='urn:schemas-microsoft-com:office:office' style='width: 100%;'><head><!--[if gte mso 9]><xml> <o:OfficeDocumentSettings> <o:AllowPNG/> <o:PixelsPerInch>96/o:PixelsPerInch /o:OfficeDocumentSettings </xml><![endif]--> <title>Trend Micro</title> <link rel='shortcut icon' href='/favicon.ico' type='image/x-icon'/> <link rel='icon' href='/favicon.ico' type='image/x-icon'/> <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/> <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'/> <meta name='robots' content='noindex,nofollow'/> <meta http-equiv='X-UA-Compatible' content='IE=edge'/> <style>html,body{height:100%; margin:0; padding:0; font-family:Arial, sans-serif;}p{padding-top: 0px; margin-top: 0px; margin-bottom: 7px;}a{color:#cc0000; text-decoration: none;}.w30{width:30%;}.w40{width:40%;}.m_hero2 .background{background-size: cover !important;}/*.td_footer a{color:#333333 !important; font-weight:bold;}*/ .td_black_footer a{color:#ffffff !important; font-weight:bold;}#c3c1Text img{width:100% !important;}@media (max-width: 600px){.banner_tb{height:65% !important;}.banner_tb_space{height:65% !important;}#centralContainer{width:100% !important;}.cta{padding-right:0px !important;}.c1{margin-bottom:20px !important;}.w50{width:33%;padding:20px 0px 0px 20px !important;}.w30{padding: 10px 0px 10px 0px !important;}.w40{padding: 10px 0px 10px 0px !important;}.w100{width:100% !important;display:block !important;}.w90{width: 90% !important;}.mobCenter{text-align: center !important;padding-left:0 !important;padding-right:0 !important;margin: auto !important;}.mobPadding{padding-left: 20px !important;padding-right: 20px !important;}.mobBtnPad{width:10px !important;}.mobBottomPad{margin-bottom: 20px !important;}.mobBottomPadImg{margin-bottom: 20px !important;}.mobBackground{background-image:none !important;height:auto !important;}.full, .t100, .p100, .p100.spaced{width: 100% !important;}.imgBanner100{width:100% !important;}#rightLogoHeader{padding-top:50px !important;}.headerTextc{margin-bottom:25px !important;}.headerImgwithText{padding-bottom:10px !important;}.mobMarginT{padding-top:20px !important;}.mobMarginB{padding-bottom:20px !important;}.mobMarginTopZero{margin-top:0px !important;}.mobPLZ{padding-left:0px !important;}.mobPRZ{padding-right:0px !important;}}@media (max-width: 300px){.mobBottomPadImg{width: 100% !important;}}</style> </head> <body style='background-color:#F3F3F3;'> <div id='preheader' style='display:none; font-size:1px; color:#ffffff; line-height:1px; max-height:0px; max-width:0px; opacity:0; overflow:hidden; '>{{my.preheader}}&nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌ &nbsp;‌</div><table id='outer' border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td> <table id='centralContainer' border='0' cellspacing='0' cellpadding='0' width='600' align='center'> <tbody> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color:#ffffffFFF;'> <tbody class='mktoContainer' id='mktoContainer'><tr class='mktoModule' id='logoAndText'> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color:#ffffff;'> <tbody> <tr> <td class='w100 mobCenter' style='text-align:left; padding:20px 0px 20px 20px;'><a href='{{my.home_page}}'> <img src='https://resources.trendmicro.com/rs/945-CXD-062/images/logo-email.png' width='140' border='0'/></a> </td><td class='mktoText w100 mobCenter headerTextc' id='headerText' style='padding: 0 20px; text-align:right; font-size: 14px;'><p><span style='font-size: 18px;'><strong>Cloud Governance Workshop</strong></span><br/></p></td></tr></tbody> </table> </td></tr><tr class='mktoModule m_hero' id='hero'> <td class='banner_tb' width='100%'> <div class='mktoImg' id='bannerImage' mktolockimgsize='true'><a><img border='0' style='border:none;' width='600' src='https://resources.trendmicro.com/rs/945-CXD-062/images/Corporate Workshop Email Banner.png' class='w100'/></a></div></td></tr><tr class='mktoModule' id='oneColModuleCTA'> <td style='padding: 20px 20px 20px 20px; background-color:#ffffff;'> <table cellspacing='0' cellpadding='0' border='0' width='100%'> <tbody> <tr> <td class='w100' width='100%' style='vertical-align:top;'> <table cellspacing='0' cellpadding='0' border='0' width='100%'> <tbody> <tr> <td style='text-align:left; padding:0px; color: #4d4d4f; font-size: 14px; line-height:24px;'> <div class='mktoText' id='c1c1Titlec' style='color:#cc0000; font-weight:bold; font-size:19px;'> <p>Welcome to the workshop hosted by Trend Micro</p></div></td></tr><tr height='0' style='line-height: 0px; height:0px;'> <td></td></tr><tr> <td style='text-align:left; padding:0px; color: #4d4d4f; font-size: 14px; line-height:24px;'> <div class='mktoText' id='c1c1Textc' style='line-height:24px;'> <p>During the workshop, you will need to find and fix security issues in your cloud infrastructure.&nbsp;Keep in mind, you can't fix what you cant see.&nbsp;Now let's get started!</p></div></td></tr><tr> <td style='padding:15px 0px 0px 0px;'> <center> <div class='mobMarginTopZero' style='text-align: left;'> <div><!--[if mso]> <a:rect xmlns:a='urn:schemas-microsoft-com:vml' xmlns:w='urn:schemas-microsoft-com:office:word' href='{{cgwWorkshopWebUrl}}' style='height:40px;v-text-anchor:middle;width:200px;' strokecolor='#cc0000' fillcolor='#cc0000'> <w:anchorlock/> <center style='font-family:Arial,sans-serif;color:#ffffff;font-size:14px;'>Access the Workshop</center> </a:rect><![endif]--> <a href='{{cgwWorkshopWebUrl}}' style='padding:9px 0px; font-weight:bold; background-color:#cc0000;border:1px solid #cc0000;color:#ffffff;display:inline-block;font-size:14px;text-align:center;text-decoration:none;width:200px;-webkit-text-size-adjust:none;'>Access the Workshop</a> </div></div></center> </td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr><tr class='mktoModule' id='oneColModule6dd984cb-3e80-464b-b271-6934c3fa8f10'> <td style='padding: 20px 20px 20px 20px; background-color:#ffffff;'> <table cellspacing='0' cellpadding='0' border='0' width='100%'> <tbody> <tr> <td class='w100' width='100%' style='vertical-align:top;'> <table cellspacing='0' cellpadding='0' border='0' width='100%'> <tbody> <tr> <td style='text-align:left; padding:0px; color: #4d4d4f; font-size: 14px; line-height:24px;'> <div class='mktoText' id='c1c1Title6dd984cb-3e80-464b-b271-6934c3fa8f10' style='color:#cc0000; font-weight:bold; font-size:19px;'> <p><span style='font-size: 14px;'>Your Team ID</span></p></div></td></tr><tr height='0' style='line-height: 0px; height:0px;'> <td></td></tr><tr> <td style='text-align:left; padding:0px; color: #4d4d4f; font-size: 14px; line-height:24px;'> <div class='mktoText' id='c1c1Text6dd984cb-3e80-464b-b271-6934c3fa8f10' style='line-height:24px;'> <table style='background-color: #333333;' width='152' height='40'> <tbody> <tr> <td style='text-align: center;'><span style='color: #ffffff;'><strong>{{teamUuid}}</strong></span></td></tr></tbody> </table><table><tr><td style='text-align:left; padding:0px; color: #4d4d4f; font-size: 14px; line-height:24px;'><div class='mktoText' id='c1c1Title6dd984cb-3e80-464b-b271-6934c3fa8f10' style='color:#cc0000; font-weight:bold; font-size:19px;'><p><span style='font-size: 14px;'>Team Password</span></p></div></td></tr></table><table tyle='background-color: #333333;' width='152' height='40'><tbody><tr><td style='text-align: center;'><span style='color: #ffffff;'><strong>cgw-aws-hscvlog3</strong></span></td></tr></tbody></table><p><br/></p><p><span style='caret-color: #4d4d4f; color: #4d4d4f; font-family: Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration: none; display: inline !important; float: none;'>You can login with the following AWS credentials to access your personalized environment.</span></p><table cellspacing='0' cellpadding='0' border='0' width='534' id='ext4-ext-gen2675' height='134' style='caret-color: #000000; color: #000000; font-family: Arial, sans-serif; font-style: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration: none;'> <tbody id='ext4-ext-gen2674'> <tr id='ext4-ext-gen2683'> <td id='ext4-ext-gen2682' style='text-align: left; padding: 0px; color: #4d4d4f; font-size: 14px; line-height: 24px;'> <div class='mktoText pointerCursor' id='7606469' mktoname='Column1 - Text' style='cursor: pointer !important; line-height: 24px;'> <table width='530' height='124' style='height: 124px; background-color: #333333; float: left;' border='0'> <tbody> <tr style='background-color: #cccccc;'> <td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'><strong>AWS Console URL</strong></span></td><td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'>&nbsp;<a href='{{awsConsoleUrl}}' target='_blank' id='' style='color: #ffffff; text-decoration: none; cursor: pointer !important;'>https://us-east-1.signin.aws.amazon.com/</a></span></td></tr><tr style='background-color: #a6a1a1;'> <td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='font-size: 12px;'><strong><span style='color: #ffffff;'>AWS Account Id</span></strong></span></td><td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'>&nbsp;{{awsAccountId}}</span></td></tr><tr style='background-color: #cccccc;'> <td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='font-size: 12px;'><strong><span style='color: #ffffff;'>AWS IAM User Name</span></strong></span></td><td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'>&nbsp;{{awsIamUserName}}</span></td></tr><tr style='background-color: #a6a1a1;'> <td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='font-size: 12px;'><strong><span style='color: #ffffff;'>AWS Console Password</span></strong></span></td><td style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; border: 1px dashed #bbbbbb; text-align: left;'><span style='color: #ffffff; font-size: 12px;'>&nbsp;{{awsIamUserConsolePassword}}</span></td></tr></tbody> </table> </div></td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr><tr class='mktoModule' id='footerSocial'> <td style='background-color: #333333; padding: 10px 20px;'> <table align='left' style='text-align:left;'> <tbody> <tr height='20'> <td width='40' style='width:40px; text-align:left;'><a href='{{my.linkedin_URL}}'><img src='https://resources.trendmicro.com/rs/945-CXD-062/images/email_social_footer_linkedin.png' height='20' width='20' style='height:20px; width:20px;'/></a></td><td width='40' style='width:40px; text-align:left;'><a href='{{my.twitter_URL}}'><img src='https://resources.trendmicro.com/rs/945-CXD-062/images/email_social_footer_tw.png' height='20' width='20' style='height:20px; width:20px;'/></a></td><td width='40' style='width:40px; text-align:left;'><a href='{{my.facebook_URL}}'><img src='https://resources.trendmicro.com/rs/945-CXD-062/images/email_social_footer_fb.png' height='20' width='20' style='height:20px; width:20px;'/></a></td><td width='40' style='width:40px; text-align:left;'><a href='{{my.youtube_URL}}'><img src='https://resources.trendmicro.com/rs/945-CXD-062/images/email_social_footer_yt.png' height='20' width='20' style='height:20px; width:20px;'/></a></td><td width='40' style='width:40px; text-align:left;'><a href='{{my.rss_URL}}'><img src='https://resources.trendmicro.com/rs/945-CXD-062/images/email_social_footer_rss.png' height='20' width='20' style='height:20px; width:20px;'/></a></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table> </body></html>"
  cgwAwsIamUserSesTextPart     = "\n\nTrend Micro Cloud Governance Workshop\n\nWelcome to the workshop hosted by Trend Micro<\n\n\tDuring the workshop, you will need to find and fix security issues in your cloud infrastructure. Keep in mind, you can't fix what you cant see. Now let's get started!\n\n\tAccess the Workshop here - {{cgwWorkshopWebUrl}}\n\nYour Team ID - {{teamUuid}}\n\n\n\nTeam Password - {{awsIamUserConsolePassword}}\n\n\n\nYou can login with the following AWS credentials to access your personalized environment.\n\n\n\tAWS Console URL - {{awsConsoleUrl}}\n\n\tAWS Account Id - {{awsAccountId}}\n\n\tAWS IAM User Name - {{awsIamUserName}}\n\n\tAWS Console Password - {{awsIamUserConsolePassword}}\n\n\nContact the team for further assistance.\n\n"
  # cgwAwsIamUserSesEmailDestinations = [
  #   for name in local.teamMembers : replace(templatefile("cgw-aws-common-ses-email-destination.json-template.tpl", {
  #     to-email-address = jsonencode(name)
  #     template-data    = join("", ["{ \"cgwWorkshopWebUrl\": \"", local.cgwWorkshopWebUrl, "\", \"teamUuid\":\"cgw-aws-", ${cgw-aws-uuid}, "\", \"awsConsoleUrl\": \"", local.awsConsoleUrl, "\", \"awsAccountId\": \"", local.awsAccountId, "\", \"awsIamUserName\": \"", ${cgw-aws-iam-user}, "\", \"awsIamUserConsolePassword\": \"", ${cgw-aws-iam-user-console-password}, "\" }"])
  #   }))
  # ]

  participantsList = ["george_davis@trendmicro.com", "yama_saadat@trendmicro.com", "todd_mccullough@trendmicro.com", "gabriel_smyth@trendmicro.com", "antoine_saikaley@trendmicro.com", "jay_kammerer@trendmicro.com", "yama_saadat@tclabs.ca"]
  # participantsList = ["mauricio_zamorano@trendmicro.com", "yessenia_becerra@trendmicro.com", "antoine_saikaley@trendmicro.com", "emma_bryson@trendmicro.com", "daman_saluja@trendmicro.com", "gabriel_smyth@trendmicro.com", "todd_mccullough@trendmicro.com", "jay_kammerer@trendmicro.com", "yama_saadat@tclabs.ca", "george_davis@trendmicro.com", "jerry_tang@trendmicro.com"]

  allowedIpAddresses = ["104.14.117.144/32", "173.172.9.74/32", "72.181.222.201/32", "71.142.248.81/32", "172.127.126.236/32", "174.89.125.192/32", "99.246.229.245/32", "209.141.165.67/32", "104.249.227.218/32", "216.180.70.93/32"]
}

resource "aws_instance" "cgw-common-db-instance" {
  availability_zone      = var.defaultAwsAvailabilityZone
  ami                    = "ami-0f4665edc97a93bea"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.georged-ssh-sg.id, aws_security_group.cgw-common-db-sg.id, aws_security_group.cgw-common-web-sg.id]
  key_name               = var.defaultAwsKeyPairName

  root_block_device {
    volume_type = var.defaultAwsVolumeType
    volume_size = var.defaultAwsVolumeSize
  }

  tags = {
    Name    = "cgw-common-db-ec2-instance"
    Owner   = var.tagOwner
    Project = "cgw-common"
  }

  provisioner "file" {
    source      = local.dsaSourcePath
    destination = local.dsaDestinationPath

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.defaultAwsKeyPairFilePath)
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ${local.dsaDestinationPath}",
      "sudo ${local.dsaDestinationPath}"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.defaultAwsKeyPairFilePath)
      host        = self.public_ip
    }
  }
}

resource "aws_instance" "cgw-common-jenkins-instance" {
  availability_zone      = var.defaultAwsAvailabilityZone
  ami                    = "ami-0f4665edc97a93bea"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.georged-ssh-sg.id, aws_security_group.cgw-common-db-sg.id, aws_security_group.cgw-common-web-sg.id]
  key_name               = var.defaultAwsKeyPairName

  root_block_device {
    volume_type = var.defaultAwsVolumeType
    volume_size = var.defaultAwsVolumeSize
  }

  tags = {
    Name    = "cgw-common-jenkins-ec2-instance"
    Owner   = var.tagOwner
    Project = "cgw-common"
  }

  provisioner "file" {
    source      = local.dsaSourcePath
    destination = local.dsaDestinationPath

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.defaultAwsKeyPairFilePath)
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ${local.dsaDestinationPath}",
      "sudo ${local.dsaDestinationPath}"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.defaultAwsKeyPairFilePath)
      host        = self.public_ip
    }
  }
}

resource "aws_eip" "cgw-common-db-instance-public-ip" {
  vpc      = true
  instance = aws_instance.cgw-common-db-instance.id

  tags = {
    Name    = "cgw-common-db-instance-public-ip"
    Owner   = var.tagOwner
    Project = "cgw-common"
  }
}

resource "aws_security_group" "cgw-common-db-sg" {
  name        = "cgw-common-db-sg"
  description = "Allow CGW DB & Services traffic"
  # vpc_id      = "${aws_vpc.main.id }"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.localIpCidr
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.localIpCidr
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.localIpCidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "cgw-common-db-sg"
    Owner   = var.tagOwner
    Project = "cgw-common"
  }
}

resource "aws_security_group" "cgw-common-web-sg" {
  name        = "cgw-common-web-sg"
  description = "Allow CGW Web traffic"
  # vpc_id      = "${aws_vpc.main.id }"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Swap lines for Dev and Testing
    # cidr_blocks = local.allowedIpAddresses
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Swap lines for Dev and Testing
    # cidr_blocks = local.allowedIpAddresses
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "cgw-common-web-sg"
    Owner   = var.tagOwner
    Project = "cgw-common"
  }
}

resource "aws_ses_email_identity" "cgw-aws-ses-email-identity" {
  count    = length(local.participantsList)
  email    = local.participantsList[count.index]
  provider = aws.use1
}

resource "aws_ses_configuration_set" "cgw-aws-iam-user-ses-config-set" {
  name     = "CgwIamUserSesConfigSet"
  provider = aws.use1
}

resource "aws_ses_configuration_set" "cgw-aws-conformity-ses-config-set" {
  name     = "CgwConformitySesConfigSet"
  provider = aws.use1
}

resource "aws_ses_template" "cgw-aws-iam-user-ses-template" {
  name     = local.cgwAwsIamUserSesTemplateName
  subject  = local.cgwAwsIamUserSesSubjectPart
  html     = local.cgwAwsIamUserSesHtmlPart
  text     = local.cgwAwsIamUserSesTextPart
  provider = aws.use1
}

resource "aws_ses_template" "cgw-aws-conformity-ses-template" {
  name     = local.cgwAwsConformitySesTemplateName
  subject  = local.cgwAwsConformitySesSubjectPart
  html     = local.cgwAwsConformitySesHtmlPart
  text     = local.cgwAwsConformitySesTextPart
  provider = aws.use1
}

output "cgw-common-db-instance-id" {
  value       = aws_instance.cgw-common-db-instance.id
  description = "The Instance ID of the CGW DB Instance"
}

output "cgw-common-db-instance-ip" {
  value       = aws_instance.cgw-common-db-instance.public_ip
  description = "The Public IP of the CGW DB Instance"
}