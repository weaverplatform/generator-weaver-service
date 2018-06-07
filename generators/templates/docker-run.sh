#!/bin/bash
npm run prepublish 
docker rm <%= name %>-cont
docker build -t <%= name %> .
docker run --name <%= name %>-cont -it -p <%= port %>:<%= port %> <%= name %>
