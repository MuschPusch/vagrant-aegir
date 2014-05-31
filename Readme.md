# vagrant-aegir

*phpmyadmin should be available at aegir.local/phpmyadmin*

### Install 
1. Make sure you have <a href='https://github.com/dotless-de/vagrant-vbguest'>vagrant-vbguest</a> installed
2. Clone this repo and run `$ vagrant up` to trigger the vagrant + puppet install 
3. Enable NFS in the vagrant file by commenting out `disabled: true,`
4. Enable the following code in `puppet/manifests/node.pp` to install a Drupal platform

```bash
aegir::platform {'Drupal7':
  makefile => '/vagrant/drupal_core.make',
}
```

5. run `$ vagrant reload # it will enable NFS`
6. run `$ vagrant provision` to install drupal in the NFS folder
7. add `192.168.99.10 aegir.local` to your /etc/hosts or you local DNS
8. check the terminal output for the one time login link for the aegir backend

Special thanks to ergonlogic (Christopher Gervais) and the rest of the aegir development team!

Todo: add user aegir to admin group
