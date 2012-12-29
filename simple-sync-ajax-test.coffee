window.nico.animationGroup '.slide.simple-sync-ajax-test', (group)->

  movePostParamsToFake = group.createAnimator
    selector: '#post-params'
    before: (s)-> 
      s.attr('visibility','hidden')
          
    pre: (s)->
      s.attr('visibility','visible')

    change: (transition)->
      transition.translateAlongPath('post-params-path-1')

  returnPostParams = group.createAnimator
    delay: 1000
    duration: 1500
    selector: '#post-params'
    change: (transition)->
      transition.translateAlongPath('post-params-path-2')


  movePostParamsToFake.postAnimate( returnPostParams )
  
  movePostParamsToFake.animate()
