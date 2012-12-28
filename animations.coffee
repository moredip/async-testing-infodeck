window.nico ?= {}
window.nico.createAnimator = createAnimator = ( props )->
  asEvented.call( props )

  props.animate = ->
    @trigger('animate:will-start')
    @pre(@subject()) if @pre?
    tran = @subject().transition().delay(@delay).duration(@duration).each 'end', =>
      @trigger('animate:did-end')
    @change(tran)
    @trigger('animate:did-start')

  props.prep = ->
    @before(@subject())
    @trigger('animate:did-prep')

  props.postAnimate = (animation)->
    @on 'animate:did-end', -> animation.animate()

  props.simulAnimate = (animation)->
    @on 'animate:will-start', -> animation.animate()

  if props.selector
    props.subject ?= -> d3.select(@selector)

  props.duration ?= 500
  props.delay ?= 0

  props

$ ->
  $('.slide').each (_, slide)->
    $slide = $(slide)
    name = $(slide).data('slide')

    $.get( "#{name}.svg").then (svgDoc)->
      slide.appendChild(svgDoc.childNodes[0])
      CoffeeScript.load "#{name}.coffee"
