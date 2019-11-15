# Irizar

[![Build Status](https://travis-ci.com/gstn-caruso/irizar.svg?branch=master)](https://travis-ci.com/gstn-caruso/irizar)

![Penguins with Irízar Icebraker in the background](https://upload.wikimedia.org/wikipedia/commons/c/c6/Almirante_Ir%C3%ADzar_en_la_CAV_2018-2019_02.jpg)


Irizar is a Cuis web framework build on top of WebClient which allows to define routes and controllers in a handy way.

This is a work in progress, so feel free to fork and open a PR!

## Getting started

1. You would need a [https://github.com/Cuis-Smalltalk/Cuis-Smalltalk-Dev](Cuis smalltalk image).
2. Once it is running, you just drag and drop the `Irizar.pck.st` file into Cuis.
3. Open a Workspace and just run `IrizarWebServer instance listenOn: 8080`
4. Register a route: `IrizarWebServer instance request send200Response: '{ "hello": "world" }' contentType: 'application/json'`
