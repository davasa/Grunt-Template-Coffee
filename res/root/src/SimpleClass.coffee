###
{%= git_user %}\{%= name %}

Licensed under the {%= licenses[0] %} license
For full copyright and license information, please see the LICENSE file

@author     {%= author_name %} <{%= author_email %}>
@copyright  {%= year %} {%= author_name %}
@link       {%= homepage %}
@license    http://http://choosealicense.com/licenses/{%= licenses[0] %}  {%= licenses[0] %} License
###

###
SimpleClass documentation

@since  0.1.0
###
class SimpleClass

  ###
  Do absolutely nothing and still return something

  @param    {string}    string      The string to be returned - untouched, of course
  @return   string
  @since    0.1.0
  ###
  doNothing: ( string ) ->

    # Really do nothing...
    return string


module.exports = SimpleClass
