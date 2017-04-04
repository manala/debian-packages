# Keepalived debian package

## Build

Build for all distributions

```
$ make build
```

Build for specific distributions

```
$ make build@jessie
```

## Update

* Check new version for [debian "testing"](https://packages.debian.org/testing/keepalived) or [debian "unstable"](https://packages.debian.org/sid/keepalived)
* Update "PACKAGE_*" variables accordingly in Makefile
* `make build`
