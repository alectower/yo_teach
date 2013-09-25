#!/bin/sh -e
 
rake assets:precompile RAILS_ENV=production

git add public/assets
git commit -m 'Precompiling assets for heroku'
 
git push -f heroku master
 
git rm -rf public/assets
git commit -m 'Removing compiled assets'

