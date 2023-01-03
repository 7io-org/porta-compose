FROM nginx:1.22.1

ENV NGINX_VERSION "1.22.1"

RUN apt-get update && apt-get install -y --no-install-recommends lsb-release git
RUN echo "deb-src http://nginx.org/packages/debian/ $(lsb_release -cs) nginx" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y dpkg-dev curl \
  && mkdir -p /opt/rebuildnginx \
  && chmod 0777 /opt/rebuildnginx \
  && cd /opt/rebuildnginx \
  && su --preserve-environment -s /bin/bash -c "apt-get source nginx" _apt \
  && apt-get build-dep -y "nginx=${NGINX_VERSION}"
RUN cd /opt \
  && git clone https://github.com/GUI/nginx-upstream-dynamic-servers.git \
  && ls -alh /opt \
  && ls -alh /opt/rebuildnginx \
  && ls -alh "/opt/rebuildnginx/nginx-${NGINX_VERSION}" \
  && sed -i -r -e "s/\.\/configure(.*)/.\/configure\1 --add-module=\/opt\/nginx-upstream-dynamic-servers/" "/opt/rebuildnginx/nginx-${NGINX_VERSION}/debian/rules" \
  && cd "/opt/rebuildnginx/nginx-${NGINX_VERSION}" \
  && dpkg-buildpackage -b \
  && cd /opt/rebuildnginx \
  && dpkg --install nginx_${NGINX_VERSION}-*~$(lsb_release -cs)_amd64.deb \
  \
  && apt-get remove --purge -y dpkg-dev curl \
  && apt-get -y --purge autoremove \
  && rm -rf /var/lib/apt/lists/* /opt/rebuildnginx /opt/nginx-upstream-dynamic-servers

COPY "./entrypoint.sh" "/entrypoint.sh"
COPY "./resolver.conf" "/resolver.conf.template"

CMD ["sh", "/entrypoint.sh"]
