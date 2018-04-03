# Libs
express  = require('express')
app      = express()
http     = require('http').Server(app)
fs       = require('fs')
config   = require('config')
Weaver   = require('weaver-sdk')
logger   = require('./util/logger')

info = JSON.parse(fs.readFileSync('./package.json', 'utf8'))

# Setup
weaver = new Weaver()
try
  weaver.connect(config.get('weaver'))
catch error
  logger.error error
  

# Util
ensureParameters = (req, res, parameters...) ->
  for p in parameters
    if !req.query[p]?
      res.status(400).send("Parameter #{p} required")
      return false
  true

# Index page displaying info about the service. The optional req query param is just for example purposes
app.get('/', (req, res) ->
	res.status(200).send("#{info.name} #{info.version} #{if req.query.name? then req.query.name else ' '}")
)

# Swagger page
app.get('/+swagger', (req, res) ->
  res.sendFile('swagger.yaml', {root: './static/'})
)

# echo POST endpoint, just to have an example of reusing params at swagger file.
# Note that checking here the parameters would be working at weaver-plugin and 
# on a http request. Setting this required at swagger 'parameters/required' just
# affects the checking when is consumed as weaver-plugin
app.post('/+echo', (req, res) ->
  if ensureParameters(req, res, 'name')
    res.send("Hi, #{req.query.name}")
)

# Run
port = process.env.PORT or config.get('<%= name %>.port')
http.listen(port, ->
  logger.info "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⣠⠞⠀⠀⠀⠀⠀"
  logger.info "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣶⣶⣶⣦⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⠏⣀⣤⣶⣿⠋⠀⠀⠀⠀⠀⠀"
  logger.info "⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠉⢿⣶⣶⣤⣀⣀⣀⣀⣀⣀⣠⣤⣶⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀"
  logger.info "⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠉⠉⠉⠉⠉⠀⠀⠁⠉⠉⠛⠛⠿⠿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀"
  logger.info "⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠈⠉⠙⠛⠿⣿⣿⣿⣿⣿⣿⡀⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
  logger.info "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠙⠛⠻⠿⠟⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   "
  logger.info "#{info.name} #{info.version} running on port #{port}"
  logger.info "Connecting to weaver endpoint: #{config.get('weaver')}"
  return
)

