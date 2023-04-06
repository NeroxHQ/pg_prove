FROM alpine:edge AS builder
RUN apk add --update --no-cache perl perl-dev perl-utils make wget curl build-base expat-dev
RUN curl -sL --compressed https://git.io/cpm > cpm && chmod +x cpm 
RUN ./cpm install --show-build-log-on-failure -L /usr/local XML::Simple 
RUN ./cpm install --show-build-log-on-failure -L /usr/local Test::Deep 
RUN ./cpm install --show-build-log-on-failure -L /usr/local TAP::Parser::SourceHandler::pgTAP 
RUN ./cpm install --show-build-log-on-failure -L /usr/local TAP::Harness::JUnit

FROM alpine:edge
RUN apk add --update perl postgresql-client
COPY --from=builder /usr/local /usr/local
ENV PERL5LIB /usr/local/lib/perl5
WORKDIR /tmp