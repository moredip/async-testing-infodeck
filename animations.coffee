window.nico ?= {}
window.nico.createAnimator = ( props )->
  asEvented.call( props )


  props.animate ?= ->
    @trigger('animate:will-start')
    @pre(@subject()) if @pre?
    if @change?
      tran = @subject().transition()
        .delay(@delay)
        .duration(@duration)
        .each 'end', => @trigger('animate:did-end')
      @change(tran)

    @trigger('animate:did-start')

  props.prep ?= ->
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


  props.prep()
  props

window.nico.updateCharredTrailList = ($list,activeItemName)->
  notCurrClass = 'charred'
  $list.find('li').removeClass('charred fresh active').each (_,listItem)->
    if $(listItem).data('name') == activeItemName
      $(listItem).addClass('active')
      notCurrClass = 'fresh'
    else
      $(listItem).addClass(notCurrClass)


$ ->
  $('.diagram-container').each (_, diagram)->
    $diagram = $(diagram)
    name = $(diagram).data('diagram')

    $.get( "#{name}.svg").then (svgDoc)->
      diagram.appendChild(svgDoc.childNodes[0])
      CoffeeScript.load "#{name}.coffee"
