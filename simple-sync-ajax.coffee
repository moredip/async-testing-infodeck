createAnimator = window.nico.createAnimator

showPostArrow = createAnimator
  selector: '#post-arrow'
  before: (s)-> 
    @origx2 = s.attr('x2')
    s.attr('x2', s.attr('x1'))
  change: (s)-> s.attr('x2',@origx2)


showPostText = createAnimator
  selector: '#post-text'
  before: (s)-> s.attr('opacity','0')
  change: (s)-> s.attr('opacity','1')
  delay: 200

showPostBody = createAnimator
  selector: '#post-body'
  before: (s)-> 
    s.attr('fill-opacity','0.2')
  change: (s)-> s.attr('fill-opacity','1')
  duration: 1000

showPostReturn = createAnimator
  selector: '#post-return-arrow'
  before: (s)-> 
    @origx2 = s.attr('x2')
    s
      .attr('x2', s.attr('x1'))
      .attr('visibility', 'hidden')
  pre: (s)-> s.attr('visibility','visible')
  change: (s)-> s.attr('x2',@origx2)

showAddUserReturn = createAnimator
  selector: '#add-user-return-arrow'
  before: (s)-> 
    @origx2 = s.attr('x2')
    s
      .attr('x2', s.attr('x1'))
      .attr('visibility', 'hidden')
  pre: (s)-> s.attr('visibility','visible')
  change: (s)-> s.attr('x2',@origx2)




showPostReturn.on 'animate:did-end', ->
  console.log('post return shown')

showPostArrow.simulAnimate(showPostText)
showPostText.postAnimate(showPostBody)
showPostBody.postAnimate(showPostReturn)
showPostReturn.postAnimate(showAddUserReturn)

showPostArrow.prep()
showPostText.prep()
showPostBody.prep()
showPostReturn.prep()
showAddUserReturn.prep()

showPostArrow.animate()
