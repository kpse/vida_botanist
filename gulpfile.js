var gulp = require('gulp'),
  gulpif = require('gulp-if'),
  less = require('gulp-less'),
  path = require('path'),
  autoprefixer = require('gulp-autoprefixer'),
  minifycss = require('gulp-minify-css'),
  jshint = require('gulp-jshint'),
  concat = require('gulp-concat'),
  uglify = require('gulp-uglify'),
  rename = require('gulp-rename'),
  notify = require('gulp-notify'),
  coffee = require('gulp-coffee'),
  browserify = require('gulp-browserify'),
  del = require('del');

var paths = {
  scripts: ['./public/javascripts/**/*'],
  styles: ['./public/stylesheets/**/*.less'],
  templates: ['./views/**/*.jade']
};


gulp.task('styles', function () {
  return gulp.src(paths.styles)
    .pipe(less({
      paths: [path.join(__dirname, 'less', 'includes')]
    }))
    .pipe(autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'))
    .pipe(gulp.dest('dist/assets/css'))
    .pipe(rename({suffix: '.min'}))
    .pipe(minifycss())
    .pipe(gulp.dest('dist/assets/css'))
    .pipe(notify({message: 'Styles task complete'}));
});

gulp.task('scripts', function() {
  return gulp.src(paths.scripts, { read: false })
    .pipe(jshint())
    .pipe(jshint.reporter('default'))
    .pipe(browserify({
      transform: ['coffeeify'],
      extensions: ['.coffee']
    }))
    .pipe(concat('main.js', {newLine: ';'}))
    .pipe(gulp.dest('dist/assets/js'))
    .pipe(rename({suffix: '.min'}))
    .pipe(uglify())
    .pipe(gulp.dest('dist/assets/js'))
    .pipe(notify({ message: 'Scripts task complete' }));
});


gulp.task('clean', function(cb) {
  del(['dist/assets/css', 'dist/assets/js'], cb)
});

gulp.task('default', ['clean'], function() {
  gulp.start('styles', 'scripts');
});


gulp.task('watch', ['default'], function() {
  gulp.watch(paths.scripts, ['scripts']);
  gulp.watch(paths.styles, ['styles']);
});