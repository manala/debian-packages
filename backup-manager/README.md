# Backup Manager

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

* Check new version for debian "testing" on https://packages.debian.org/stretch/backup-manager, or debian "unstable" on https://packages.debian.org/sid/backup-manager
* Update "PACKAGE_*" variables accordingly in Makefile
* Build :)
