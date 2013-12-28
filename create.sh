#!/bin/bash
curDir="$(pwd)"
templateDir="$(dirname $(readlink -f $0))"
projectName=$1
projectDir=$1_project

export  DJANGO_SETTINGS_MODULE=

# OS specific support.  $var _must_ be set to either true or false.
cygwin=false;
darwin=false;
mingw=false
pyi=bin/python
case "`uname`" in
  CYGWIN*) cygwin=true ;;
  MINGW*) mingw=true;;
esac

# echo $(basename $templateDir)
# echo $curDir
# echo "scriptPath1: "$(cd `dirname $0`; pwd)
# echo "scriptPath2: "$(pwd)
# echo "scriptPath3: "$(dirname $(readlink -f $0))
 # echo "source: "`which 'virtualenvwrapper_lazy.sh'`
# if $mingw; then
    source virtualenvwrapper.sh
# fi

cd $templateDir
set templateDir=$(pwd)
echo $templateDir
rm -f template.zip
# # zip -q -r  template.zip ../$(basename $templateDir)/*
zip -x create.sh  -q -r template.zip ./*
 cd $curDir
 # echo $projectDir
 mkdir $projectDir
 if $mingw; then
   WORKON_HOME=$(cygpath -v $WORKON_HOME)
 fi
 if $mingw; then
     mkvirtualenv $projectName"-dev"
 else
     cpvirtualenv base $projectName"-dev"
 fi

 workon $projectName"-dev"

 if $mingw; then
    pip install django
   # echo ""
 else
     pip-accel install django
 fi

 cd $curDir
 # echo  -e "django-admin.py startproject --template=$templateDir/template.zip --extension=py,rst,html,sh $projectName $projectDir" 
 django-admin.py startproject --template=$templateDir/template.zip  \
     --extension=py,rst,html,sh $projectName $projectDir
  cd $curDir/$projectDir
  hintDir=`pwd`
  # mkvirtualenv -a `pwd`/$projectName $projectName"-dev"
  setvirtualenvproject
  add2virtualenv $curDir/$projectDir/$projectName
  # cd ..
  # cd $projectDir
  touch .gitignore
  echo .idea >>.gitignore
  echo .codeintel >>.gitignore
  echo *.pyc >>.gitignore
   # mkvirtualenv $1"_dev"

   # virEnv=$(cygpath -v $(pwd))
    # virEnv=$(basename $(pwd))
   # echo $virEnv
   # add2virtualenv $virEnv
  # init git flow
  git flow init -d
  if $mingw; then
      pip install -r requirements/local.txt
  else
      pip-accel install -r requirements/local.txt
  fi

  # mkdir .codeintel
  # cd .codeintel
  # touch config
  # # create config file

  # # workon $1"_dev"

