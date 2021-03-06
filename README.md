# IoT_ittt

[![CD](https://github.com/felunka/iot_ittt/actions/workflows/cd.yml/badge.svg)](https://github.com/felunka/iot_ittt/actions/workflows/cd.yml)

## Docker setup

The Docker compose in this repo sets up the whole application with all components. This includes a container with yarn and ruby for the rails application, a postgres database, and a mosquitto container as message broker.

This application is not intended for public access since there is no authentication.

## Infrastructure

This repo is intended to be used with [this traefik setup](https://github.com/conscribtor/docker-traefik-letsencrypt). The reverse proxy handles obtaining a valid certificate and enforcing TLS.

## Sensors

Via the web interface you can create or change a sensor. A sensor has one data source. Currently available are MQTT and REST.

Currently it is only possible to log int and float values.

Live updates will be streamed via websocket to the frontend and will be visible in the overview of all sensors.

### MQTT sensors

A MQTT sensor needs to have a topic. The application will then log all messages on that topic.

### REST sensor

You can provide a URL and the application will issue a GET request at the interval specified. You also need to provide a JsonPath to parse the incoming data. A documentation can be found [here](https://goessner.net/articles/JsonPath/).

## ITTT

ITTT (if this than that) have a set of conditions and actions. To trigger a check of the ittt you can define an interval in minutes and/or trigger on updates on any sensors used in the conditions.
The actions will get triggered if all (AND) conditions are true or if an action has the "Send evaluation output" option set. They will be triggered in the order visible in the frontend. The output can be statically defined as message or will send "True" or "False" depending on the result of the evaluation.
