#!/bin/bash

rm -rf /var/lib/postgresql/data/*
pg_basebackup -h master-db -U replicator -D /var/lib/postgresql/data -Fp -Xs -P -R