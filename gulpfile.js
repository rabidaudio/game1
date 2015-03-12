var gulp = require('gulp')
  , gutil = require('gulp-util')
  , del = require('del')
  , swank = require('swank')
  , browserify = require('gulp-browserify')
  , uglify = require('gulp-uglify')
  , concat  = require('gulp-concat')
  , coffee = require('gulp-coffee');


var paths = {
  main: 'src/main.js',
  out: 'dist',
  out_script: 'dist/build.js'
};

gulp.task('clean:js', function (cb) {
   del(paths.out_script, cb);
});

gulp.task('scripts', ['clean:js'], function () {
  gulp.src(paths.main)
    .pipe(browserify({
      transform: ['caching-coffeeify'],
      extensions: ['.coffee', '.js']
    }))
    // .pipe(uglify({
    //   compress: false,
    // }))
    .pipe(concat('build.js'))
    .pipe(gulp.dest(paths.out))
    .on('error', gutil.log);
});

gulp.task('watch', function () {
  gulp.watch(['src/**/*.js', 'src/**/*.coffee'], ['scripts']);
});

gulp.task('serve', function(cb){
  swank({
    watch: true,
    path: paths.out,
    log: true
  }, function(err, warn, url){
    gutil.log('Server running:', url);
    cb();
  });
});


gulp.task('default', ['scripts', 'watch', 'serve']);