# Debian Package - Proxmoxer [![Build Status](https://travis-ci.org/manala/debian-package-python-proxmoxer.svg?branch=master)](https://travis-ci.org/manala/debian-package-python-proxmoxer)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [Proxmoxer](https://pypi.python.org/pypi/proxmoxer/) debian package.

## Build

Build for all enabled debian distributions

```
$ make build
```

Build for a specific enabled debian distribution

```
$ make build.jessie
$ make build.stretch
…
```

## Update

* Check for new versions on https://pypi.python.org/pypi/proxmoxer/
* Update "PACKAGE_*" variables accordingly in Makefile
* Add an entry to debian/[distribution]/changelog (use "date --rfc-2822 -u" command to specify date)
