#!/usr/bin/env python3

from flask import Flask, Response, request
import requests_unixsocket
import urllib.parse

app = Flask(__name__)

SOCKET = "/socket/model.sock"

session = requests_unixsocket.Session()

BASE_URL = (
    "http+unix://"
    + urllib.parse.quote(SOCKET, safe="")
)

HOP_HEADERS = {
    "connection",
    "keep-alive",
    "proxy-authenticate",
    "proxy-authorization",
    "te",
    "trailers",
    "transfer-encoding",
    "upgrade",
    "host",
}


@app.route("/", defaults={"path": ""}, methods=[
    "GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"
])
@app.route("/<path:path>", methods=[
    "GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"
])
def proxy(path):
    target = f"{BASE_URL}/{path}"

    headers = {
        k: v
        for k, v in request.headers.items()
        if k.lower() not in HOP_HEADERS
    }

    r = session.request(
        method=request.method,
        url=target,
        headers=headers,
        data=request.get_data(),
        params=request.args,
        stream=True,
        timeout=600,
    )

    response_headers = [
        (k, v)
        for k, v in r.headers.items()
        if k.lower() not in HOP_HEADERS
    ]

    return Response(
        r.raw,
        status=r.status_code,
        headers=response_headers,
        direct_passthrough=True,
    )


if __name__ == "__main__":
    app.run(
        host="127.0.0.1",
        port=8000,
        threaded=True,
    )
