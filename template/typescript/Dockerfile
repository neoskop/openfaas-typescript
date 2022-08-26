FROM --platform=${TARGETPLATFORM:-linux/amd64} ghcr.io/openfaas/of-watchdog:0.9.6 as watchdog
FROM --platform=${TARGETPLATFORM:-linux/amd64} node:18.8.0-bullseye as ship

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG DEBUG
ENV DEBUG=${DEBUG}

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog
RUN npm i nodemon ts-node -g

RUN addgroup --system app && adduser --system --ingroup app app

# Turn down the verbosity to default level.
ENV NPM_CONFIG_LOGLEVEL warn

RUN chmod 777 /tmp


RUN mkdir -p /home/app/function

# Wrapper/boot-strapper
WORKDIR /home/app
COPY package.json ./

# This ordering means the npm installation is cached for the outer function handler.
RUN npm i

# Copy outer function handler
COPY index.ts ./
COPY *.sh ./
COPY tsconfig.json ./
COPY nodemon.json ./

# COPY function node packages and install, adding this as a separate
# entry allows caching of npm install

WORKDIR /home/app/function
COPY function/*.json ./

RUN npm i

# COPY function files and folders
COPY function/ ./

# Run any tests that may be available
RUN apt-get update && apt-get install jq -y
RUN test "$(jq '.scripts | has("test")' package.json)" = "false" || npm test

# Set correct permissions to use non root user
WORKDIR /home/app/

ENV cgi_headers="true"
ENV fprocess="bash ./start.sh"
ENV mode="http"
ENV upstream_url="http://127.0.0.1:3000"

ENV exec_timeout="10s"
ENV write_timeout="15s"
ENV read_timeout="15s"
ENV read_timeout="15s"

ENV prefix_logs="false"

RUN ./build.sh

RUN chown -R app:app /home/app
USER app

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
