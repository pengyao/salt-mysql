include:
  - mysql.server.secure_install

{% if salt['config.get']('mysql.pass') %}
{% if 'mysql-server' in pillar %}
## mysql database states
{% if 'databases' in pillar['mysql-server'] %}
{% for eachdb in pillar['mysql-server']['databases'] %}
mysql_database_{{eachdb}}:
  mysql_database.present:
    - name: {{eachdb}}
    - require:
      - module: mysqld-manager
{% endfor %}
{% endif %}

## mysql user states
{% if 'users' in pillar['mysql-server'] %}
{% for eachuser in pillar['mysql-server']['users'] %}
{% set username = eachuser['user'] %}
mysql_users_{{username}}:
  mysql_user.present:
    - name: {{username}}
    - host: {{eachuser['host']}}
    - password: {{eachuser['password']}}
    - require:
      - module: mysqld-manager

## mysql user permission
{% if 'permissions' in eachuser%}
{% for eachgrant in eachuser['permissions'] %}
mysql_grants_{{username}}_{{eachgrant['database']}}:
  mysql_grants.present:
    - grant: {{eachgrant['grant']}}
    - database: {{eachgrant['database']}}
    - user: {{username}}
    - host: {{eachuser['host']}}
{% endfor %}
{% endif %}

{% endfor %}
{% endif %}
{% endif %}
{% endif %}
