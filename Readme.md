# vagrant-aegir

*phpmyadmin should be available at aegir.local/phpmyadmin*

### Install 
1. Change the path for bindfs in the Vagrantfile
2. Make sure you have <a href='https://github.com/dotless-de/vagrant-vbguest'>vagrant-vbguest</a> and <a href='https://github.com/gael-ian/vagrant-bindfs'>vagrant-bindfs</a> installed
4. Clone this repo and run `$ git submodule update` 
5. Run `$ vagrant up` to trigger the vagrant + puppet install 
7. add `192.168.99.10 aegir.local` to your /etc/hosts or you local DNS
8. check the terminal output for the one time login link for the aegir backend. If it's not showing up ssh into the machine 
9. Check the Vagrantfile and enable:

```bash
  # IMPORTANT: uncomment the lines below to configure bindfs sharing AFTER the vagrant box is provisioned
  config.bindfs.bind_folder  "/vagrant-nfs","/var/aegir/platforms",
    :perms           => "u=rwX:g=rwX:o=rwX",
    :owner              => 'aegir',
    :group              => 'aegir'

```
10. Reload the vagrant box with the new configuration: `$ vagrant reload`



Special thanks to ergonlogic (Christopher Gervais) and the rest of the aegir development team!

# TODO
- librarian install
- SOLR





