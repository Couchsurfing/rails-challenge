## Couchsurfing Rails Challenge

### Setup
* Fork this repository
* Make sure that Ruby, Rails, and SQLite3 are installed on your machine. This might be helpful if you don't create new apps everyday https://guides.rubyonrails.org/getting_started.html
* Run ```bundle install``` to install gems
* Setup database ```rake db:setup```
* Run the app ```rails server``` or an interactive console ```rails console``` to test that your app is running.

### Frontend Setup
* Run `yarn --cwd orders-app/ install` to install packages
* If heroku cli is available locally: run `heroku local -f Procfile.dev` to start the API server and the frontend server
* If not,`yarn --cwd orders-app/ start` will start the frontend alone.
* After it's running, browse to [homepage](http://localhost:4000)

### Premise:
* E-commerce sites often follow a similar data format. I've already created models for some of the more common resources.
These are the objects that are already modeled and included in the schema.
- A ```customer``` is someone making a purchase.
- A ```product``` is a product for sale.
- A ```variant``` is a version of a specific product. For example if the product was "Jean Jacket" the variants might be "Dark Blue" and "Light Blue", although variant usage is not limited to color.
- A ```collection``` contains a group of similar products

### Note:
* Please use RSpec for the test, but otherwise use any libraries you prefer.
* We encourage writing the tests first! If you are comfortable with TDD, do Step 3 before Step 2.
* Please make frequent commits (the more the commits, the easier for us to review coding patterns)

### We evaluate the code based on the following criteria:
* Strong database design and modelling
* Good REST API practices
* Good usage of model level constraints, validations, etc
* Good coding practices, we follow https://github.com/rubocop-hq/ruby-style-guide as far as possible at Floh
* Test cases (rspec or other) for controller and model methods

### Step 1
Create a model for a customer order.
##### It should store these attributes.
* Date created
* Reference/relationship to the customer who is placing the order.
* Reference to each variant ordered and the quantity ordered of each variant. (HINT: Might be helpful to create a second model here)
* Total cost of all variants included in the order. (Should not change when the price of an included variant is changed)
* Current order status ['pending', 'processing', 'fulfilled', 'delivered', 'canceled']. This field should default to pending.

### Step 2
Create an endpoint to create orders. This endpoint enables the creation of an order based on a set of required parameters(customer_id, list of variant_ids and quantities ordered)
##### Requirements
* Creating an order returns a 400 response if the request doesn't contain required parameters
* Creating an order returns a 404 response if any of the customer or variant ids are invalid.
* Creating an order returns a 422 response if there is not enough stock for any of the variants contained in the order.
* Creating an order succeeds if none of the previous error scenarios occur.

### Step 3
Write an RSpec test to verify that order creation endpoint behaves as described above.

### Step 4
Create an endpoint to display a single order resource at the  /orders/{#id}.json endpoint.
* Response should contain all order fields, and additionally include variant id, name, price, and quantity ordered for each variant included in the order.

### Step 5
Create a front-end using any of the popular front-end frameworks (React, Angular, Vue, etc.). 
Front-end should allow the user to create orders, view all orders, and change order status. 

### Delivery:
* Submit a pull request

### Bonus points for:
* Heroku deployable button in the README file (based on https://devcenter.heroku.com/articles/heroku-button)
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)
* This doesn't work because Heroku doesn't allow you to run apps on multiple ports. You can use heroku to run locally by executing `heroku local -f Procfile.dev`
