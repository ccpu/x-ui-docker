FROM golang:latest AS builder
WORKDIR /root
COPY . .
RUN go build main.go


FROM debian:11-slim
RUN apt-get update && apt-get install -y --no-install-recommends -y ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# https://github.com/moby/moby/issues/2259
# Only root use have access to volume
RUN useradd -ms /bin/bash 8877 pwuser
WORKDIR /home/pwuser
COPY --from=builder  /root/main /home/pwuser/x-ui
COPY bin/. /home/pwuser/bin/.
RUN chown -R pwuser:pwuser /home/pwuser/bin/
USER pwuser

# WORKDIR /root
# COPY --from=builder  /root/main /root/x-ui
# COPY bin/. /root/bin/.

VOLUME [ "/etc/x-ui" ]
CMD [ "./x-ui" ]