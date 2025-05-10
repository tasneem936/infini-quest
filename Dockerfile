FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN adduser --disabled-password --gecos '' appuser

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

RUN chown -R appuser /app
USER appuser

ENV HOST=0.0.0.0 \
    PORT=5000 \
    DEBUG=false \
    DB_PATH=/app/data/app.db

RUN mkdir -p /app/data

EXPOSE 5000

CMD ["python", "app.py"]

