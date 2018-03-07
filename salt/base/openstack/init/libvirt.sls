libvirt.install:
  pkg.installed:
    - name: libvirt

libvirtd.service:
  service.running:
    - name: libvirtd
    - enable: True
