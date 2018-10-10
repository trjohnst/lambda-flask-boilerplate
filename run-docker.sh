#!/bin/bash

docker run -v $(pwd)/app:/root/app -i -t lambda-flask /bin/ash