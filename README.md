# Shoplify : A RoR based e-commerce app


## System

- Ruby version: 2.7.2
- Devise gem
- Stripe gem
- Money-rails gem

## Features

- This app integrates with Stripe to process payment, creating the relations between local DB (postgresql) and Stripe DB (user, products).
- When a new user signs up, a stripe user id is also created to maintain purchases history on the site
- When a new product is created, a stripe product also gets created o maintan a relation between the two DB
- When a price gets updated, a new price gets created in Stripe and is related to the product
- Discount Coupons are also supported

## Live link

- Keep in mind this is only a functional app for practice purposes, so no front-end effort was applied

>[Shoplify](https://shoplify-tucu.herokuapp.com/)

## Getting started

- To get started with the app, clone this project by running `git clone git@github.com:MiguelArgentina/shoplify.git`
- cd into the directory and run `bundle install` to install the gems and dependencies
- Execute `rails db:create` to create the DB
- Execute `rails db:migrate` to run all the migrations
- Execute `rails s` to run the server
- Visit [http://localhost:3000/](http://localhost:3000/) in your browser to view the app.
- To terminate the server, enter `Ctrl + C` in your terminal


## Author

👤 &nbsp; **Miguel Ricardo Gomez**

- GitHub: [@MiguelArgentina](https://github.com/MiguelArgentina)
- Twitter: [@Qete_arg](https://twitter.com/Qete_arg)
- LinkedIn: [Miguel Ricardo Gomez](https://www.linkedin.com/in/miguelricardogomez/)

<br>

## Show your support

Give a &nbsp; ⭐️ &nbsp; if you like this project!

## Acknowledgments

- This app was created following [this](https://www.youtube.com/watch?v=qEVn9sXNCAI&list=PLdTytUiloS14rDdf6ftW63pIgoxshY12w&index=1) video tutorial by [Yaroslav Shmarov](https://twitter.com/yarotheslav).
- His [blog](https://blog.corsego.com/) has really useful content.

## License

Available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).