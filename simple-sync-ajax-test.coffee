window.nico.animationGroup 'simple-sync-ajax-test', (group)->

  movePostParamsToFake = group.createAnimator
    selector: '#post-params'
    before: (s)-> 
      s.attr('visibility','hidden')
          
    pre: (s)->
      s.attr('visibility','visible')

    change: (transition)->
      path = group.container.select('#post-params-path-1')[0][0]
      transition.translateAlongPath(path)

  returnPostParams = group.createAnimator
    delay: 1000
    duration: 1500
    selector: '#post-params'
    change: (transition)->
      transition.translateAlongPath('post-params-path-2')


  movePostParamsToFake.postAnimate( returnPostParams )
  
  group.firstAnimation( movePostParamsToFake )
 

  do wireUpBulletPoints = ->
    $stagesList = $('.simple-sync-ajax-test ol')

    nico.updateCharredTrailList($stagesList, 'call-add-user')
    movePostParamsToFake.on 'animate:did-start', -> nico.updateCharredTrailList($stagesList,'send-post-params')
    returnPostParams.on 'animate:did-start', -> nico.updateCharredTrailList($stagesList,'lookup-post-params')
