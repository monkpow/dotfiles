#!/usr/bin/env python

import SimpleHTTPServer
import SocketServer
import logging

logging.basicConfig(level=logging.INFO)
PORT = 8300

class GetHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):

    logging.info("PORT %s" % PORT)
    def do_GET(self):
        logging.info(self.client_address)
        logging.info(self.headers)
        SimpleHTTPServer.SimpleHTTPRequestHandler.log_request(self)
        SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)


Handler = GetHandler
httpd = SocketServer.TCPServer(("", PORT), Handler)

httpd.serve_forever()
