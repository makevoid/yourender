$ -> # main
  $(".expand").on "click", expand_content_width


# functions

last_width = null

expand_content_width = ->
  cont = $ ".content"
  width = cont.css "max-width"
  if width != "100%"
    last_width = width
    cont.css "max-width", "100%"
  else
    cont.css "max-width", last_width