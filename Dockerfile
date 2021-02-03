FROM alpine AS builder

RUN apk --no-cache add go git
COPY . /go/src/matterbridge
RUN cd /go/src/matterbridge \
  && CGO_ENABLED=0 go build -mod vendor -ldflags "-X main.githash=$(git log --pretty=format:'%h' -n 1)" -o /bin/matterbridge

# FROM alpine
# RUN apk --no-cache add ca-certificates mailcap
# COPY --from=builder /bin/matterbridge /bin/matterbridge
# RUN mkdir /etc/matterbridge \
#   && touch /etc/matterbridge/matterbridge.toml \
#   && ln -sf /matterbridge.toml /etc/matterbridge/matterbridge.toml
# ENTRYPOINT ["/bin/matterbridge", "-debug", "-conf", "/etc/matterbridge/matterbridge.toml"]
