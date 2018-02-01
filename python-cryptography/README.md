# Debian Package - Python Cryptography [![Build Status](https://travis-ci.org/manala/debian-package-python-cryptography.svg?branch=master)](https://travis-ci.org/manala/debian-package-python-cryptography)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Provides [Python Cryptography](https://pypi.python.org/pypi/cryptography/) debian package.

## Build

Build for all enabled debian distributions

```
$ make build
```

Build for a specific enabled debian distribution

```
$ make build.wheezy
$ make build.jessie
…
```

## Update

* Check for new versions on http://snapshot.debian.org/package/python-cryptography/
* Update "PACKAGE_*" variables accordingly in Makefile
