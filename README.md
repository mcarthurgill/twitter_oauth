twitter_oauth
=============
So this twitter app works for multiple users, but you have to add your own environment variables with your twitter key and twitter secret. 

### Steps to run:

clone repo

cd into repo

run bundle install

run rake db:create

run rake db:migrate

add environment variables with twitter secret and twitter key

run shotgun

got to localhost:9393
