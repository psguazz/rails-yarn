FROM ruby:2.5.3

RUN apt-get update -qy && apt-get install -y apt-transport-https
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qy && apt-get install -y \
    nodejs \
    yarn

RUN gem install dpl

CMD ["irb"]
