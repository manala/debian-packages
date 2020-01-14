# Debian Package - websocket-client [![Build Status](https://travis-ci.org/manala/debian-package-pam-ssh-agent-auth.svg?branch=master)](https://travis-ci.org/manala/debian-package-pam-ssh-agent-auth)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [websocket-client](https://packages.debian.org/stretch/python-websocket) debian package.

## Build

Build for all enabled debian distributions

```
$ make build
```

Build for a specific enabled debian distribution

```
$ make build.jessie
…
```

## Update

* Check for new versions on https://snapshot.debian.org/package/websocket-client/
* Update "PACKAGE_VERSION" accordingly in Makefile
* Add an entry to debian/[distribution]/changelog (use "date --rfc-2822 -u" command to specify date)
