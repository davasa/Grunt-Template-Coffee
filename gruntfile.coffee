###
Dreamscapes\Grunt-Template-Coffee

Licensed under the BSD (3-Clause) license
For full copyright and license information, please see the LICENSE file

@author     Robert Rossmann <rr.rossmann@me.com>
@copyright  2014 Robert Rossmann
@link       https://github.com/Dreamscapes/Grunt-Template-Coffee
@license    http://choosealicense.com/licenses/bsd-3-clause   BSD (3-Clause) License
###

module.exports = ( grunt ) ->

  ### ALIASES ###

  jsonFile =                      grunt.file.readJSON           # Read a json file
  module =                        grunt.loadNpmTasks            # Register a grunt task module
  define =                        grunt.registerTask            # Register a local task
  log =                           grunt.log.writeln             # Write a single line to console


  ### GRUNT CONFIGURATION ###

  config =

    # Define aliases for known fs locations
    srcDir:                       'src/'              # CoffeeScript or other source files to be compiled or processed
    libDir:                       'lib/'              # Final, compiled, optimised and whatnot product
    resDir:                       'res/'              # Static resources - images, text files, external deps etc.
    docDir:                       '<%= libDir %>docs' # Automatically-generated or compiled documentation
    instDir:                      process.env.HOME + '/.grunt-init/node-coffee/'   # Template's installation directory
    srcFiles:                     ['<%= srcDir %>**/*.coffee', 'template.coffee']
    pkg:                          jsonFile 'package.json'


    ### TASKS DEFINITION ###

    # grunt-contrib-watch: Run tasks on filesystem changes
    watch:
      options:
        # Define default tasks here, then point targets' "tasks" attribute here: '<%= watch.options.tasks %>'
        tasks:                    ['lint', 'test']
        interrupt:                true           # Restarts any running tasks on next event
        atBegin:                  true           # Runs all defined watch tasks on startup
        dateFormat:               ( time ) -> log "Done in #{time}ms"

      # Targets

      gruntfile:                  # Watch the gruntfile for changes ( also dynamically reloads grunt-watch config )
        files:                    'gruntfile.coffee'
        tasks:                    '<%= watch.options.tasks %>'

      project:                    # Watch the project's source files for changes
        files:                    '<%= srcFiles %>'
        tasks:                    '<%= watch.options.tasks %>'


    # grunt-coffeelint: Lint CoffeeScript files
    coffeelint:
      options:                    jsonFile 'coffeelint.json'

      # Targets

      gruntfile:                  'gruntfile.coffee'                          # Lint this file
      project:                    '<%= srcFiles %>'                           # Lint application's project files


    # grunt-contrib-coffee: Compile CoffeeScript into native JavaScript
    coffee:

      # Targets

      build:                      # Compile CoffeeScript into target build directory
        expand:                   true
        ext:                      '.js'
        src:                      '<%= srcFiles %>'
        dest:                     '<%= libDir %>'


    # grunt-contrib-clean: Clean the target files & folders, deleting anything inside
    clean:

      # Targets

      build:                      ['<%= libDir %>*', '<%= libDir %>.*'] # Clean the build target directory's contents


    # grunt-contrib-copy: Copy source files to their destinations
    copy:

      # Targets

      build:                      # Copy static resources into target build directory
        files: [
          expand:                 true
          src:                    ['README.md', 'LICENSE*', 'rename.json', '.gitignore', 'package.json']
          dest:                   '<%= libDir %>'
        ,
          expand:                 true
          cwd:                    '<%= resDir %>'
          src:                    '**'
          dest:                   '<%= libDir %>',
        ]

      install:                    # Copy the build into the grunt-init's default installation directory
        expand:                   true
        cwd:                      '<%= libDir %>'
        src:                      '**'
        dest:                     '<%= instDir %>'


  ###############################################################################

  ### CUSTOM FUNCTIONS ###


  ### GRUNT MODULES ###

  # Loads all grunt tasks from devDependencies starting with "grunt-"
  require( 'load-grunt-tasks' )( grunt )

  ### GRUNT TASKS ###

  define 'lint',                  ['coffeelint']
  define 'build',                 ['lint', 'clean:build', 'coffee:build', 'copy:build']
  define 'install',               ['build', 'copy:install']
  define 'default',               ['build']

  ###############################################################################
  grunt.initConfig config
