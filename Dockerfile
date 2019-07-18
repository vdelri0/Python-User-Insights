FROM python:3.7-alpine
LABEL maintainer="Victor Del Rio Prens"

#Tells pythons to run unbuffered mode, recomended when running python with a docker container
ENV PYTHONUNBUFFERED 1

#Copies the source code json requirements file to the image requirements file
COPY ./requirements.txt /requirements.txt

#Takes the requirements file copied before and installs It using pip into the docker image
RUN pip install -r /requirements.txt

#Creates empty folder into the image, sets It as the default folder for running apps
#After that, copies the folder api from our local machine to the image api folder
#(Copies the source code into the docker image) 
RUN mkdir /api
WORKDIR /api
COPY ./api /api

#Creates user that will run processes from our project (-D)
#After that switches docker to the user that we created
#Note: if you don't do this, the image will run the api using the root account, NOT RECOMMENDED
#because if somebody compromises our application, the will have access to all the other images
RUN adduser -D user
USER user