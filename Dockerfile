FROM alpine/git
RUN apk -Uuv add jq curl
ADD asana.sh /bin/
RUN chmod +x /bin/asana.sh
ENTRYPOINT /bin/asana.sh
