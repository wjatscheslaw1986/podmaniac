#!/usr/bin/env python3

import os
import http.server
import socketserver
import requests

MODEL_URL = os.environ["MODEL_URL"].rstrip("/")
API_KEY = os.environ["MODEL_API_KEY"]

class Handler(http.server.BaseHTTPRequestHandler):

    def do_GET(self):
        self.forward()

    def do_POST(self):
        self.forward()

    def do_PUT(self):
        self.forward()

    def do_DELETE(self):
        self.forward()

    def forward(self):
        if not self.path.startswith("/v1/"):
            self.send_error(403)
            return

        body = None
        if "Content-Length" in self.headers:
            body = self.rfile.read(int(self.headers["Content-Length"]))

        headers = {
            k: v
            for k, v in self.headers.items()
            if k.lower() != "host"
        }

        headers["Authorization"] = f"Bearer {API_KEY}"

        resp = requests.request(
            self.command,
            f"{MODEL_URL}{self.path}",
            headers=headers,
            data=body,
            stream=True,
        )

        self.send_response(resp.status_code)

        for k, v in resp.headers.items():
            if k.lower() == "transfer-encoding":
                continue
            self.send_header(k, v)

        self.end_headers()

        for chunk in resp.iter_content(8192):
            self.wfile.write(chunk)

socketserver.UnixStreamServer(
    "/socket/model.sock",
    Handler,
).serve_forever()
