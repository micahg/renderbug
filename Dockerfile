FROM nginx:stable-alpine


# Github Action is a secondary step that pulls tgz rather than working with build output
COPY index.html /usr/share/nginx/html
COPY bigimg.jpg /usr/share/nginx/html
