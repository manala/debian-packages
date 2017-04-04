# OPcache Dashboard

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

* Update "PACKAGE_VERSION" and "PACKAGE_VERSION_HASH" in Makefile
* Add an entry to debian.*/changelog (use "date --rfc-2822" command to specify date)
* Check that debian.*/install is still relevant
