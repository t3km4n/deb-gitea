# deb-gitea

A go-gitea container using sqlite running on debian bullseye slim.

## What is Gitea?

Gitea is a lightweight code hosting solution. Written in Go, features low resource consumption, easy upgrades and multiple databases.

## Installation

- Run `make build` to build the docker image
- Run `make slim` to build the slim image
- Run `make slimup` to run the slim docker image
- Run `make test` to run the tests
- Run `make run` to run the app

## Environment Variables

Environment variables are not used in this container for Gitea.  Instead, configure the `app.ini` file.

## Application

By default the app will start on `localhost:3000`.  

___

If you appreciate my work, then please consider buying me a beer :D

[![PayPal donation](https://www.paypal.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/donate?hosted_button_id=KKQ4LNMEDVUPN)
