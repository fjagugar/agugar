FROM gcr.io/stacksmith-images/minideb-buildpack:jessie-r8

MAINTAINER Bitnami <containers@bitnami.com>

ENV STACKSMITH_STACK_ID="8eq5y2w" \
    STACKSMITH_STACK_NAME="Ruby 2.4.0 on minideb" \
    STACKSMITH_STACK_PRIVATE="1"

# Install required system packages
RUN install_packages libc6 libssl1.0.0 zlib1g libreadline6 libncurses5 libtinfo5 libffi6 libxml2-dev zlib1g-dev libxslt1-dev libgmp-dev ghostscript imagemagick libmysqlclient18 libpq5

RUN bitnami-pkg install ruby-2.4.0-0 --checksum 189d7da38f702086231ddf371b41ddc8b29382147522d7dad399bbdb7944d958

ENV PATH=/opt/bitnami/ruby/bin:$PATH

# Ruby base template
COPY Gemfile* /app/
WORKDIR /app

RUN bundle install

EXPOSE 4567

CMD ["middleman", "build"]
