#!/bin/sh
curDir="$(pwd)"
templateDir="$(dirname $(readlink -f $0))"
projectDir=$1

# echo $(basename $templateDir)
# echo $curDir
# echo "scriptPath1: "$(cd `dirname $0`; pwd)
# echo "scriptPath2: "$(pwd)
# echo "scriptPath3: "$(dirname $(readlink -f $0))
 # echo "source: "`which 'virtualenvwrapper_lazy.sh'`
source virtualenvwrapper.sh

cd $templateDir
rm -f template.zip
# zip -q -r  template.zip ../$(basename $templateDir)/* 
zip -x create.sh  -q -r template.zip ./* 
cd $curDir
# mkdir $projectDir
 
django-admin.py startproject --template=$templateDir/template.zip --extension=py,rst,html $projectDir
cd $curDir
mkvirtualenv -a $projectDir $projectDir"-dev"
# cd $projectDir
 # mkvirtualenv $1"_dev"

 # virEnv=$(cygpath -v $(pwd))
  # virEnv=$(basename $(pwd))
 # echo $virEnv
 # add2virtualenv $virEnv
git flow init
# workon $1"_dev"

