window.nico.animationGroup '.slide.simple-sync-ajax', (group)->

  showPostArrow = group.createAnimator
    selector: '#post-arrow'
    before: (s)-> 
      @origx2 = s.attr('x2')
      s.attr('x2', s.attr('x1'))
    change: (s)-> s.attr('x2',@origx2)


  showPostText = group.createAnimator
    selector: '#post-text'
    before: (s)-> s.attr('opacity','0')
    change: (s)-> s.attr('opacity','1')
    delay: 200

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
    before: (s)-> 
      s.attr('visibility','hidden')
          
    pre: (s)->
      s.attr('visibility','visible')

    change: (transition)->
      transition.translateAlongPath('post-params-path')

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
