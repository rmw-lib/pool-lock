import os from 'os'


export default (max=os.cpus().length*2)=>
  n = 0
  todo = []
  alldone_resolve = undefined
  (func, ...args)=>
    if func
      return new Promise((resolve, reject)=>
        _ = =>
          ++n
          resolve()
          try
            await func(...args)
          finally
            await todo.shift()?()
            --n
            if n == 0
              alldone_resolve?()

        if n < max
          _()
        else
          todo.push _
        return
      )
    await Promise.all todo
    if n == 0
      return
    await new Promise(
      (resolve)=>
        alldone_resolve = resolve
    )
    return
