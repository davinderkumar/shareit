Template.shareit.rendered = ->

  $('meta[property^="og:"]').remove()
  $('meta[property^="twitter:"]').remove()

  #
  # OpenGraph tags
  #

  $('<meta>', { property: 'og:type', content: 'article' }).appendTo 'head'
  $('<meta>', { property: 'og:site_name', content: location.hostname }).appendTo 'head'
  $('<meta>', { property: 'og:url', content: location.origin + location.pathname }).appendTo 'head'
  $('<meta>', { property: 'og:title', content: "#{@title}" }).appendTo 'head'
  $('<meta>', { property: 'og:description', content: @excerpt }).appendTo 'head'

  if @thumbnail
    img = @thumbnail()
    if img
      if not /^http(s?):\/\/+/.test(img)
        img = location.origin + img
      $('<meta>', { property: 'og:image', content: img }).appendTo 'head'

  #
  # Twitter cards
  #

  $('<meta>', { property: 'twitter:card', content: 'summary' }).appendTo 'head'
  # What should go here?
  #$('<meta>', { property: 'twitter:site', content: '' }).appendTo 'head'

  if @author
    author = @author()
  if author and author.profile and author.profile.twitter
    $('<meta>', { property: 'twitter:creator', content: author.profile.twitter }).appendTo 'head'

  $('<meta>', { property: 'twitter:url', content: location.origin + location.pathname }).appendTo 'head'
  $('<meta>', { property: 'twitter:title', content: "#{@title}" }).appendTo 'head'
  $('<meta>', { property: 'twitter:description', content: @excerpt }).appendTo 'head'
  $('<meta>', { property: 'twitter:image:src', content: img }).appendTo 'head'

  #
  # Twitter share button
  #

  base = "https://twitter.com/intent/tweet"
  url = encodeURIComponent location.origin + location.pathname
  text = encodeURIComponent @title
  href = base + "?url=" + url + "&text=" + text

  if author and author.profile and author.profile.twitter
    href += "&via=" + author.profile.twitter

  $(".tw-share").attr "href", href

  #
  # Facebook share button
  #

  base = "https://www.facebook.com/sharer/sharer.php"
  url = encodeURIComponent location.origin + location.pathname
  title = encodeURIComponent @title
  summary = encodeURIComponent @excerpt
  href = base + "?s=100&p[url]=" + url + "&p[title]=" + title + "&p[summary]=" + summary

  if img
    href += "&p[images][0]=" + encodeURIComponent img

  $(".fb-share").attr "href", href
