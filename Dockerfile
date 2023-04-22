FROM python:3

RUN addgroup --system <group>
RUN adduser --system <user> --ingroup <group>
USER <user>:<group>


WORKDIR /app

COPY . .

CMD ["python", "./app.py"]

