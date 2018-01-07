# Rails/Yarn Docker Image

Simple Docker image for Rails applications using Yarn, built with GitLab CI in mind.
This image is publicly available on [Docker Hub](https://hub.docker.com/r/psguazz/rails-yarn/) and [GitHub](https://github.com/psguazz/rails-yarn).

The point is to be able to test and deploy Rails/Yarn applications. As such, this image includes:
* Rails
* Yarn
* wkhtmltopdf
* Rubygems, along with the `dpl` gem
* Heroku CLI

Beyond these things, the image contains random utilities that have come in handy during testing -- the idea being that presumably having it installed them here from the get-go is faster than installing everything again every time tests are run.

Ruby and the `dpl` gem are used to deploy applications, as per [GitLab's docs](https://docs.gitlab.com/ce/ci/examples/deployment/README.html).

Here's a sample `.gitlat-ci.yml` file, again based off [GitLab's docs](https://docs.gitlab.com/ee/ci/examples/test-and-deploy-ruby-application-to-heroku.html) and extended with the Yarn commands:

````yaml
image: psguazz/rails-yarn

services:
  - postgres:9.6

variables:
  MIX_ENV: "test"
  POSTGRES_DB: "<db>"
  POSTGRES_USER: "<user>"
  POSTGRES_PASSWORD: "<password>"

test:
  script:
    - bundle install -j $(nproc)
    - bundle exec yarn install
    - bundle exec rails db:drop db:create db:schema:load
    - bundle exec rspec
    - bundle exec scss-lint
    - bundle exec rubocop

deploy:
  type: deploy
  script:
    - dpl --provider=heroku --app=$HEROKU_TEST_APP_NAME --api-key=$HEROKU_API_KEY
  environment:
    name: test
    url: https://$HEROKU_TEST_APP_NAME.herokuapp.com/
  only:
    - master
    - staging
    - test
````
