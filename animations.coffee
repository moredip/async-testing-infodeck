window.nico ?= {}

window.nico.animationGroup = (name,context)->
  container = d3.select("svg[data-diagram='#{name}']")

  createAnimator = ( props )->
    asEvented.call( props )

    #defaults
    props.pre ?= ->
    props.before ?= ->

    props.animate ?= ->
      @trigger('animate:will-start')
      @pre(@subject())
      tran = @subject().transition()
        .delay(@delay)
        .duration(@duration)
        .each( 'start', => @trigger('animate:did-start') )
        .each( 'end', => @trigger('animate:did-end') )

      @change(tran)


    props.prep ?= ->
      @before(@subject())
      @trigger('animate:did-prep')

    props.postAnimate = (animation)->
      @on 'animate:did-end', -> animation.animate()

    props.simulAnimate = (animation)->
      @on 'animate:will-start', -> animation.animate()


    if props.selector
      props.subject ?= -> container.select(@selector)

    props.duration ?= 500
    props.delay ?= 0


    props.prep()
    props

  registerFirstAnimation = (animation)->
    container.on 'click', ->
      animation.animate()

  group = 
    container: container
    createAnimator: createAnimator
    firstAnimation: registerFirstAnimation

  context( group )


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
      $(diagram).find('svg').attr('data-diagram',name)
      CoffeeScript.load "#{name}.coffee"


# d3 extensions
do d3Extensions = ->
  
  pathTravellerFor = (path)->
    if typeof path == 'string'
      path = document.getElementById(path)

    pathLength = path.getTotalLength()
    pathOrigin = path.getPointAtLength(0)

    pointAlongPath = (t)->
      absolutePoint = path.getPointAtLength( pathLength * t ) 
      {
        x: absolutePoint.x - pathOrigin.x
        y: absolutePoint.y - pathOrigin.y
      }
    pointAlongPath

  d3.transition.prototype.translateAlongPath = (path)->
    pointAlongPath = pathTravellerFor(path)
    this.attrTween 'transform', (d,i,origTransform)->
      (t)->
        point = pointAlongPath(t)
        "#{origTransform} translate(#{point.x},#{point.y})"
