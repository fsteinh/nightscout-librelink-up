FROM node:18-bullseye
LABEL description="Script written in TypeScript that uploads CGM readings from LibreLink Up to Nightscout"

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

# Run tests
RUN npm run test

RUN rm -r tests
RUN rm -r coverage

CMD [ "npm", "start" ]

docker run -e LINK_UP_USERNAME="frank.steinheimer@hotmail.co.uk" \
           -e LINK_UP_PASSWORD="SilvesterL1!" \
           -e LINK_UP_TIME_INTERVAL="5" \
           -e LINK_UP_REGION="EU" \
           -e NIGHTSCOUT_URL="https://night--fsteinhcgm--pycnj8hvrvkk.code.run/" \
           -e NIGHTSCOUT_API_TOKEN="WilliamCGM1!" \
           -e LOG_LEVEL="info" \
           timoschlueter/nightscout-librelink-up