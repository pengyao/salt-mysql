mysql-server:
  pkg.installed:
    - name: mysql-server
  file.managed:
    - name: /etc/my.cnf
    - source: salt://mysql/files/my.cnf
    - require:
      - pkg: mysql-server
  service.running:
    - name: mysqld
    - enable: True
    - watch:
      - pkg: mysql-server
      - file: mysql-server


{% if salt['config.get']('mysql.pass') %}
## support mysql manage
{% if grains['osrelease'][0] == '6' %}
mysqld-manager:
  pkg.installed:
    - name: MySQL-python
    - require:
      - service: mysql-server
  module.wait:
    - name: saltutil.refresh_modules
    - watch:
      - pkg: mysqld-manager
    - order: 1
{% elif grains['osrelease'][0] == '5' %}
  pkg.installed:
    - name: python26-mysqldb
    - require:
      - service: mysql-server
  module.wait:
    - name: saltutil.refresh_modules
    - watch:
      - pkg: mysqld-manager
    - order: 1
{% endif %}
