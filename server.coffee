cluster = require('cluster')
http = require('http')
numCPUs = require('os').cpus().length
_ = require('underscore')
fs = require('fs')
if cluster.isMaster
  i = 0

  while i < numCPUs
    cluster.fork()
    i++
  cluster.on 'fork', (worker, code, signal) ->
    console.log 'worker ' + worker.process.pid + ' started'

  cluster.on 'online', (worker) ->
    console.log 'Yay, the worker responded after it was forked'

  cluster.on 'exit', (worker, code, signal) ->
    console.log 'worker ' + worker.process.pid + ' died'
    cluster.fork()

  fs.writeFileSync './master.pid', process.pid, 'utf8'
  process.on 'SIGUSR2', ->
    _.each cluster.workers, (worker) ->
      worker.destroy()


else
  require './app'
