# deb-gitea

A go-gitea container using sqlite but optimized for t3km4n's needs.

## What is Gitea?

Gitea is a lightweight code hosting solution. Written in Go, features low resource consumption, easy upgrades and multiple databases.

## Installation

- Run `make build` to build the docker image
- Run `make slim` to build the slim image
- Run `make slimup` to run the slim docker image
- Run `make test` to run the tests
- Run `make run` to run the app

## Environment Variables

`GEOIP_DIR` - Env variable used mainly by the docker container to find views and static files.

## Application

By default the app will start on `localhost:3000`.  

___

If you appreciate my work, then please consider buying me a beer :D

[![PayPal donation](https://www.paypal.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/donate?hosted_button_id=KKQ4LNMEDVUPN)
