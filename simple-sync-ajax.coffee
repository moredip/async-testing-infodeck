createAnimator = window.nico.createAnimator

animate1 = createAnimator
  selector: '#post-arrow'
  before: (s)-> 
    @origx2 = s.attr('x2')
    s.attr('x2', s.attr('x1'))
  change: (s)-> s.attr('x2',@origx2)
  next: -> animate2

animate2 = createAnimator
  selector: '#post-text'
  before: (s)-> s.attr('opacity','0')
  change: (s)-> s.attr('opacity','1')
  next: -> animate3

animate3 = createAnimator
  selector: '#post-return-arrow'
  before: (s)-> 
    @origx2 = s.attr('x2')
    s
      .attr('x2', s.attr('x1'))
      .attr('visibility', 'hidden')
  pre: (s)-> s.attr('visibility','visible')
  change: (s)-> s.attr('x2',@origx2)

animate1.prep()
animate2.prep()
animate3.prep()

animate1.animate()
