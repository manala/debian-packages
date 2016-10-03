# Mongo Express

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

* Check new version on https://www.npmjs.com/package/mongo-express
* Update "PACKAGE_*" variables accordingly in Makefile
* Add an entry to debian.*/changelog (use "date --rfc-2822" command to specify date)
* Build :)
