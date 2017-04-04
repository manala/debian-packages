# Cgroupfs mount

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

## Build

```
$ make build
```

## Update

* Add an entry to debian.*/changelog (use "date --rfc-2822" command to specify date)
