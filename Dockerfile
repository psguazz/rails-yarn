FROM ruby:2.6.2

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qy && apt-get install -y apt-transport-https
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qy && apt-get install -y \
    nodejs \
    yarn

# Download and install wkhtmltopdf and its dependencies
RUN apt-get install -y build-essential xorg libssl-dev libxrender-dev
RUN apt-get install -y wkhtmltopdf

# Deployment!
RUN gem install dpl

CMD ["irb"]
