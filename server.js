var cluster = require('cluster');
var http = require('http');
var numCPUs = require('os').cpus().length;
var _ = require('underscore');
var fs = require('fs');

if (cluster.isMaster) {

    for (var i = 0; i < numCPUs; i++) {
        cluster.fork();
    }

    cluster.on('fork', function(worker, code, signal) {
        console.log('worker ' + worker.process.pid + ' started');
    });

    cluster.on('online', function(worker) {
        console.log("Yay, the worker responded after it was forked");
    });

    cluster.on('exit', function(worker, code, signal) {
        console.log('worker ' + worker.process.pid + ' died');
        cluster.fork();
    });

    fs.writeFileSync('./master.pid', process.pid, 'utf8');

    process.on('SIGUSR2', function() {
        _.each(cluster.workers, function(worker) {
            worker.destroy();
        })
    })

} else {

  require('./app');

}