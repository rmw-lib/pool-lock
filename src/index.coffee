import os from 'os'


export default (max=os.cpus().length*2)=>
  n = 0
  todo = []
  (func, ...args)=>
    if func
      return new Promise((resolve, reject)=>
        _ = =>
          ++n
          resolve()
          try
            await func(...args)
          finally
            todo.shift()?()
            --n

        if n < max
          _()
        else
          todo.push _
        return
      )
    Promise.all todo
