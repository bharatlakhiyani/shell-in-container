FROM mhart/alpine-node:10.14.0
WORKDIR /app

COPY package.json /app/

RUN info(){ printf '\n--\n%s\n--\n\n' "$*"; } \
 && info '==> Installing build deps...' \
 && apk add --no-cache --virtual build-deps binutils-gold \
    gcc g++ git \
    linux-headers make musl-dev \
    python openssl-dev zlib-dev \
 && info '==> Installing NPM modules...' \
 && npm config set unsafe-perm true \
 && npm install -g npm \
 && npm update -g npm \
 && npm install --production \
 && mv node_modules node_modules_new \
 && info '==> Finishing...' \
 && apk del build-deps \
 && npm cache verify \
 && rm -rf ~/.node-gyp /tmp/* \
 && info '==> Deps installed! =)'

RUN chmod 755 /app/entrypoint.sh

COPY . /app

# Rename node_modules_new back to node_modules.
#
RUN rm -rf node_modules \
  && mv node_modules_new node_modules

EXPOSE 3000

CMD ["/app/entrypoint.sh"]
