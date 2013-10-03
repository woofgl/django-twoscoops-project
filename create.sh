#!/bin/sh
curDir="$(pwd)"
templateDir="$(dirname $(readlink -f $0))"
projectName=$1
projectDir=$1_project

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
mkdir $projectDir
 
django-admin.py startproject --template=$templateDir/template.zip --extension=py,rst,html $projectName $projectDir
cd $projectDir
hintDir=`pwd`
mkvirtualenv -a `pwd`/$projectName $projectName"-dev"
cd ..
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
pip install -r requirements/local.txt

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
touch $subProject
echo { >> $subProject
echo -e '\t' \"folders\": >> $subProject
echo -e '\t\t'   [ >> $subProject
echo -e '\t\t\t'        { >> $subProject
echo -e '\t\t\t\t'     \"follow_symlinks\": true, >> $subProject
echo -e '\t\t\t\t'     \"path\": \"$(cygpath -v `pwd`)\" >> $subProject
echo -e '\t\t\t'        } >> $subProject
echo -e '\t\t'    ] ,>> $subProject

echo -e '\t'  \"settings\": { >> $subProject
echo -e '\t\t'    \"python\": \"c:/Users/Administrator/.virtualenvs/$projectName-dev/Scripts/python\", >> $subProject
echo -e '\t\t'   \"extra_paths\": [  >> $subProject
echo -e '\t\t\t'       \"c:/Users/Administrator/.virtualenvs/$projectName-dev/Lib/site-packages\", >> $subProject 
echo -e '\t\t\t'           \"`cygpath -v $hintDir`\" >> $subProject
echo -e '\t\t'       ]  >> $subProject
echo -e '\t\t'   }  >> $subProject

echo -e '\t' } >> $subProject

# open project
exec d:/tools/sublime_text/sublime_text $subProject &

# workon $1"_dev"

