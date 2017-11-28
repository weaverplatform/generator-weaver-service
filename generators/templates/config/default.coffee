module.exports =
  '<%= name %>':
    port: <%= port %>
    logging:
      console: 'info'
      file:    'error'
    
  # services:
    # yourServiceName: 'http://ipOfYourService:portOfYourService'
    
 
  weaver: 'http://<%= ipWeaver %>:<%= portWeaver %>'

  dataDir: "./data/"
