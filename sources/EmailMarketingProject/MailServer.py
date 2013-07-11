from ladon.ladonizer import ladonize
from hotqueue import HotQueue
from config import config

class MailServer(object):
  

    @ladonize(int, int, str, str, str, str, str, str, str, str, rtype=int)
    def send_emails(self, mail_id, campaign_id, from_name, from_email, to_email,subject, content, prior, s_date, e_date):

        queue_name = ''

        if (prior == '1'):
            queue_name = 'High'
            queue = HotQueue(queue_name, host=config['redis_host'], port=config['redis_port'], db=prior)
        elif (prior == '2'):
            queue_name = 'Medium'
            queue = HotQueue(queue_name, host=config['redis_host'], port=config['redis_port'], db=prior)
        elif (prior == '3'):
            queue_name = 'Low'
            queue = HotQueue(queue_name, host=config['redis_host'], port=config['redis_port'], db=prior)
        elif (prior == '4'):
            queue_name = 'Stopped'
            queue = HotQueue(queue_name, host=config['redis_host'], port=config['redis_port'], db=prior)
        else:
            print 'Queue is not defined'

        email = {}
        email['mail_id'] = mail_id
        email['campaign_id'] = campaign_id
        email['from_name'] = from_name
        email['subject'] = subject
        email['from_email'] = from_email
        email['to_email'] = to_email
        email['content'] = content
        email['s_date'] = s_date
        email['e_date'] = e_date

        
        if (email['subject'] == '' and email['content'] == ''):
            return 2
        else:
            mail = []
            mail.append(email)
            
            queue.put(*mail)
        return 1    


    @ladonize(int, str, rtype=str)
    def campain_status(self, campaign_id, status):
        return 1  
