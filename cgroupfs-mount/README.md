# Debian Package - Cgroupfs Mount [![Build Status](https://travis-ci.org/manala/debian-package-cgroupfs-mount.svg?branch=master)](https://travis-ci.org/manala/debian-package-cgroupfs-mount)

:exclamation: [Report issues](https://github.com/manala/debian-packages/issues) and [send Pull Requests](https://github.com/manala/debian-packages/pulls) in the [main Debian Packages repository](https://github.com/manala/debian-packages) :exclamation:

Package to set up cgroupfs mounts on debian wheezy and specific to proxmox cgroup hierarchy :
```
tmpfs            16G     0   16G   0% /sys/fs/cgroup
cgroup             0     0     0    - /sys/fs/cgroup/systemd
cgroup             0     0     0    - /sys/fs/cgroup/cpuset
cgroup             0     0     0    - /sys/fs/cgroup/cpu,cpuacct
cgroup             0     0     0    - /sys/fs/cgroup/blkio
cgroup             0     0     0    - /sys/fs/cgroup/memory
cgroup             0     0     0    - /sys/fs/cgroup/devices
cgroup             0     0     0    - /sys/fs/cgroup/freezer
cgroup             0     0     0    - /sys/fs/cgroup/net_cls,net_prio
cgroup             0     0     0    - /sys/fs/cgroup/perf_event
cgroup             0     0     0    - /sys/fs/cgroup/hugetlb
cgroup             0     0     0    - /sys/fs/cgroup/pids
```

Based on https://github.com/tianon/cgroupfs-mount
cgroupfs-mount
## Build

Build for all enabled debian distributions

```
$ make build-all
```

Build for a specific enabled debian distribution

```
$ make build.wheezy
$ make build.jessie
$ make build.stretch
…
```

## Update

* Add an entry to debian/[distribution]/changelog (use "date --rfc-2822 -u" command to specify date)
