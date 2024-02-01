machines = {
  'manager' => {'memory' => '1024', 'cpu' => '1', 'ip' => '100', 'image' => 'bento/ubuntu-22.04'},
  'node01' => {'memory' => '1024', 'cpu' => '1', 'ip' => '101', 'image' => 'bento/ubuntu-22.04'},
  'node02' => {'memory' => '1024', 'cpu' => '1', 'ip' => '102', 'image' => 'bento/ubuntu-22.04'},
  'node03' => {'memory' => '1024', 'cpu' => '1', 'ip' => '103', 'image' => 'bento/ubuntu-22.04'},
}

Vagrant.configure('2') do |config|
  machines.each do |name, conf|
    config.vm.define("#{name}") do |machine|
      machine.vm.box = "#{conf['image']}"
      machine.vm.hostname = "#{name}"
      machine.vm.network('public_network', bridge: 'wlo1', ip: "10.10.10.#{conf['ip']}")
      machine.vm.provider('virtualbox') do |vb|
        vb.name = "#{name}"
        vb.memory = conf['memory']
        vb.cpus = conf['cpu']
      end

      machine.vm.provision('shell', path: 'scripts/install-docker.sh')

      if name == 'manager'
        machine.vm.provision('shell', path: 'scripts/swarm-manager.sh')
        machine.vm.provision('shell', path: 'scripts/nfs-server.sh')
      else
        machine.vm.provision('shell', path: 'scripts/swarm-worker.sh')
        machine.vm.provision('shell', path: 'scripts/nfs-common.sh')
      end
    end
  end

  config.vm.define("manager") do |machine|
    machine.vm.provision(
      'shell',
      inline: 'exportfs -ar &&
        sudo docker service create --name my-app --replicas 15 -dt -p 80:80 --mount type=volume,src=app,dst=/usr/local/apache2/htdocs/ httpd'
    )
  end
end