#Medium

Medium is just a little module written in coffeescript using Request and Cheerio to parse metadata from a URL.

Note: The test file is currently empty, although the moudule will be soon unit-tested

[![Build Status](https://secure.travis-ci.org/tancredi/medium.png?branch=master)](http://travis-ci.org/tancredi/medium)

###Setup

``npm install medium``

####Coffeescript

``medium = require 'medium'``

####Javascript

``var medium = require('medium');``

###Exported functions

####getData (url, callback)

`url` (String) Must be a valid URL
`callback` (Function) Use like `function (err, data)` when executed.

The returned `data` (Object) will contain `url` (String), `title` (String), `images` (Array), `description` (String)

The data return is only a best guess based on the DOM structure returned by the request.
Will error in case of a failed connection or in case no data was found.

