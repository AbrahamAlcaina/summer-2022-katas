#!/bin/bash
export MONGO_HOST=localhost:27017                                                             


(
	docker run --rm --name telemetry-db \
  -p 27017:27017 \
	mongo & \
	dapr dashboard -p 7777 & \
 wait	
)