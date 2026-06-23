FROM docker.io/library/python:3.12-slim

RUN pip install requests

COPY proxy.py /proxy.py

CMD ["python", "/proxy.py"]
