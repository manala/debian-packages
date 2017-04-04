# Supervisor

## Build

Build for all distributions

```
$ make build
```

Build for specific distributions

```
$ make build@jessie
$ make build@wheezy
```

## Update

* Check new version for debian "testing" on https://packages.debian.org/stretch/supervisor, or debian "unstable" on https://packages.debian.org/sid/supervisor
* Update "PACKAGE_*" variables accordingly in Makefile
* Build :)
