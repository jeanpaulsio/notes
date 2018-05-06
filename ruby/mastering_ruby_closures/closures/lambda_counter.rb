Counter = lambda do
  x     = 0
  get_x = -> { x }
  inc   = -> { x += 1 }
  dec   = -> { x -= 1 }

  { get_x: get_x, inc: inc, dec: dec }
end
