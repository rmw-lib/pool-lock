# lock for promise

## Install

```
npm install -g @rmw/lock
```

## Use

```
import Lock from '@rmw/lock'
import sleep from 'await-sleep'

add = (a,b)=>
  console.log a,"+",b,"=",a+b
  await sleep(3000)

do =>
  lock = Lock(3)
  n = 10
  while --n
    await lock =>
      console.log "run", n
      await sleep(3000)

  n = 10
  while --n
    await lock add, n, n*2
  await lock()

```

Lock 参数限制了并发数，可以为空，为空默认为CPU数*2
