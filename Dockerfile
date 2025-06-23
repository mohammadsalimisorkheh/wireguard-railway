FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# نصب WireGuard و ابزارهای مورد نیاز
RUN apt-get update && apt-get install -y \
    wireguard \
    iproute2 \
    iptables \
    curl \
    nano \
    procps \
 && apt-get clean

# اضافه کردن اسکریپت ورود
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
