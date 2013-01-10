window.nico.animationGroup 'simple-async-ajax', (group)->

  showPostArrow = group.createFunctionCallAnimator('post')

  sendPostParams = group.createPathFollowAnimator('post-params')
  sendCallback = group.createPathFollowAnimator('callback-param',pathSelector:'#post-params-path')

  fadePostParams = group.createFadeOutAnimator( 'post-params', duration: 500 )

  showCallbackTunnel = group.createFadeInAnimator( 'callback-tunnel', duration: 1500 )

  showAddUserReturn = group.createFunctionCallAnimator('add-user-return',true)

  showSecondStageOfAjaxCall = group.createFadeInAnimator('ajax-second-stage-block')

  showCallbackArrow = group.createFunctionCallAnimator('callback')
  showCallbackBlock = group.createFadeInAnimator( 'callback-block', delay: 200 )

  showPostArrow.postAnimate(sendPostParams)
  sendPostParams.postAnimate( sendCallback )
  sendCallback.simulAnimate( fadePostParams )
  sendCallback.postAnimate( showAddUserReturn ) 
  showAddUserReturn.postAnimate( showSecondStageOfAjaxCall ) 
  showSecondStageOfAjaxCall.postAnimate( showCallbackArrow ) 
  showCallbackArrow.simulAnimate(showCallbackBlock)
  showCallbackArrow.postAnimate(showCallbackTunnel)
  
  group.firstAnimation( showPostArrow )
 

  #do wireUpBulletPoints = ->
    #$stagesList = $('.simple-sync-ajax-test ol')

    #nico.updateCharredTrailList($stagesList, 'call-add-user')
    #movePostParamsToFake.on 'animate:did-start', -> nico.updateCharredTrailList($stagesList,'send-post-params')
    #returnPostParams.on 'animate:did-start', -> nico.updateCharredTrailList($stagesList,'lookup-post-params')
