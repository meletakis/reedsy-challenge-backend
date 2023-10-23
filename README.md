# README

Implementation of the [reedsy backend challenge](https://github.com/reedsy/challenges/blob/main/ruby-on-rails-engineer-v2.md).

### Ruby version
  * 3.0.0

### Setup commands
```
bundle install
bin/rails db:migrate
bin/rails db:seed
```

### Run tests
```
rspec
```

### Start server
```
bin/rails server
```

### Curl examples
#### [Question 1](https://github.com/reedsy/challenges/blob/main/ruby-on-rails-engineer-v2.md#question-1)
Implement an API endpoint that allows listing the existing items in the store, as well as their attributes.

```bash
curl http://localhost:3000/products
```
Response:
```
[{"id":1,"code":"MUG","name":"Reedsy Mug","price":6.0},{"id":2,"code":"TSHIRT","name":"Reedsy T-shirt","price":15.0},{"id":3,"code":"HOODIE","name":"Reedsy Hoodie","price":20.0}]
```

#### [Question 2](https://github.com/reedsy/challenges/blob/main/ruby-on-rails-engineer-v2.md#question-2)
Implement an API endpoint that allows updating the price of a given product.

```bash
curl -X PUT http://localhost:3000/products/1 -H "Content-Type: application/json" -d '{"product": { "price_in_cents" : 200 } }'
```
Response:
```
{"new_price":200}
```

#### [Question 3](https://github.com/reedsy/challenges/blob/main/ruby-on-rails-engineer-v2.md#question-3)
Implement an API endpoint that allows one to check the price of a given list of items.

```bash
curl -G http://localhost:3000/products_prices -d items[]=1,1 -d items[]=2,1 -d items[]=3,1
```
Response:
```
{"total_price":41.0}
```

#### [Question 4](https://github.com/reedsy/challenges/blob/main/ruby-on-rails-engineer-v2.md#question-4)
Add discount on prices

```bash
curl -G http://localhost:3000/products_prices -d items[]=1,10 -d items[]=2,1
```
Response:
```
{"total_price":73.8}
```

```bash
curl -G http://localhost:3000/products_prices -d items[]=1,200 -d items[]=2,4 -d items[]=3,1
```
Response:
```
{"total_price":902.0}
```
  
Note that in products_prices request the first argument in the `items` param is the product id and the second one the quantity.

For example: `-d items[]=1,200` means for product with id: 1 quantity is 200.
