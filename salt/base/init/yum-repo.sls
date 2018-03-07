yum-install:
  file.managed:
    - name: /etc/yum.repos.d/epel7.repo
    - source: salt://init/files/epel-7.repo
    - user: root
    - group: root
    - mode: 644
    - unless: test -f /etc/yum.repos.d/epel7.repo
