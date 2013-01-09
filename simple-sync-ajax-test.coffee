window.nico.animationGroup 'simple-sync-ajax-test', (group)->

  movePostParamsToFake = group.createPathFollowAnimator('post-params',pathSelector:'#post-params-path-1')

  returnPostParams = group.createPathFollowAnimator 'post-params',
    pathSelector:'#post-params-path-2'
    delay: 1000
    duration: 1500 # NOT RESPECTED

  movePostParamsToFake.postAnimate( returnPostParams )
  
  group.firstAnimation( movePostParamsToFake )
 

  do wireUpBulletPoints = ->
    $stagesList = $('.simple-sync-ajax-test ol')

    nico.updateCharredTrailList($stagesList, 'call-add-user')
    movePostParamsToFake.on 'animate:did-start', -> nico.updateCharredTrailList($stagesList,'send-post-params')
    returnPostParams.on 'animate:did-start', -> nico.updateCharredTrailList($stagesList,'lookup-post-params')
