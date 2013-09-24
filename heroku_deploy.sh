#!/bin/sh -e
 
bundle install
git add -f Gemfile.lock

rake assets:precompile RAILS_ENV=production

git add public/assets
git commit -m 'Precompiling assets for heroku'
 
git push -f heroku master
 
git rm -rf public/assets
git rm -f Gemfile.lock
git commit -m 'Removing compiled assets'

