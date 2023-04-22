FROM python:3

RUN addgroup --system <group> && \
    adduser --system <user> --ingroup <group>
    
USER <user>:<group>


WORKDIR /app

COPY . .

CMD ["python", "./app.py"]

