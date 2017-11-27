var Generator = require('yeoman-generator')
const path = require('path')

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
            default: 'Descriptoin for this awesome weaver-service'
        }, {
            type: 'input',
            name: 'author',
            message: 'Author',
            default: ''
        }, {
            type: 'input',
            name: 'email',
            message: 'Author email',
            default: ''
        }, {
            type: 'input',
            name: 'company',
            message: 'Company or organization name',
            default: 'sysunite'
        }, {
            type: 'Number',
            name: 'port',
            message: 'Port number for Express',
            default: 2525,
            required: true
        }, {
            type: 'input',
            name: 'license',
            message: 'License',
            default: 'ISC'
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
    }
    
    installDevDependencies() {
      this.npmInstall(['chai','chai-as-promised','coffee-script','mocha','npm-watch'], { 'save-dev': true })
    }
    
    
    installDependencies() {
      this.npmInstall(['coffee','express','weaver-sdk','config'], { 'dev': true })
    }

  
};