# vagrant-aegir

*phpmyadmin should be available at aegir.local/phpmyadmin*

### Install 
1. Make sure you have <a href='https://github.com/dotless-de/vagrant-vbguest'>vagrant-vbguest</a> and <a href='https://github.com/gael-ian/vagrant-bindfs'>vagrant-bindfs</a> installed
2. Clone this repo and run `$ git submodule update` 
3. Run `$ vagrant up` to trigger the vagrant + puppet install 
4. Enable NFS in the vagrant file by commenting out `disabled: true,`
5. Enable the following code in `puppet/manifests/node.pp` to install a Drupal platform

```bash
aegir::platform {'Drupal7':
  makefile => '/vagrant/drupal_core.make',
}
```

6. run `$ vagrant reload # it will enable NFS`
7. run `$ vagrant provision` to install drupal in the NFS folder
8. add `192.168.99.10 aegir.local` to your /etc/hosts or you local DNS
9. check the terminal output for the one time login link for the aegir backend

Special thanks to ergonlogic (Christopher Gervais) and the rest of the aegir development team!

