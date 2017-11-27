# Libs
express           = require('express')
app               = express()
http              = require('http').Server(app)
fs                = require('fs')
config            = require('config')
Weaver            = require('weaver-sdk')




log = config.get('<%= name %>.log')

info = JSON.parse(fs.readFileSync('./package.json', 'utf8'))

# Setup
weaver = new Weaver()
try
  weaver.connect(config.get('weaver'))
catch error
  console.log error
  

# Index page
app.get('/', (req, res) ->
  res.status(200).send("#{info.name} #{info.version}")
)

app.get('/+swagger', (req, res) ->
  res.sendFile('swagger.yaml', {root: './static/'})
)

# Run
port = process.env.PORT or config.get('<%= name %>.port')
http.listen(port, ->
  console.log "#{info.name} #{info.version} running on port #{port}"
  console.log "Connecting to weaver endpoint: #{config.get('weaver')}"
)

