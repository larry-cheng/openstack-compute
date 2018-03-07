include:
  - openstack.init.openstack-repo

compute-install:
  pkg.installed:
    - name: openstack-nova-compute

compute-conf:
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://openstack/nova/files/nova.conf
    - user: root
    - group: nova
    - mode: 640
    - template: jinja
    - defaults:
      RABBIT_PASS: {{ pillar['nova']['RABBIT_PASS'] }}
      CONTROLLER: {{ pillar['nova']['CONTROLLER'] }}
      NOVA_DB_PASS: {{ pillar['nova']['NOVA_DB_PASS'] }}
      API_SERVERS: {{ pillar['glance']['API_SERVERS'] }}
      KEYSTONE_SERVER: {{ pillar['keystone']['KEYSTONE_SERVER'] }}
      PLACEMENT_PASS: {{ pillar['nova']['PLACEMENT_PASS'] }}
      NOVNCPROXY: {{ pillar['nova']['NOVNCPROXY'] }}
      VNCSERVER: {{ grains['fqdn'] }}
      NEUTRON_PASS: {{ pillar['neutron']['NEUTRON_PASS'] }}
    - require:
      - pkg: compute-install

compute-service:
  service.running:
    - name: openstack-nova-compute
    - enable: True
    - watch:
       - file: compute-conf
