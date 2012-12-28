window.nico ?= {}
window.nico.createAnimator = createAnimator = ( props )->
  props.animate ?= ->
    @pre(@subject()) if @pre?
    tran = @subject().transition().duration(500).each 'end', =>
      @next().animate() if @next?
    @change(tran)

  if props.selector
    props.subject ?= -> d3.select(@selector)

  props.prep ?= ->
    @before(@subject())

  props

$ ->
  $('.slide').each (_, slide)->
    $slide = $(slide)
    name = $(slide).data('slide')

    $.get( "#{name}.svg").then (svgDoc)->
      slide.appendChild(svgDoc.childNodes[0])
      CoffeeScript.load "#{name}.coffee"
