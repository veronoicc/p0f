FROM debian:latest AS build
WORKDIR /app
RUN apt-get update && apt-get -y --no-install-recommends install build-essential libpcap-dev
COPY . .
RUN chmod +x ./build.sh && make all

FROM debian:latest
WORKDIR /app
RUN apt-get update && apt-get -y --no-install-recommends install libpcap-dev
COPY --from=build /app/p0f /app/p0f
COPY p0f.fp /app/p0f.fp
RUN chmod +x p0f
ENTRYPOINT ["/app/p0f"]