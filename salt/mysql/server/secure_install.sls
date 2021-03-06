include:
  - mysql.server

{% if salt['config.get']('mysql.pass') %}
{% set mysql_root_pass = salt['config.get']('mysql.pass') %}
## mysql secure installation
mysqld_secure:
  file.managed:
    - name: /usr/bin/mysql_secure.sh
    - source: salt://mysql/files/mysql_secure.sh
    - user: root
    - group: root
    - mode: 700
    - require:
      - pkg: mysql-server
  cmd.wait:
    - name: /usr/bin/mysql_secure.sh {{mysql_root_pass}}
    - require:
      - service: mysql-server
    - watch:
      - file: mysqld_secure
    - require_in:
      - module: mysqld-manager  
{% endif %}
