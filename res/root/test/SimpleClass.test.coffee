###
{%= git_user %}\{%= name %}

Licensed under the {%= licenses[0] %} license
For full copyright and license information, please see the LICENSE file

@author     {%= author_name %} <{%= author_email %}>
@copyright  {%= year %} {%= author_name %}
@link       {%= homepage %}
@license    http://choosealicense.com/licenses/{%= licenses[0] %}  {%= licenses[0] %} License
###

should = require 'should'
SimpleClass = require '../src/SimpleClass'

describe 'A SimpleClass suite', () ->

  # Pre-define some variables to be available within the whole suite
  simpleClass = undefined

  describe '#doNothing() method', () ->

    # Execute this before each test case
    beforeEach () ->
      simpleClass = new SimpleClass

    # A test case
    it 'should do nothing special', () ->
      returnValue = simpleClass.doNothing( 'a string' )

      returnValue.should.equal 'a string'
