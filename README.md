# Gitsplit

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

* Update "PACKAGE_VERSION*" in Makefile
* Add an entry to debian/changelog (use "date --rfc-2822" command to specify date)
