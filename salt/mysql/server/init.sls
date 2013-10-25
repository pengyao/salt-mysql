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
mysqld-manager:
  pkg.installed:
    {% if grains['os_family'] == 'RedHat' and grains['osmajorrelease'][0] == '5' %}
    - name: python26-mysqldb
    {% else %}
    - name: MySQL-python
    {% endif %}
    - require:
      - service: mysql-server
  module.wait:
    - name: saltutil.refresh_modules
    - watch:
      - pkg: mysqld-manager
    - order: 1
{% endif %}
