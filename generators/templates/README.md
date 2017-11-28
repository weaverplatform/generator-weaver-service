# <%= name %>

## Run

With [NodeJS](https://nodejs.org/en/):

First compile with:

`npm run prepublish`

Then:

`node lib/index.js`

With [Docker](https://www.docker.com/):

`sh run.sh`

or build:

`sh build.sh`

## Using

Once the service is running, you'll see at the console something like:

**<%= name %> <%= version %> running on port <%= port %>**

**Connecting to weaver endpoint: http://<%= ipWeaver %>:<%= portWeaver %>**

Now you can check the info endpoint at:

http://localhost:<%= port %>

And the swagger definition at:

http://localhost:<%= port %>/swagger