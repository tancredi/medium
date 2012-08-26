cheerio = require "cheerio"
request = require 'request'



module.exports.getData = getData



getData = (url, cb) ->
	if url.indexOf('http') is -1 then url = "http://#{ url }"
	request url, (err, response, body) ->
		if not error? and response.statusCode is 200
			data = parseData body, url
			if data
				cb null, data
			else
				cb 'No data retrieved', null
		else if err?
			cb err, null
		else
			cb 'HTTP request unsuccessful', null



parseData = (html, url) ->
	data = url: url
	$ = cheerio.load html
	# Trying to catch the page title. If not found it's not worth trying to get other data
	if $('head title').length isnt 0 then data.title = $('head title').text() else return false
	data.images = parseImages $, url
	# Looking for meta description. If not found, falling back on a h1 tag
	if $('meta[type="description"]').length isnt 0
		data.description = $('meta[name="description"]').attr 'content'
	else
		data.description = $('h1').first().text()
	data.description =  trimString data.description

	return data



parseImages = ($, url) ->
	images = []
	# Catching img tags sources
	if $('img').length isnt 0
		$('img').each () ->
			# Making sure relative image paths are being resolved
			imageUrl = solveRelativeUrl $(@).attr('src'), url
			images.push imageUrl
	else
		# If no images are found, loop through inline style tags, hoping to
		# find a background image. This often works, but it's an expensive operation
		$('[style]').each () ->
			if $(@).attr('style').indexOf 'url(' isnt -1
				imageUrl = $(@).attr('style').match(/url\((.*?)\)/)
				if imageUrl?
					imageUrl = solveRelativeUrl imageUrl[1], url
					images.push imageUrl
	return images



solveRelativeUrl = (url, baseUrl) ->
	return if url.indexOf('http') isnt -1 then url else baseUrl + url



trimString = (str) -> str.replace(/^\s\s*/, '').replace /\s\s*$/, ''


