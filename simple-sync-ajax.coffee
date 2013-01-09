window.nico.animationGroup 'simple-sync-ajax', (group)->

  showPostArrow = group.createFunctionCallAnimator('post')

  showPostBody = group.createAnimator
    selector: '#post-body'
    before: (s)-> 
      s.attr('fill-opacity','0.2')
    change: (s)-> s.attr('fill-opacity','1')
    duration: 1000

  showPostReturn = group.createAnimator
    selector: '#post-return-arrow'
    before: (s)-> 
      @origx2 = s.attr('x2')
      s
        .attr('x2', s.attr('x1'))
        .attr('visibility', 'hidden')
    pre: (s)-> s.attr('visibility','visible')
    change: (s)-> s.attr('x2',@origx2)

  showAddUserReturn = group.createAnimator
    selector: '#add-user-return-arrow'
    before: (s)-> 
      @origx2 = s.attr('x2')
      s
        .attr('x2', s.attr('x1'))
        .attr('visibility', 'hidden')
    pre: (s)-> s.attr('visibility','visible')
    change: (s)-> s.attr('x2',@origx2)

  movePostParams = group.createAnimator
    selector: '#post-params'
    delay: 100
    before: (s)-> 
      s.attr('visibility','hidden')
          
    pre: (s)->
      s.attr('visibility','visible')

    change: (transition)->
      path = group.container.select('#post-params-path')[0][0]
      transition.translateAlongPath(path)

  movePostResponse = group.createAnimator
    selector: '#post-response'
    delay: 100
    before: (s)-> 
      s.attr('visibility','hidden')
          
    pre: (s)->
      s.attr('visibility','visible')

    change: (transition)->
      path = group.container.select('#post-response-path')[0][0]
      transition.translateAlongPath(path)

  do wireUpAnimationSequence = ->
    showPostArrow.simulAnimate(movePostParams)
    movePostParams.postAnimate(showPostBody)
    showPostBody.postAnimate(showPostReturn)
    showPostReturn.simulAnimate(movePostResponse)
    showPostReturn.postAnimate(showAddUserReturn)

    group.firstAnimation( showPostArrow )

  do wireUpBulletPoints = ->
    $stagesList = $('.simple-sync-ajax ol')

    nico.updateCharredTrailList($stagesList, 'call-add-user')
    showPostArrow.on 'animate:will-start', -> nico.updateCharredTrailList($stagesList, 'call-post')
    showPostBody.on 'animate:will-start', -> nico.updateCharredTrailList($stagesList, 'do-post')
    showPostReturn.on 'animate:will-start', -> nico.updateCharredTrailList($stagesList, 'return-post')
    showAddUserReturn.on 'animate:will-start', -> nico.updateCharredTrailList($stagesList, 'return-add-user')
    showAddUserReturn.on 'animate:did-end', -> nico.updateCharredTrailList($stagesList, '')


