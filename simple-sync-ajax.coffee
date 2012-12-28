createAnimator = window.nico.createAnimator

showPostArrow = createAnimator
  selector: '#post-arrow'
  before: (s)-> 
    @origx2 = s.attr('x2')
    s.attr('x2', s.attr('x1'))
  change: (s)-> s.attr('x2',@origx2)
  next: -> showPostText

showPostText = createAnimator
  selector: '#post-text'
  before: (s)-> s.attr('opacity','0')
  change: (s)-> s.attr('opacity','1')
  next: -> showPostBody

showPostBody = createAnimator
  selector: '#post-body'
  before: (s)-> 
    s.attr('fill-opacity','0.2')
  change: (s)-> s.attr('fill-opacity','1')
  next: -> showPostReturn

showPostReturn = createAnimator
  selector: '#post-return-arrow'
  before: (s)-> 
    @origx2 = s.attr('x2')
    s
      .attr('x2', s.attr('x1'))
      .attr('visibility', 'hidden')
  pre: (s)-> s.attr('visibility','visible')
  change: (s)-> s.attr('x2',@origx2)

showPostArrow.prep()
showPostText.prep()
showPostBody.prep()
showPostReturn.prep()

showPostArrow.animate()
