#!/bin/bash
npm run prepublish
docker build -t <%= company %>/`node -p "require('./package.json').name"`:`node -p "require('./package.json').version"` .
