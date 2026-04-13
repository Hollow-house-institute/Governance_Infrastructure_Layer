FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["sh", "-c", "gunicorn -b 0.0.0.0:$PORT app:app"]
