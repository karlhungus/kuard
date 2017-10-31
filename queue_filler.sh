#!/bin/bash
# #to use this
# kubectl apply -f rs-queue.yml
#
# #in a different terminal:
#
# QUEUE_POD=$(kubectl get pods -l app=work-queue,compoennt=queue -o jsonpath='{.items[0].metadata.name}')
# kubectl port-forward $QUEUE_POD 8080:8080
#
#
# kubectl apply -f service-queue.yml
# 
# #run this script, finally run:
# kubectl apply -f job-consumer.yml

# create a work queue called 'keygen'
curl -X PUT localhost:8080/memq/server/queues/keygen

# Create 100 work items and load up the queue.
for i in {0..99}; do
  curl -X POST localhost:8080/memq/server/queues/keygen/enqueue -d "work-item-$i"
done

# get the stats
curl 127.0.0.1:8080/memq/server/stats
