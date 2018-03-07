openstack-repo:
  cmd.run:
    - name: yum install centos-release-openstack-pike -y
    - unless: test -f /etc/yum.repos.d/CentOS-OpenStack-pike.repo

