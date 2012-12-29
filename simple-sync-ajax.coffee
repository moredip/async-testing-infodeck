createAnimator = window.nico.createAnimator

showPostArrow = createAnimator
  selector: '#post-arrow'
  before: (s)-> 
    @origx2 = s.attr('x2')
    s.attr('x2', s.attr('x1'))
  change: (s)-> s.attr('x2',@origx2)


showPostText = createAnimator
  selector: '#post-text'
  before: (s)-> s.attr('opacity','0')
  change: (s)-> s.attr('opacity','1')
  delay: 200

showPostBody = createAnimator
  selector: '#post-body'
  before: (s)-> 
    s.attr('fill-opacity','0.2')
  change: (s)-> s.attr('fill-opacity','1')
  duration: 1000

showPostReturn = createAnimator
  selector: '#post-return-arrow'
  before: (s)-> 
    @origx2 = s.attr('x2')
    s
      .attr('x2', s.attr('x1'))
      .attr('visibility', 'hidden')
  pre: (s)-> s.attr('visibility','visible')
  change: (s)-> s.attr('x2',@origx2)

showAddUserReturn = createAnimator
  selector: '#add-user-return-arrow'
  before: (s)-> 
    @origx2 = s.attr('x2')
    s
      .attr('x2', s.attr('x1'))
      .attr('visibility', 'hidden')
  pre: (s)-> s.attr('visibility','visible')
  change: (s)-> s.attr('x2',@origx2)

pathTravellerFor = (pathId)->
  path = document.getElementById(pathId)
  pathLength = path.getTotalLength()
  pathOrigin = path.getPointAtLength(0)

  pointAlongPath = (t)->
    absolutePoint = path.getPointAtLength( pathLength * t ) 
    {
      x: absolutePoint.x - pathOrigin.x
      y: absolutePoint.y - pathOrigin.y
    }
  pointAlongPath

movePostParams = createAnimator
  selector: '#post-params'
  before: (s)-> 
    s.attr('visibility','hidden')
        
  pre: (s)->
    s.attr('visibility','visible')

  change: (transition)->
    pathTraveller = pathTravellerFor('post-params-path')

    transition.attrTween 'transform', (d,i,origTransform)->
      (t)->
        point = pathTraveller(t)
        "#{origTransform} translate(#{point.x},#{point.y})"

do wireUpAnimationSequence = ->
  showPostArrow.simulAnimate(showPostText)
  showPostArrow.postAnimate(movePostParams)
  movePostParams.postAnimate(showPostBody)
  showPostBody.postAnimate(showPostReturn)
  showPostReturn.postAnimate(showAddUserReturn)

do wireUpBulletPoints = ->
  $stagesList = $('.simple-sync-ajax ol')

  nico.updateCharredTrailList($stagesList, 'call-add-user')
  showPostArrow.on 'animate:will-start', -> nico.updateCharredTrailList($stagesList, 'call-post')
  showPostBody.on 'animate:will-start', -> nico.updateCharredTrailList($stagesList, 'do-post')
  showPostReturn.on 'animate:will-start', -> nico.updateCharredTrailList($stagesList, 'return-post')
  showAddUserReturn.on 'animate:will-start', -> nico.updateCharredTrailList($stagesList, 'return-add-user')
  showAddUserReturn.on 'animate:did-end', -> nico.updateCharredTrailList($stagesList, '')


showPostArrow.animate()
