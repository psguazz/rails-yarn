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
RUN apt-get install -y --force-yes xvfb
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN tar xvf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN mv wkhtmltox/bin/wkhtmltopdf /usr/bin
RUN rm wkhtmltox-0.12.4_linux-generic-amd64.tar.xz  && rm -rf wkhtmltox

# Deployment!
RUN gem install dpl

CMD ["irb"]
