FROM golang:alpine AS source
WORKDIR /app
RUN apk add git && git clone https://github.com/hashicorp/terraform.git
RUN cd terraform && go install

FROM alpine:latest
WORKDIR /app
COPY --from=source /go/bin/terraform .
ENTRYPOINT ["/app/terraform", "-chdir=/app/tf-files"]
