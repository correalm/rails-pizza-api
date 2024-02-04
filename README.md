# README

* Ruby version: 3.0.6

* System dependencies
    - Docker
    - Docker Compose
* Runing the app
    `docker-compose up --build`
* How to run the test suite
    Access the container terminal using the following command
        `docker exec -it rails-pizza-api-app-1 /bin/bash`

    Then:
        `bundle exec rspec`

> This app is based on [AmbulnzLLC backend challenge](https://github.com/AmbulnzLLC/fullstack-challenge/tree/master/backend)

- TODO: make a github action to run rspec on pushs on `master` and opened PRs;
