#!/bin/sh -e
 
rake assets:precompile

git add public/assets
git commit -m 'Precompiling assets for heroku'
 
git push heroku master
 
git rm -r public/assets
git commit -m 'Removing compiled assets'
