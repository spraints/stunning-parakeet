FROM heroku/ruby

RUN curl -L -o /tmp/hugo.tar.gz https://github.com/spf13/hugo/releases/download/v0.15/hugo_0.15_linux_amd64.tar.gz
RUN mkdir -p /opt/hugo && cd /opt/hugo && tar xfvz /tmp/hugo.tar.gz
