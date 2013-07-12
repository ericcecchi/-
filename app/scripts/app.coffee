define ['jquery','sha1','codebird','typeahead'], ($)->
	'use strict'

	$.fn.center = ->
		@css "margin-left", -($(this).outerWidth() / 2)

	unless String.linkify
		String::linkify = ->

			# http://, https://, ftp://
			urlPattern = /\(?\bhttp:\/\/[-A-Za-z0-9+&@#\/%?=~_()|!:,.;]*[-A-Za-z0-9+&@#\/%=~_()|]/g

			# www. sans http:// or https://
			pseudoUrlPattern = /(^|[^\/])(www\.[\S]+(\b|$))/g

			# Email addresses
			emailAddressPattern = /\w+@[a-zA-Z_]+?(?:\.[a-zA-Z]{2,6})+/g
			@replace(urlPattern, "<a href=\"$&\">$&</a>").replace(pseudoUrlPattern, "$1<a href=\"http://$2\">$2</a>").replace emailAddressPattern, "<a href=\"mailto:$&\">$&</a>"

	getVerse = ()->
		console.log "Getting verse."
		cb = new Codebird
		cb.setConsumerKey("Ruh48JJwUvtX5znpgHISVg", "4FH1GrYQBZvp9ajsOjXeuxWyIvD5IApIEBnphOaJJ08")

		cb.__call(
			"oauth2_token",
			{},
			(reply)->
				bearer_token = reply.access_token
		)

		cb.__call(
			"statuses_userTimeline",
			{screen_name: "Daily_Bible", count: 1},
			(reply)->
				$("#verse").html reply[0]['text'].linkify()
				if typeof(Storage) != "undefined"
					d = new Date()
					localStorage.date = d.getDate() + 1
					localStorage.verse = reply[0]['text']
			, true
		)

	$(document).ready ->
		$(window).resize ->
			$(".hero").center()

		$(".hero").center()

		$('input[name="q"]').on "typeahead:initialized", ()->
			console.log "typeahead initialized"

		$('input[name="q"]').typeahead
			name: "Google"
			remote:
				url: "http://google.com/complete/search?output=firefox&q=%QUERY"
				dataType: "jsonp"
				filter: (parsedResponse)->
					console.log "typeahead working"
					parsedResponse[1]

		$('input[name="q"]').focus()

		if typeof(Storage) and localStorage.date
			today = new Date().getDate()
			localStorage.removeItem "verse" if localStorage.date < today

			if localStorage.verse
				console.log "Using localStorage verse"
				$("#verse").html localStorage.verse.linkify()
			else
				getVerse()
		else
			getVerse()

