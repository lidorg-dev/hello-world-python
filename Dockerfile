FROM python
WORKDIR /app
COPY . .
EXPOSE 8080
RUN pip install -r requirements.txt
ENTRYPOINT ["python","app.py"]
