FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app
COPY tests ./tests

ENV PYTHONPATH=/app

EXPOSE 5000

CMD ["python", "app/app.py"]