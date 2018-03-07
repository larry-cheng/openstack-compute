hosts-conf:
  file.managed:
    - name: /etc/hosts
    - source: salt://init/files/hosts
    - user: root
    - group: root
    - mode: 644

selinux-conf:
  file.managed:
    - name: /etc/selinux/config
    - source: salt://init/files/selinux_config
    - user: root
    - group: root
    - mode: 644

firewalld-server:
  service.running:
    - name: firewalld
    - enable: False
  cmd.run:
    - name: systemctl stop firewalld

Network-Manager:
  service.running:
    - name: NetworkManager
    - enable: False
  cmd.run:
    - name: systemctl stop NetworkManager

software-install:
  pkg.installed:
    - pkgs:
      - net-tools
      - lrzsz
      - tree
      - tcpdump
      - screen
      - lsof
      - wget

ntp-server:
  pkg.installed:
    - name: ntp
  service.running:
    - name: ntpd
    - enable: True
