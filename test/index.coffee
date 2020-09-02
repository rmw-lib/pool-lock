#!/usr/bin/env coffee

import Lock from '../src/index'
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

