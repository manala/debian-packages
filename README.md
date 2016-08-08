# Ansible

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

* Check new version for debian "testing" on https://packages.debian.org/stretch/ansible, or debian "unstable" on https://packages.debian.org/sid/ansible
* Update "PACKAGE_*" variables accordingly in Makefile
* Build :)
