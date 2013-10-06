#!/bin/sh -e

RAILS_ENV=production bundle exec rake assets:precompile

git add public/assets
git commit -m 'Precompiling assets for heroku'

git push -f heroku master
heroku run rake db:migrate

git rm -rf public/assets
git commit -m 'Removing compiled assets'


