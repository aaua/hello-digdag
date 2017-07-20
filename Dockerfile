FROM centos:7

MAINTAINER https://github.com/aaua/hello-digdag

ENV DIGDAG_VERSION=latest

# system update
RUN yum -y update && yum clean all

# set locale
RUN yum reinstall -y glibc-common && yum clean all
ENV LANG ja_JP.utf-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.utf-8
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime

# digdag install
RUN yum install -y java-1.8.0-openjdk && \
  curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-${DIGDAG_VERSION}" && \
  chmod +x /usr/local/bin/digdag && \
  echo 'export PATH="$HOME/bin:$PATH"' >> /etc/bashrc && \
  mkdir -p ~/.config/digdag && \
  touch ~/.config/digdag/config && \
  echo 'client.http.endpoint=http://localhost:80' >> ~/.config/digdag/config && \
  mkdir -p /var/log/digdag

EXPOSE 80
CMD exec digdag server -m --bind 0.0.0.0 --port 80 --task-log /var/log/digdag/task_log.log
