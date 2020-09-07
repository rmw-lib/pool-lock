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
            await (func.apply(func, args).then(... _))
          finally
            --n
            todo.pop()?()

        if n < max
          _()
        else
          todo.push _
        return
      )
    Promise.all todo
