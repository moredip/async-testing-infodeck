animate1 = ->
  arrow = d3.select('#post-arrow')
  x2 = arrow.attr('x2')
  arrow.attr('x2',arrow.attr('x1'))
    .transition()
    .delay(200)
    .duration(500)
    .attr('x2',x2)
    .each 'end', ->
      a = animate2
      a.animate( a.subject().transition().duration(500) )

animate2 =
  subject: -> d3.select('#post-text')
  prep: ()-> @subject().attr('opacity','0')
  animate: (s)-> s.attr('opacity','1')



d3.xml "simple-sync-ajax.svg", "image/svg+xml", (xml)->
  document.body.appendChild(xml.documentElement)
  animate2.prep()
  animate1()
