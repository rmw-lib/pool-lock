import os from 'os'


export default (_=undefined,max=os.cpus().length*2)=>
  if typeof(_) == "number"
    max = _
    _ = []
  else
    _ = _ or []

  n = 0
  todo = []
  (func, ...args)=>
    if func
      return new Promise((resolve, reject)=>
        _ = =>
          ++n
          resolve()
          try
            r = await func.apply(func, args)
          catch err
            _[1]?(err)
          finally
            --n
            todo.pop()?()
          _[0]? r

        if n < max
          _()
        else
          todo.push _
        return
      )
    Promise.all todo
