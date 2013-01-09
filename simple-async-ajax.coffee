window.nico.animationGroup 'simple-async-ajax', (group)->

  paramPath = group.container.select('#post-params-path')[0][0]

  showPostArrow = group.createFunctionCallAnimator('post')

  sendPostParams = group.createPathFollowAnimator('post-params')
  sendCallback = group.createPathFollowAnimator('callback-param',pathSelector:'#post-params-path')

  fadePostParams = group.createAnimator
    selector: '#post-params'
    duration: 500
    before: (s)-> s.attr( opacity: 1 )
    change: (t)-> t.attr( opacity: 0 )

  showCallbackTunnel = group.createAnimator
    selector: '#callback-tunnel'
    duration: 1500
    before: (s)-> s.attr( opacity: 0 )
    change: (t)-> t.attr( opacity: 1 )

  showAddUserReturn = group.createFunctionCallAnimator('add-user-return',true)

  showSecondStageOfAjaxCall = group.createAnimator
    selector: '#ajax-second-stage-block'
    before: (s)-> s.attr( opacity: 0 )
    change: (t)-> t.attr( opacity: 1 )

  showCallbackArrow = group.createFunctionCallAnimator('callback')
  showCallbackBlock = group.createAnimator
    selector: '#callback-block'
    before: (s)-> s.attr('opacity','0')
    change: (s)-> s.attr('opacity','1')
    delay: 200

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
