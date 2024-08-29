FROM golang:1.23-alpine AS builder
RUN go install github.com/trazfr/freebox-exporter@latest

FROM alpine:3.12
COPY --from=builder /go/bin/freebox-exporter /usr/local/bin/freebox-exporter
VOLUME /config
ENTRYPOINT ["/usr/local/bin/freebox-exporter", "-httpDiscovery", "/config/token.json"]
EXPOSE 9091
