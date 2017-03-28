#!/bin/bash
DIR="$1";
mkdir $DIR/build $DIR/build/css $DIR/build/js $DIR/dist;
touch $DIR/build/js/main.js $DIR/build/css/9-style.css;
cp $HOME/bin/templates/package.json $DIR;
cp $HOME/bin/templates/index.html $DIR/build;
cp $HOME/bin/templates/1-normalize.css $DIR/build/css
npm --prefix $DIR install $DIR;
npm --prefix $DIR run build;