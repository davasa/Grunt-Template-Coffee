###
Dreamscapes\Grunt-Template-Coffee

Licensed under the BSD (3-Clause) license
For full copyright and license information, please see the LICENSE file

@author     Robert Rossmann <rr.rossmann@me.com>
@copyright  2014 Robert Rossmann
@link       https://github.com/Dreamscapes/Grunt-Template-Coffee
@license    http://choosealicense.com/licenses/bsd-3-clause  BSD-3-Clause License
###

# Basic template description
exports.description = 'Create a node.js project written with CoffeeScript, linted with
CoffeeLint, tested with mocha/should.js and documented with Codo'

# Template-specific notes to be displayed before question prompts.
exports.notes = ''

# Template-specific notes to be displayed after question prompts.
exports.after =
"""

*Limitation:* You may have to fix the url address for the GitHub's
*LICENSE* file in _package.json_.

You should now install development dependencies with _npm install_.
"""

# Don't continue unless the target directory is clean
exports.warnOn = '{.*,*}'

exports.template = ( grunt, init, done ) ->

  init.process {}, [
    # Prompt for these values.
    init.prompt 'name'
    init.prompt 'description'
    init.prompt 'version'
    init.prompt 'repository'
    init.prompt 'homepage'
    init.prompt 'bugs'
    init.prompt 'licenses'
    init.prompt 'author_name'
    init.prompt 'author_email'
    init.prompt 'author_url'
    init.prompt 'node_version', '>= 0.10.0'
    init.prompt 'main', 'index.js'
    init.prompt 'npm_test', 'grunt test'
    {
      name: 'travis',
      message: 'Use Travis CI?',
      default: 'Y/n',
      warning: 'If selected, you must specify which Node versions to test against in _.travis.yml_'
    }
  ], ( err, props ) ->
    props.keywords = []         # Will create the keywords attribute in package.json
    props.devDependencies =     # Development dependencies for this project
      "coffee-script": "~1.6.3"
      "grunt": "~0.4.2"
      "grunt-codo": "~0.1.0"
      "grunt-coffeelint": "0.0.8"
      "grunt-contrib-clean": "~0.5.0"
      "grunt-contrib-coffee": "~0.8.0"
      "grunt-contrib-copy": "~0.5.0"
      "grunt-contrib-uglify": "~0.3.1"
      "grunt-contrib-watch": "~0.5.3"
      "grunt-mocha-cli": "~1.5.0"
      "load-grunt-tasks": "~0.3.0"
      "should": "~3.1.0"

    files         = init.filesToCopy props
    props.travis  = /y/i.test props.travis          # Convert user input to boolean
    props.year    = grunt.template.today 'yyyy'     # Year is used heavily in templates, so generate a helper value

    # Only one license to rule them all
    props.licenses.splice 1, props.licenses.length

    # Do not copy the LICENSE file if not using BSD-3-Clause license
    if props.licenses[0] isnt 'BSD-3-Clause' then delete files['LICENSE']

    if not props.travis then delete files['.travis.yml']  # Exclude Travis config file if we are not going to use Travis

    init.copyAndProcess files, props, noProcess: 'res/img/**'
    init.writePackageJSON 'package.json', props

    # Finished processing the template
    done()
