<h1>Rails Engine</h1>

<p>
  An E-Commerce Application API
</p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#api-endpoints">API Endpoints</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

Rails Engine is a service-oriented E-Commerce Application that exposes API endpoints for front-end consumption.


<!-- GETTING STARTED -->
## Getting Started

* [Rails v5.2.7](https://rubyonrails.org/)
* [Ruby v2.7.4](https://www.ruby-lang.org/en/)

<p align="right">(<a href="#top">back to top</a>)</p>


### Installation

2. Clone the repo
   ```sh
   git clone https://github.com/jenniferhalloran/rails-engine.git
   ```
3. Install Ruby 2.7.4 and Rails 5.2.7

3. Install required gems using the included gemfile
   ```sh
   bundle install
   ```
3. Create Postgresql database, run migrations and seed database
   ```sh
   rails db:{create,migrate,seed}
   ```
3. Launch local server
   ```sh
   rails s
   ```
3. Use a browser or tool like PostMan to explore the API on http://localhost:3000
   ```sh
   http://localhost:3000
   ```

<p align="right">(<a href="#top">back to top</a>)</p>

## API Endpoints

#### Merchants:
  * get all merchants `GET http://localhost:3000/api/v1/merchants`
  * get one merchant `GET http://localhost:3000/api/v1/merchants/:merchant_id`
  * get all items held by a given merchant `GET http://localhost:3000/api/v1/merchants/:merchant_id/items`
#### Items:
  * get all items `GET http://localhost:3000/api/v1/items`
  * get one item `GET http://localhost:3000/api/v1/items/:item_id`
  * create an item `POST http://localhost:3000/api/v1/items/:item_id`
  * edit an item `PUT http://localhost:3000/api/v1/items/:item_id`
  * delete an item `DESTROY http://localhost:3000/api/v1/items/:item_id`
  * get the merchant data for a given item ID `GET http://localhost:3000/api/v1/items/:item_id/merchant`
  * find one item by name `GET http://localhost:3000/api/v1/items/find?name=some_query`
  
