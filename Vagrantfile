# pus = 2*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = "aegir.local"
  #config.ssh.username = "aegir"
  #config.ssh.insert_key = true

  #Declare shared folder with Vagrant syntax
  config.vm.synced_folder ".", "/var/aegir/platforms", synced_folder_type: "nfs"
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.

  config.vm.network :private_network, ip: "192.168.99.10"
  #config.vm.network :forwarded_port, :guest => 80, :host => 8082

  #increase memory
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "90"]
    v.customize ["modifyvm", :id, "--memory", 1448]
    v.cpus = 4
  end

  ## Use all the defaults:
  config.vm.provision :puppet do |puppet|
    puppet.module_path = "puppet/modules"
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.nfs = true
    puppet.facter = {
      "fqdn" => "aegir.local"
    }
    # enable this for debugging
    #puppet.options = "--debug --verbose"
  end

end
