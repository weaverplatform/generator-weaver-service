module.exports =
  <%= name %>:
    log: false
    port: <%= port %>
    
  # services:
    # yourServiceName: 'http://ipOfYourService:portOfYourService'
    
 
  weaver: 'http://<%= ipWeaver %>:<%= portWeaver %>'

  dataDir: "./data/"
