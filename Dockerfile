# 1. specify a base image for your image
FROM python:3.9.16-slim

ENV PYTHONBUFFERED 1
ENV PYTHONWRITEBYTECODE 1

RUN apt-get update \
    && apt-get install -y netcat

ENV APP=/app

# change the working directory to $APP
WORKDIR $APP
# copy the requirements.txt file to $APP
COPY requirements.txt $APP
# install requirements from requirements.txt
RUN pip3 install -r requirements.txt
# copy the rest of the files into $APP
COPY . $APP
# expose the port here 
EXPOSE 8000

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/bin/bash","/app/entrypoint.sh"]

# run command to "python manage.py runserver 0.0.0.0:8000"
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
