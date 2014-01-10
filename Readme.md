# vagrant-aegir

* aegir won't install on the shared NFS module but you can enable it after puppet is run in the Vagrant file *

### Install 
1. make sure you vagrant-vbguest installed
2. run vagrant up to trigger the vagrant + puppet install 
3. Enable NFS in the vagrant file by commenting out disabled: true,
4. enable the following code in node.pp to install aegir

```bash
aegir::platform {'Drupal7':
  makefile => '/vagrant/drupal_core.make',
}
```

5. run $ vagrant reload # enables NFS 
6. run $ vagrant provision to install drupal in the NFS folder

Special thanks to ergontronic and the rest of the aegir development team!

