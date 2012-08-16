module.exports = function(grunt) {


  // Project configuration.
  grunt.initConfig({
    lint: {
        all: ['server.js', 'app/*/*.js', 'grunt.js']
    }
  });


};