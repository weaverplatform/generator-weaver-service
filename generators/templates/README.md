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

### Weaver

You'll need to add this line to the weaver config file at **pluggableServices** section:
    
'<%= name %>': 'http://localhost:<%= port %>'

#### Client side, consuming function exposed at weaver-service

Once the service is running, take in account that after running a new service you'll need to restart **weaver-server** in order to have this new weaver-service available. From the weaver-sdk call the service as:

Example based on defaults endpoints, /
``` var service; 
    Weaver.Plugin.load('<%= name %>').then((plugin) => {
      service = 
    })
```
