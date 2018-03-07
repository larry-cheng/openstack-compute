base:
  '*':
    - init.yum-repo
    - init.sysinit
    - openstack.init.openstack-repo
    - openstack.init.libvirt
    - openstack.nova.compute
    - openstack.neutron.neutron
