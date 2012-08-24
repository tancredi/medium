medium = require './medium'


fixtures =
	allElements = "<html><head><meta name='Description' content='Description<title>Title</title></head><body><h1>Header</h1></body></html>"



mockRequest = (url, cb) ->
	switch url
		when 'http://www.google.com/' then markup = fixtures.markup.allElements
		else markup = fixtures.markup.allElements
	cb statusCode: 200, markup



medium.mockRequire = (module) ->
	switch module
		when 'request'
			return mockRequest
		else
			return require module



exports["Has method getData"] = (test) ->
	test.strictEqual medium.hasOwnProperty('getData'), true
	test.strictEqual typeof medium.getData, 'function'
	test.done()

# medium.getData 'http://www.google.com/', (err, data) ->
	# console.log data