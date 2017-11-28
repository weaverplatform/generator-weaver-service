var Generator = require('yeoman-generator')
const path    = require('path')
const mkdirp  = require('mkdirp')

module.exports = class extends Generator {
    
  constructor(args, opts) {
    
    super(args, opts);
    
    var sourceRoot = '/templates'
    
    this.sourceRoot(path.join(__dirname, sourceRoot))
    
  }
  
  prompting() {
        var done = this.async()
        this.prompt([{
            type: 'input',
            name: 'name',
            require: true,
            message: 'Weaver service name (no spaces or uppercase)',
            default: 'weaver-service'
        }, {
            type: 'input',
            name: 'version',
            message: 'Version',
            default: '0.0.1'
        }, {
            type: 'input',
            name: 'description',
            message: 'Description',
            default: 'Description for this awesome weaver-service'
        }, {
            type: 'input',
            name: 'author',
            message: 'Author',
            default: ''
        }, {
            type: 'input',
            name: 'email',
            message: 'Author email',
            default: 'yourMail@mail.no',
            required: true
        }, {
            type: 'input',
            name: 'company',
            message: 'Company or organization name',
            default: ''
        }, {
            type: 'Number',
            name: 'port',
            message: 'Port number for Express',
            default: 2525,
            required: true
        }, {
            type: 'input',
            name: 'ipWeaver',
            message: 'IP of Weaver Server',
            default: 'localhost',
            required: true
        },{
            type: 'input',
            name: 'portWeaver',
            message: 'Port number of Weaver Server',
            default: 9487,
            required: true
        },{
            type: 'input',
            name: 'license',
            message: 'License',
            default: 'GPL-3.0'
        }]).then((answers) => {
            this.props = answers
            done();
         })
    }
  
    writing() {
        this.fs.copyTpl(
            this.templatePath('**/*'),
            this.destinationPath(this.props.name),
            this.props
        )
        console.log(this.destinationPath());
        mkdirp(`${this.destinationPath(this.props.name)}/data/`)
        mkdirp(`${this.destinationPath(this.props.name)}/logs/`)
    }
    
    installDevDependencies() {
      this.npmInstall(['chai','chai-as-promised','coffee-script','mocha','npm-watch'],
        { 'save-dev': true },
        {cwd: this.destinationPath(this.props.name)}
      )
    }
    
    
    installDependencies() {
      this.npmInstall(['coffee','express','weaver-sdk','config','winston', 'winston-daily-rotate-file', 'moment'],
        { 'save': true },
        {cwd: this.destinationPath(this.props.name)}
      )
    }
    
    end(){
      this.log(`More info at ${this.props.name}/README.md`)
      this.log(`The new ${this.props.name} is ready to add more service, enjoy!`)
    }
};
