window.nico.animationGroup 'simple-async-ajax', (group)->

  paramPath = group.container.select('#post-params-path')[0][0]

  showPostArrow = group.createAnimator
    selector: '#post-arrow'
    before: (s)-> 
      @origx2 = s.attr('x2')
      s.attr
        x2: s.attr('x1')
        visibility: 'hidden'
    pre: (s)-> s.attr('visibility','visible')
    change: (s)-> s.attr('x2',@origx2)


  showPostText = group.createAnimator
    selector: '#post-text'
    before: (s)-> s.attr('opacity','0')
    change: (s)-> s.attr('opacity','1')
    delay: 200

  sendPostParams = group.createAnimator
    selector: '#post-params'
    before: (s)-> s.attr(visibility:'hidden')
    pre: (s)-> s.attr(visibility: 'visible')
    change: (transition)->
      transition.translateAlongPath(paramPath)

  sendCallback = group.createAnimator
    delay: 500
    selector: '#callback-param'
    before: (s)-> s.attr(visibility:'hidden')
    pre: (s)-> s.attr(visibility: 'visible')
    change: (transition)->
      transition.translateAlongPath(paramPath)

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

  showAddUserReturn = group.createAnimator
    selector: '#add-user-return-arrow'
    before: (s)-> 
      @origx2 = s.attr('x2')
      s
        .attr('x2', s.attr('x1'))
        .attr('visibility', 'hidden')
    pre: (s)-> s.attr('visibility','visible')
    change: (s)-> s.attr('x2',@origx2)

  showSecondStageOfAjaxCall = group.createAnimator
    selector: '#ajax-second-stage-block'
    before: (s)-> s.attr( opacity: 0 )
    change: (t)-> t.attr( opacity: 1 )

  showCallbackArrow = group.createAnimator
    selector: '#callback-arrow'
    before: (s)-> 
      @origx2 = s.attr('x2')
      s.attr
        x2: s.attr('x1')
        visibility: 'hidden'
    pre: (s)-> s.attr('visibility','visible')
    change: (s)-> s.attr('x2',@origx2)

  showCallbackText = group.createAnimator
    selector: '#callback-text'
    before: (s)-> s.attr('opacity','0')
    change: (s)-> s.attr('opacity','1')
    delay: 200
  showCallbackBlock = group.createAnimator
    selector: '#callback-block'
    before: (s)-> s.attr('opacity','0')
    change: (s)-> s.attr('opacity','1')
    delay: 200

  showPostArrow.simulAnimate(showPostText)
  showPostArrow.postAnimate(sendPostParams)
  sendPostParams.postAnimate( sendCallback )
  sendCallback.simulAnimate( fadePostParams )
  sendCallback.postAnimate( showAddUserReturn ) 
  showAddUserReturn.postAnimate( showSecondStageOfAjaxCall ) 
  showSecondStageOfAjaxCall.postAnimate( showCallbackArrow ) 
  showCallbackArrow.simulAnimate(showCallbackText)
  showCallbackArrow.simulAnimate(showCallbackBlock)
  showCallbackArrow.postAnimate(showCallbackTunnel)
  
  group.firstAnimation( showPostArrow )
 

  #do wireUpBulletPoints = ->
    #$stagesList = $('.simple-sync-ajax-test ol')

    #nico.updateCharredTrailList($stagesList, 'call-add-user')
    #movePostParamsToFake.on 'animate:did-start', -> nico.updateCharredTrailList($stagesList,'send-post-params')
    #returnPostParams.on 'animate:did-start', -> nico.updateCharredTrailList($stagesList,'lookup-post-params')