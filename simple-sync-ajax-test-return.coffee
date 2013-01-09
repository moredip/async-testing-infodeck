window.nico.animationGroup 'simple-sync-ajax-test-return', (group)->

  showPostArrow = group.createFunctionCallAnimator('set-fake-post-response')

  movePostResponseToFake = group.createAnimator
    selector: '#post-response'
    delay: 200
    before: (s)-> 
      s.attr('visibility','hidden')
          
    pre: (s)->
      s.attr('visibility','visible')

    change: (transition)->
      path = group.container.select('#post-response-path-1')[0][0]
      transition.translateAlongPath(path)

  do wireUpAnimationSequence = ->
    showPostArrow.simulAnimate(movePostResponseToFake)

    group.firstAnimation( showPostArrow )
