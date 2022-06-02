# Prepare the base environment.
FROM dbcawa/ledgergw:latest as builder_base_ledgergwdev

RUN apt-get update
RUN apt-get install nginx

EXPOSE 80
HEALTHCHECK --interval=1m --timeout=5s --start-period=10s --retries=3 CMD ["wget", "-q", "-O", "-", "http://localhost:80/"]
CMD ["/startup.sh"]
