mysql-server:
  databases:
    - pengyao
    - saltstack
  users:
    - user: pengyao
      password: pengyaopass
      host: localhost
      permissions:
        - grant: select,insert,update
          database: pengyao.*
        - grant: all
          database: saltstack.*
