FROM golang:alpine AS build
ARG TARGETPLATFORM
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && go get github.com/mitchellh/gox && apk add --no-cache upx
ENV GOPROXY=https://goproxy.cn,direct
COPY . /src/
WORKDIR /src
RUN echo "TargetPlatform: $TARGETPLATFORM" && gox -osarch=$TARGETPLATFORM -ldflags="-w -s" -output="httpd" && upx -9 -q httpd

FROM --platform=$TARGETPLATFORM alpine:3.14
WORKDIR /app
COPY --from=build /src/httpd /src/html ./
EXPOSE 8080
CMD ["sh", "./startup.sh"]
