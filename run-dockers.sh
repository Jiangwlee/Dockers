# Build final image
ARG ImageTag='latest'
ARG User
FROM ${USER}/ueransimbase:${ImageTag} AS builder
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=nointeractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libsctp-dev \
        lksctp-tools \
        iproute2 \
        iptables \
        netbase \
        ifupdown \
        net-tools \
        iputils-ping && \
    apt-get autoremove -y && apt-get autoclean

COPY --from=builder /UERANSIM/build /UERANSIM/build
COPY --from=builder /UERANSIM/config /UERANSIM/config
COPY --from=builder /UERANSIM/Version.txt /UERANSIM/Version.txt

# Set the working directory to UERANSIM
WORKDIR UERANSIM/

ENV AMF_IP=172.17.0.1 SUPI=imsi-208930000000003 SLEEP=5
COPY config/ ./config
COPY run.sh .
CMD ["/bin/bash", "/UERANSIM/run.sh"]