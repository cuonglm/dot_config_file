#!/usr/bin/python

from ladon.server.wsgi import LadonWSGIApplication
import wsgiref.simple_server
from os.path import abspath,dirname,join

scriptdir = dirname(abspath(__file__))
service_modules = ['MailServer']

# Create the WSGI Application
application = LadonWSGIApplication(
    service_modules,
    [join(scriptdir,'services'),join(scriptdir,'appearance')],
    catalog_name = 'Ladon Service Examples',
    catalog_desc = 'The services in this catalog serve as examples to how Ladon is used')

if __name__=='__main__':

    server = wsgiref.simple_server.make_server('', 8080 , application)
    server.serve_forever()
