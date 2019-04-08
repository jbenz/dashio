ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Setup
RUN apk add --no-cache -U python3 python3-dev gcc linux-headers musl-dev tcpdump \
    && pip3 install --no-cache --upgrade pip
COPY requirements.txt /tmp/
RUN pip3 install -r /tmp/requirements.txt

# Copy data for add-on
COPY dashio.py /

# Build arugments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION
ARG BUILD_ARCH

# Labels
LABEL \
    io.hass.name="dasshio - Amazon Dash Buttons" \
    io.hass.description="Easy integration of Amazon Dash buttons with Home Assistant instance" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="jbenz <jbenz@3fifty.net>" \
    org.label-schema.description="Easy integration of Amazon Dash buttons with Home Assistant instance" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="dashio" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/t/dasshio-amazon-dash-buttons-hass-io-add-on" \
    org.label-schema.usage="https://github.com/jbenz/dashio/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/jbenz/dashio" \
    org.label-schema.vendor="Dash Hass.io Add-on"

RUN chmod a+x /dashio.py
ENTRYPOINT ["python3", "/dashio.py"]
