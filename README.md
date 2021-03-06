Grunt-Template-Coffee
=====================
[![NPM Version](https://badge.fury.io/js/grunt-template-coffee.png)](https://npmjs.org/package/grunt-template-coffee)
[![Build Status](https://secure.travis-ci.org/Dreamscapes/Grunt-Template-Coffee.png)](http://travis-ci.org/Dreamscapes/Grunt-Template-Coffee)
[![Dependency Status](https://gemnasium.com/Dreamscapes/Grunt-Template-Coffee.png)](https://gemnasium.com/Dreamscapes/Grunt-Template-Coffee)
[![Built with Grunt](https://cdn.gruntjs.com/builtwith.png)](http://gruntjs.com)

> Grunt-init scaffolding template for CoffeeScript applications with support for [CoffeeLint](http://coffeelint.org), [Mocha](http://visionmedia.github.io/mocha) & [Should.js](https://github.com/visionmedia/should.js), [UglifyJS](https://github.com/mishoo/UglifyJS2) and [Codo](https://github.com/coffeedoc/codo) via Grunt tasks

If you are new to using templates with Grunt, take a look at [Grunt-Init](http://gruntjs.com/project-scaffolding).

## Installation

### Prerequisites

This template uses **Grunt-Init** to transform a template into an actual project and **CoffeeLint** to lint the CoffeeScript files - you must have it installed and **globally** available, including one CoffeeLint plugin which provides additional linting check:

`[sudo] npm install -g coffeelint coffeelint-newline-at-eof`

### Installing the template

This package is available in the **NPM Registry**, so you can install it via `npm`:

`npm install grunt-template-coffee`

Once installed, you may wish to move the template to your *$HOME* directory to make the template available from anywhere:

`mv ./node_modules/grunt-template-coffee ~/.grunt-init/node-coffee`

Note that while installation by cloning this repository is also possible, **NPM** contains a pre-compiled version of the template, so you don't have to `grunt build` it yourself.

## Usage

Once the template is installed in your *$HOME*, all you have to do is create a folder with the name of the project you are about to start and run the `grunt-init` command:

```sh
mkdir My-Awesome-Project # Create a clean folder for your new project
grunt-init node-coffee
# ... You answering questions, Grunt doing its magic...
npm install # Install development dependencies
```

The **node-coffee** is the actual name of this template. You can customise its name by renaming the folder where you installed it ( in the *~/.grunt-init* folder ).

### Specifying default answers

If you find yourself overriding the automatically-detected default answers each time you bootstrap a new project, you may wish to create a *defaults.json* file to provide your own defaults. Read more on official [Grunt-Init's webpage](http://gruntjs.com/project-scaffolding#specifying-default-prompt-answers).

## What's included?

The following tasks are at your disposal in the template:

1. `lint` - Lint your CoffeeScript files using [CoffeeLint](http://coffeelint.org)
1. `test` - Test your CoffeeScript using [Mocha](http://visionmedia.github.io/mocha) and [Should.js](https://github.com/visionmedia/should.js)
1. `build` - Lint your code, test it, compile your CoffeeScript files, move them into place and then uglify them, making the app ready for publishing to **NPM**
1. `docs` - Generate API documentation from your source code using [Codo](https://github.com/coffeedoc/codo)

## Core concepts

Applications written in CoffeeScript are awesome, but CS should never be used in production - compilation on-the-fly takes precious CPU cycles away while your app might have been doing something much more useful. It also makes more sense to compile ahead of time as it gives you precise control over the way it is going to be compiled, thus preventing possible future issues when new versions of CoffeeScript are released ( such as when the Coffee-Script-Redux project is eventually merged into the main CS project ).

In addition to providing a means to compile CoffeeScript ahead of time, this template provides several project structure concepts that should keep your folder and file structure clean as much as possible.

### Project folder structure

Let's discuss how the project is organised.

```
$ My-Awesome-Project  --> root folder of your project
.
├── src/              --> CoffeeScript source files
├── res/              --> Static content - images, text files etc.
├── test/             --> Your test cases
│
├── gruntfile.coffee  --> Grunt tasks configuration
├── index.coffee      --> Your application's entry point
├── package.json      --> NPM's package description
├── coffeelint.json   --> CoffeeLint's linting rules
├── .travis.yml       --> (optional) Travis configuration
├── .gitignore
├── README.md         --> Your README file
└── LICENSE           --> The license text being used
```

#### The *src* folder:
Your CoffeeScript files should be stored here. You may organise your project inside this folder however you wish; your folder structure will be preserved once you build your app.

#### The *res* folder:
Static content like images, text files, or any other non-CoffeeScript files should be placed here. All these files will be simply copied over to the staging area upon build.

#### The *test* folder:
Write your test suites here. [Mocha](http://visionmedia.github.io/mocha) is used as testing framework, while [Should.js](https://github.com/visionmedia/should.js) provides the assertions for your tests.

#### The build process:
Build your application with the `grunt build` command - it will:

1. Compile CoffeeScript in *src/* to JavaScript and place the compiled files next to your source code
1. Compile your *index.coffee* to JavaScript
1. Do nothing with files inside the *res/* folder
1. Uglify and mangle all compiled JavaScript files

When finished, you will have an optimised version of your project, ready for publishing to **NPM**. Just give it a try - create a test project, install dependencies and run `grunt build`, then take a look around to see what happened.

#### Publishing to **NPM Registry**:
Once you have everything sorted out and your application built successfully, simply publish your application to **NPM** via `npm publish`. And, you are done!

The template also installs some sample content to show you how to write and organise the code so you get better understanding about your possibilities.

### Creating additional directories

If you would like to give your code more structure via folder hierarchy, always remember to create a *.gitignore* file in all new folders that excludes all `*.js` files ( to prevent accidentally commiting compiled JavaScript code into your repository ) and also update the *.npmignore* file in the root directory to exclude all *YOUR_FOLDER/\*.coffee* files to prevent publishing your source CoffeeScript files with your optimised content.

## Planned features

I am not quite happy with the whole package release workflow as it stands now ( bump version, commit to develop, merge develop to master, tag the commit, push to GitHub, push to NPM ) so I will be looking into providing a simple, configurable task to do all this heavy lifting, possibly also generating documentation and pushing it to *gh-pages*.

Generating the API documentation is optional: `grunt docs` will generate the html content in *lib/docs/* folder.

## License

This software is licensed under the **BSD-3-Clause License**. See the [LICENSE](LICENSE) file for more information.
