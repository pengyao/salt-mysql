salt-mysql
==========

[中国MySQL用户组](http://opencmug.org/ "中国MySQL用户组")《初识SaltStack》主题分享代码, 基于SaltStack完成MySQL部署管理、MySQL服务运行状态管理、数据库管理、数据库用户管理等功能。

本代码基于 **CentOS 6**

目录文件说明
------------------------------
* pillar/ --> pillar_rootfs
* salt/   --> file_rootfs (for states)
* 初始SaltStack.pdf    --> 主题分享PPT

运行方法
------------------------------
<pre><code>
# salt '*' state.highstate
</code></pre>


