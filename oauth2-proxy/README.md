# Debian Package - OAuth2 Proxy [![Build Status](https://travis-ci.org/manala/debian-package-oauth2-proxy.svg?branch=master)](https://travis-ci.org/manala/debian-package-oauth2-proxy)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [OAuth2 Proxy](https://github.com/bitly/oauth2_proxy) debian package.

## Build

Build for all enabled debian distributions

```
$ make build
```

Build for a specific enabled debian distribution

```
$ make build.wheezy
$ make build.jessie
$ make build.stretch
…
```

## Update

* Check for new versions on https://github.com/bitly/oauth2_proxy/releases
* Update "PACKAGE_VERSION" and "PACKAGE_SOURCE" accordingly in Makefile
* Add an entry to debian/[distribution]/changelog (use "date --rfc-2822 -u" command to specify date)
