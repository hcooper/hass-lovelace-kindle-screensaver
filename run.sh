#!/bin/sh

# Start the webserver used to trick kindle wifi
npx http-server ./www -p 80 &

# Start the regular screenshot server
npm start