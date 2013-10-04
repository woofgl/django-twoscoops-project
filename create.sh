#!/bin/bash
curDir="$(pwd)"
templateDir="$(dirname $(readlink -f $0))"
projectName=$1
projectDir=$1_project

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
rm -f template.zip
# zip -q -r  template.zip ../$(basename $templateDir)/* 
zip -x create.sh  -q -r template.zip ./* 
cd $curDir 
mkdir $projectDir
if $mingw; then
    mkvirtualenv $projectName"-dev"
else
    cpvirtualenv base $projectName"-dev"
fi

if $mingw; then
   pip install django
else
    pip-accel install django
fi
 
django-admin.py startproject --template=$templateDir/template.zip --extension=py,rst,html $projectName $projectDir
cd $projectDir
hintDir=`pwd`
# mkvirtualenv -a `pwd`/$projectName $projectName"-dev"
setvirtualenvproject
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

# echo  { >> config
# echo -e '\t' '"Python"': { >>config
# echo -e '\t\t'    \"python\": \"c:/Users/Administrator/.virtualenvs/$projectName-dev/Scripts/python\", >> config 
# echo -e '\t\t'     \"pythonExtraPaths\": [ >> config
# echo -e '\t\t\t\t'       \"c:/Users/Administrator/.virtualenvs/$projectName-dev/Lib/site-packages\", >>config 
# echo -e '\t\t\t\t'           \"`cygpath -v $hintDir`\" >> config
# echo -e '\t\t\t'        ] >> config 
# echo -e '\t'    } >> config
# echo } >> config

# # create sublime project
# cd ..
subProject=$projectName.sublime-project
if $mingw; then
  VIRTUALENVWRAPPER_HOOK_DIR=$(cygpath -v $VIRTUALENVWRAPPER_HOOK_DIR)
  hintDir=$(cygpath -v $hintDir) 
  pyi="Scripts/python"
fi
touch $subProject
echo { >> $subProject
echo -e '\t' \"folders\": >> $subProject
echo -e '\t\t'   [ >> $subProject
echo -e '\t\t\t'        { >> $subProject
echo -e '\t\t\t\t'     \"follow_symlinks\": true, >> $subProject
echo -e '\t\t\t\t'     \"path\": \"$hintDir\" >> $subProject
echo -e '\t\t\t'        } >> $subProject
echo -e '\t\t'    ] ,>> $subProject

echo -e '\t'  \"settings\": { >> $subProject
echo -e '\t\t'    \"python_interpreter\": \"$VIRTUALENVWRAPPER_HOOK_DIR/$projectName-dev/$pyi\", >> $subProject
echo -e '\t\t'   \"extra_paths\": [  >> $subProject
echo -e '\t\t\t'       \"$VIRTUALENVWRAPPER_HOOK_DIR/$projectName-dev/Lib/site-packages\", >> $subProject 
echo -e '\t\t\t'           \"$hintDir\" >> $subProject
echo -e '\t\t'       ]  >> $subProject
echo -e '\t\t'   }  >> $subProject

echo -e '\t' } >> $subProject

# open project
if $mingw; then
    exec d:/tools/sublime_text/sublime_text $subProject &
else
    exec /opt/sublime_text_3/sublime_text $subProject &
fi

# workon $1"_dev"

