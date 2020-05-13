#!/bin/bash
#
# SCRIPT: install
# AUTHOR: Katlego Matjila
# DATE:   DATE_of_CREATION
# PURPOSE: Give a clear, and if necessary, long, description of the
#          purpose of the shell script. This will also help you stay
#          focused on the task at hand.
#
##########################################################
#            BEGINNING OF MAIN
##########################################################

docker network create --driver bridge --attachable --scope local test

docker image build -t master-db:latest -f master-db.df .

docker run --name master-db -e POSTGRES_HOST_AUTH_METHOD='trust' \
       -e POSTGRES_DB='test' \
       -v master-db:/var/lib/postgresql/data \
       -d -p 15432:5432 \
       --network test \
       master-db:latest

docker image build -t replica-db:latest -f replica-db.df .

docker run --name replica-db -e POSTGRES_HOST_AUTH_METHOD='trust' \
       -v replica-db:/var/lib/postgresql/data \
       -d -p 15433:5432 \
       --network test \
       --restart=on-failure \
       replica-db:latest

# End of script