#!/usr/bin/python

from hotqueue import HotQueue
from redis.client import Redis
from redis import Connection, Redis
from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
from config import config
import smtplib
import threading
import time

def get_mail_info(from_addr, to_addr, subject, content):

    message = MIMEMultipart()
    message['From'] = from_addr
    message['To'] = to_addr
    message['Subject'] = subject
    body = content

    message.attach(MIMEText(body, 'html'))
    #message.as_string()
    return message


def sendmails(from_addr, to_addr, message):

    server = smtplib.SMTP(config['smtp_server'], config['smtp_port'])
    server.ehlo_or_helo_if_needed()
    #server.login(config['username'], config['password'])

    try:
        server.sendmail(from_addr, to_addr, message)
    except Exception as error:
        print error


def check_queue(num_db):

    check_queue = Redis(host=config['redis_host'], port=config['redis_port'], db=num_db).dbsize()
    return check_queue
 

def set_queue(num):
    
    queue = ''

    if num == 1:
        queue = HotQueue('High', host=config['redis_host'], port=config['redis_port'], db=num)
    elif num == 2:
        queue = HotQueue('Medium', host=config['redis_host'], port=config['redis_port'], db=num)
    elif num == 3:
        queue = HotQueue('Low', host=config['redis_host'], port=config['redis_port'], db=num)
    elif num == 4:
        queue = HotQueue('Stopped', host=config['redis_host'], port=config['redis_port'], db=num)
    else:
         print 'Invalid Database'

    return queue


def send_proc(queue):

    try:
        mail = queue.get()

        message = get_mail_info(mail['from_email'], mail['to_email'], mail['subject'], mail['content'])
        sendmails(mail['from_email'], mail['to_email'], message.as_string())
        print mail['from_email']
        print mail['to_email']
    except:
        pass


if __name__ == '__main__':

    while True:

        check_high = check_queue(config['high_queue'])
        check_medium = check_queue(config['medium_queue'])
        print check_high
        print check_medium

        if check_high != 0:
            queue = set_queue(1)     
            send_proc(queue)
            print "queue 1"
            time.sleep(10)
        else:
            while True:
                if check_medium != 0:
                    queue = set_queue(2)
                    send_proc(queue)
                    print "queue 2"
                    time.sleep(10) 
                    recheck_1 = check_queue(config['high_queue'])
                    if recheck_1 != 0:
                        break
                else:
                    while True:
                        queue = set_queue(3)
                        send_proc(queue)
                        print "queue 3"
                        time.sleep(10)
                        recheck_1 = check_queue(config['high_queue'])
                        recheck_2 = check_queue(config['medium_queue'])
                        if recheck_1 != 0 or recheck_2 != 0:
                            break
