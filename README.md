# jenkins2git

* Periodic backup of Jenkins configs to Git

### Create user and repository in Gitlab:

* Create user "jenkins"
* Create repository "jenkins-configs"
* Copy repo link to clipboard
* Goto Repository => Settings => Members
* Add Jenkins as Maintainer (only maintainer can do an initial push to empty Gitlab repo)

### Create repository from command line on Jenkins host:

```
sudo -Hiu jenkins
cd ~
git init
git config --global user.name Jenkins
git config --global user.email "jenkins@$(hostname -f)"
git remote add origin PASTE_HERE_REPO_LINK_FROM_GITLAB
ssh-keygen
cat ~/.ssh/id_rsa.pub
```

### Gitlab:

* Users => Jenkins => Impersonate => Personal Settings => SSH keys: paste contents of id_rsa.pub here

### Create job in Jenkins GUI:

* Name = Backup Jenkins configs to Git
* Type = Free job
* Label = master (you should edit Master node and create this label!)
* SCM = None
* Build = Build Periodically
* Schedule = `20 04 * * *`
* Build step = Execute Shell
* Paste the contents of [jenkins2git.sh](jenkins2git.sh)
* Save

### Gitlab:

* Settings => Members: decrease Jenkins permissions from Maintainer to Developer
* Settings => Repository => Protected branches: master => Allow to push: change from Maintainers to Maintainers+Developers

### See also:

* https://gist.github.com/cenkalti/5089392 -- my work is based on it.
