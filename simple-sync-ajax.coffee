window.nico.animationGroup 'simple-sync-ajax', (group)->

  showPostArrow = group.createFunctionCallAnimator('post')

  fadePostParams = group.createFadeOutAnimator 'post-params'
    duration: 500
  showPostBody = group.createAnimator
    selector: '#post-body'
    before: (s)-> 
      s.attr('fill-opacity','0.2')
    change: (s)-> s.attr('fill-opacity','1')
    duration: 1000

  showPostReturn = group.createFunctionCallAnimator('post-return',true)
  showAddUserReturn = group.createFunctionCallAnimator('add-user-return',true)

  movePostParams = group.createPathFollowAnimator 'post-params',
      delay: 100

  movePostResponse = group.createPathFollowAnimator 'post-response',
      delay: 100

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


