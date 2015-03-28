#!/bin/sh

function js_dependency {
 gulp
}

function load_env {
 echo load_env
 MONGOLAB_URI=mongodb://localhost/simple
}

function deploy_prod {
 echo deploy to heroku ...
 git push heroku master
}

function build_local {
 echo build_local
}

function build_and_push {
echo push to github ...
 git push origin master
}

function usage {
  echo Usage:
  echo ======================
  echo a for git pull/local build/git push/deploy to stage
  echo d for deploy to stage
  echo p for git pull/local build/git push
  echo b for local build
  echo js for update javascript dependency
  echo none of the above will trigger local build only
  echo ======================
}

function main {
  	case $1 in
		js) js_dependency ;;
        a) build_and_push && deploy_prod;;
		d) load_env && deploy_prod;;
		p) build_and_push ;;
		b) build_local ;;
		h) usage ;;
		*) build_local ;;
	esac
}

main $@