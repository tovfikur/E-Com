# install react "npx create-next-app reactive"
# create react app
# install packages
# npm install bootstrap reactstrap --legacy-peer-deps

cd ..

yes "No" | npx create-next-app khukumoni --use-npm --typescript --eslint --tailwind --no-src --no-app-router --no-alias --
react
npm install axios
npm run build
npm start