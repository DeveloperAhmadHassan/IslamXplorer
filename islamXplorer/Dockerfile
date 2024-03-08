FROM python:3.9-slim

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir -r /code/requirements.txt

COPY . .

CMD ["gunicorn", "-b","0.0.0.0:7860","main:app"]