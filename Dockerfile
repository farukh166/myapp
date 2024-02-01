#node block
FROM node:20 as nodeapp

WORKDIR /mynode

COPY . .

RUN npm install

EXPOSE 3000

RUN npm run build

#nginx block
FROM nginx

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=nodeapp /mynode/build .

ENTRYPOINT [ "nginx","-g","daemon off;" ]