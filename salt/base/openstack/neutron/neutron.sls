include:
  - openstack.init.openstack-repo

neutron-install:
  pkg.installed:
    - pkgs:
      - openstack-neutron-linuxbridge
      - ebtables
      - ipset

neutron-conf:
  file.managed:
    - name: /etc/neutron/neutron.conf
    - source: salt://openstack/neutron/files/neutron.conf
    - user: root
    - group: neutron
    - mode: 640
    - template: jinja
    - defaults:
      RABBIT_PASS: {{ pillar['neutron']['RABBIT_PASS'] }}
      CONTROLLER: {{ pillar['neutron']['CONTROLLER'] }} 
      NEUTRON_PASS: {{ pillar['neutron']['NEUTRON_PASS'] }}
    - require:
      - pkg: neutron-install

bridge-agent-conf:
  file.managed:
    - name: /etc/neutron/plugins/ml2/linuxbridge_agent.ini
    - source: salt://openstack/neutron/files/linuxbridge_agent.ini
    - user: root
    - group: neutron
    - mode: 640
    - template: jinja
    - defaults:
      PROVIDER_INTERFACE_NAME: {{ pillar['neutron']['PROVIDER_INTERFACE_NAME'] }}

neutron-service:
  service.running:
    - name: neutron-linuxbridge-agent
    - enable: True


