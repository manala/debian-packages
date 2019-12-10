# Debian Packages

## Instructions

Add apt key
```
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 1394DEA3
```

Add apt source
```
deb [arch=amd64] http://debian.manala.io [wheezy|jessie|stretch] main
```

## Details

**Note:** The ~~crossed out~~ packages are considered deprecated.

| Package | Description | Build Status |
| :---    | :---        |    :---:     |
| [alt-galaxy](https://github.com/manala/debian-package-alt-galaxy) | Provides [Alt Galaxy](https://github.com/gantsign/alt-galaxy) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-alt-galaxy.svg?branch=master)](https://travis-ci.org/manala/debian-package-alt-galaxy) |
| [ansible](https://github.com/manala/debian-package-ansible) | Provides [Ansible](https://www.ansible.com/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-ansible.svg?branch=master)](https://travis-ci.org/manala/debian-package-ansible) |
| [backup-manager](https://github.com/manala/debian-package-backup-manager) | Provides [Backup Manager](https://github.com/sukria/Backup-Manager) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-backup-manager.svg?branch=master)](https://travis-ci.org/manala/debian-package-backup-manager) |
| ~~[cgroupfs-mount](https://github.com/manala/debian-package-cgroupfs-mount)~~ | ~~Package to set up cgroupfs mounts on debian wheezy and specific to proxmox cgroup hierarchy.~~ | [![Build Status](https://travis-ci.org/manala/debian-package-cgroupfs-mount.svg?branch=master)](https://travis-ci.org/manala/debian-package-cgroupfs-mount) |
| [exa](https://github.com/manala/debian-package-exa) | Provides [Exa](https://the.exa.website/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-exa.svg?branch=master)](https://travis-ci.org/manala/debian-package-exa) |
| [ffmpeg](https://github.com/manala/debian-package-ffmpeg) | Provides [FFmpeg](https://www.ffmpeg.org/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-ffmpeg.svg?branch=master)](https://travis-ci.org/manala/debian-package-ffmpeg) |
| [gitsplit](https://github.com/manala/debian-package-gitsplit) | Provides [Gitsplit](https://github.com/jderusse/docker-gitsplit) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-gitsplit.svg?branch=master)](https://travis-ci.org/manala/debian-package-gitsplit) |
| [httpie](https://github.com/manala/debian-package-httpie) | Provides [HTTPie](https://httpie.org/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-httpie.svg?branch=master)](https://travis-ci.org/manala/debian-package-httpie) |
| [hugo](https://github.com/manala/debian-package-hugo) | Provides [Hugo](https://gohugo.io/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-hugo.svg?branch=master)](https://travis-ci.org/manala/debian-package-hugo) |
| [jinja2](https://github.com/manala/debian-package-jinja2) | Provides [Jinja2](http://jinja.pocoo.org/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-jinja2.svg?branch=master)](https://travis-ci.org/manala/debian-package-jinja2) |
| [keepalived](https://github.com/manala/debian-package-keepalived) | Provides [Keepalived](http://www.keepalived.org/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-keepalived.svg?branch=master)](https://travis-ci.org/manala/debian-package-keepalived) |
| [libthumbor](https://github.com/manala/debian-package-libthumbor) | Provides [Thumbor](http://thumbor.org/) lib debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-libthumbor.svg?branch=master)](https://travis-ci.org/manala/debian-package-libthumbor) |
| [mailhog](https://github.com/manala/debian-package-mailhog) | Provides [MailHog](https://github.com/mailhog/MailHog) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-mailhog.svg?branch=master)](https://travis-ci.org/manala/debian-package-mailhog) |
| [mongo-express](https://github.com/manala/debian-package-mongo-express) | Provides [Mongo Express](https://github.com/mongo-express/mongo-express) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-mongo-express.svg?branch=master)](https://travis-ci.org/manala/debian-package-mongo-express) |
| [ngrok](https://github.com/manala/debian-package-ngrok) | Provides [Ngrok](https://ngrok.com/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-ngrok.svg?branch=master)](https://travis-ci.org/manala/debian-package-ngrok) |
| [oauth2-proxy](https://github.com/manala/debian-package-oauth2-proxy) | Provides [OAuth2 Proxy](https://github.com/bitly/oauth2_proxy) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-oauth2-proxy.svg?branch=master)](https://travis-ci.org/manala/debian-package-oauth2-proxy) |
| [opcache-dashboard](https://github.com/manala/debian-package-opcache-dashboard) | Provides [OPcache Dashboard](https://github.com/carlosbuenosvinos/opcache-dashboard) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-opcache-dashboard.svg?branch=master)](https://travis-ci.org/manala/debian-package-opcache-dashboard) |
| [pam-ssh-agent-auth](https://github.com/manala/debian-package-pam-ssh-agent-auth) | Provides [Pam_Ssh_Agent_Auth](http://pamsshagentauth.sourceforge.net/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-pam-ssh-agent-auth.svg?branch=master)](https://travis-ci.org/manala/debian-package-pam-ssh-agent-auth) |
| [phantomjs](https://github.com/manala/debian-package-phantomjs) | Provides [PhantomJS](http://phantomjs.org/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-phantomjs.svg?branch=master)](https://travis-ci.org/manala/debian-package-phantomjs) |
| [phpmyadmin](https://github.com/manala/debian-package-phpmyadmin) | Provides [PhpMyAdmin](https://www.phpmyadmin.net/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-phpmyadmin.svg?branch=master)](https://travis-ci.org/manala/debian-package-phpmyadmin) |
| [phppgadmin](https://github.com/manala/debian-package-phppgadmin) | Provides [PhpPgAdmin](http://phppgadmin.sourceforge.net/doku.php) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-phppgadmin.svg?branch=master)](https://travis-ci.org/manala/debian-package-phppgadmin) |
| [phpredisadmin](https://github.com/manala/debian-package-phpredisadmin) | Provides [PhpRedisAdmin](https://github.com/erikdubbelboer/phpRedisAdmin) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-phpredisadmin.svg?branch=master)](https://travis-ci.org/manala/debian-package-phpredisadmin) |
| [python-cryptography](https://github.com/manala/debian-package-python-cryptography) | Provides [Python Cryptography](https://pypi.python.org/pypi/cryptography/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-python-cryptography.svg?branch=master)](https://travis-ci.org/manala/debian-package-python-cryptography) |
| [python-httplib2](https://github.com/manala/debian-package-python-httplib2) | Provides [Python Httplib2](https://pypi.org/project/httplib2/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-python-httplib2.svg?branch=master)](https://travis-ci.org/manala/debian-package-python-httplib2) |
| [python-pathlib2](https://github.com/manala/debian-package-python-pathlib2) | Provides [Python Pathlib2](https://pypi.python.org/pypi/pathlib2/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-python-pathlib2.svg?branch=master)](https://travis-ci.org/manala/debian-package-python-pathlib2) |
| [python-proxmoxer](https://github.com/manala/debian-package-python-proxmoxer) | Provides [Python Proxmoxer](https://pypi.python.org/pypi/proxmoxer/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-python-proxmoxer.svg?branch=master)](https://travis-ci.org/manala/debian-package-python-proxmoxer) |
| ~~[rtail](https://github.com/manala/debian-package-rtail)~~ | ~~Provides [RTail](http://rtail.org/) debian package.~~ | [![Build Status](https://travis-ci.org/manala/debian-package-rtail.svg?branch=master)](https://travis-ci.org/manala/debian-package-rtail) |
| [sensu-go-agent](https://github.com/manala/debian-package-sensu-go-agent) | Provides [Sensu-go-agent](https://www.sensu.io) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-sensu-go-agent.svg?branch=master)](https://travis-ci.org/manala/debian-package-sensu-go-agent) |
| [sensu-go-backend](https://github.com/manala/debian-package-sensu-go-backend) | Provides [Sensu-go-backend](https://www.sensu.io) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-sensu-go-backend.svg?branch=master)](https://travis-ci.org/manala/debian-package-sensu-go-backend) |
| [sensu-go-cli](https://github.com/manala/debian-package-sensu-go-cli) | Provides [Sensu-go-cli](https://www.sensu.io) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-sensu-go-cli.svg?branch=master)](https://travis-ci.org/manala/debian-package-sensu-go-cli) |
| [splitsh-lite](https://github.com/manala/debian-package-splitsh-lite) | Provides [Splitsh Lite](https://github.com/splitsh/lite) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-splitsh-lite.svg?branch=master)](https://travis-ci.org/manala/debian-package-splitsh-lite) |
| [supervisor](https://github.com/manala/debian-package-supervisor) | Provides [Supervisor](http://supervisord.org/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-supervisor.svg?branch=master)](https://travis-ci.org/manala/debian-package-supervisor) |
| [thefuck](https://github.com/manala/debian-package-thefuck) | Provides [The Fuck](https://github.com/nvbn/thefuck) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-thefuck.svg?branch=master)](https://travis-ci.org/manala/debian-package-thefuck) |
| [thumbor](https://github.com/manala/debian-package-thumbor) | Provides [Thumbor](http://thumbor.org/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-thumbor.svg?branch=master)](https://travis-ci.org/manala/debian-package-thumbor) |
| [vault](https://github.com/manala/debian-package-vault) | Provides [Vault](https://www.vaultproject.io/) debian package. | [![Build Status](https://travis-ci.org/manala/debian-package-vault.svg?branch=master)](https://travis-ci.org/manala/debian-package-vault) |
