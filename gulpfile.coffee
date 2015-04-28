gulp = require 'gulp'
bowerFiles = require 'main-bower-files'
browserify = require 'browserify'
coffeeify = require 'coffeeify'
vinylSourceStream = require 'vinyl-source-stream'

paths =
	build: 'dist/'

gulp.task 'default', ->
    console.log 'mmm, coffee!'

gulp.task 'clean', (done) ->
	del = require 'del'	
	del paths.build, done

gulp.task 'vendor', ->
	gulp.src bowerFiles()
		.pipe gulp.dest paths.build

gulp.task 'build', ['build-html']

gulp.task 'build-html', ->
	gulp.src './src/index.html'
		.pipe gulp.dest paths.build

gulp.task 'build-js', ->
	b = browserify {
		entries: './src/regexellent.coffee'
		debug: true
		transform: [coffeeify]
	}
	b.bundle()
		.pipe vinylSourceStream 'regexellent.js'
		.pipe gulp.dest paths.build