from __future__ import print_function

import os
import json
import urllib
import boto3

print('Loading message function...')


def send_to_sns(message, context):

    # This function receives its input from three environment variables set : the ARN of an SNS topic,
    # a string with the subject of the message, and a string with the body of the message.
    # The message is then sent to the SNS topic.
    

    sns_topic = os.environ['SNS_TOPIC_ARN']
    subject = os.environ['MSG_SUBJECT']
    sensitiveText = os.environ['MSG_SENSITIVE_TEXT']
    
    sns = boto3.client('sns')
    
    sns.publish(
        TopicArn=sns_topic,
        Subject=subject,
        Message=sensitiveText
    )

    return ('Sent a message to an Amazon SNS topic.')
