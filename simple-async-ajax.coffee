window.nico.animationGroup 'simple-async-ajax', (group)->

  paramPath = group.container.select('#post-params-path')[0][0]

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
    duration: 200
    before: (s)-> s.attr( opacity: 0 )
    change: (t)-> t.attr( opacity: 1 )

  sendPostParams.postAnimate( sendCallback )
  sendCallback.simulAnimate( fadePostParams )
  sendCallback.postAnimate( showCallbackTunnel ) 
  
  group.firstAnimation( sendPostParams )
 

  #do wireUpBulletPoints = ->
    #$stagesList = $('.simple-sync-ajax-test ol')

    #nico.updateCharredTrailList($stagesList, 'call-add-user')
    #movePostParamsToFake.on 'animate:did-start', -> nico.updateCharredTrailList($stagesList,'send-post-params')
    #returnPostParams.on 'animate:did-start', -> nico.updateCharredTrailList($stagesList,'lookup-post-params')
