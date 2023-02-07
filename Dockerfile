FROM python:3.10-alpine

WORKDIR /opt

RUN pip install --upgrade pip && \
    pip install --upgrade pika

COPY app.py .

CMD ["python", "app.py"]