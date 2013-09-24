#!/bin/sh -e
 
bundle install

rake assets:precompile RAILS_ENV=production

git add -f Gemfile.lock
git add public/assets
git commit -m 'Precompiling assets for heroku'
 
git push -f heroku master
 
git rm -r public/assets
git rm -f Gemfile.lock
git commit -m 'Removing compiled assets'

