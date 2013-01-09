window.nico.animationGroup 'simple-sync-ajax-test-return', (group)->

  showSetFakePostResponse = group.createFunctionCallAnimator('set-fake-post-response')
  showAddUser = group.createFunctionCallAnimator 'add-user',
    delay: 1000
  showPost = group.createFunctionCallAnimator( 'post' )
  showPostReturn = group.createFunctionCallAnimator( 'post-return', noText:true )
  showAddUserReturn = group.createFunctionCallAnimator( 'add-user-return', noText:true )

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
    showSetFakePostResponse.simulAnimate(movePostResponseToFake)

    showSetFakePostResponse.postAnimate(showAddUser)
    showAddUser.postAnimate(showPost)

    showPost.postAnimate(showPostReturn)
    showPostReturn.postAnimate(showAddUserReturn)

    group.firstAnimation( showSetFakePostResponse )
