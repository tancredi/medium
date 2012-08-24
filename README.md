#Medium
----

Medium is just a little module written in coffeescript using Request and Cheerio to parse metadata from a URL.

Note: The test file is currently empty, although the moudule will be soon unit-tested

[![Build status][ci-image]][ci-status]

##Usage
----

Require the module

###Coffeescript

``medium = require 'build/medium.js'``

###Javascript

``var medium = require('build/medium.js');``

###Exported functions

####getData (url, callback)

`url` String - Must be a valid URL
`callback` - Function - Use like `function (err, data)` when executed. `data` will contain `url` - String, `title` - String, `images` - Array, `description` - String

The data return is only a best guess based on the DOM structure returned by the request.
Will error in case of a failed connection or in case no data was found.

