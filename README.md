bitwin
======

bitwin 必赢 yeap~


###安装并配置bitcoind###

1. 安装方法 `apt-get install bitcoind`
2. 在home目录下新建一个`.bitcoin/bitcoin.conf` 文件，并在里面配置好用户名和密码，例如： 

   ```javascript
   rpcuser=name 
   rpcpassword=password
   ```
3. 启动服务 `bitcoind &`


###how to deploy#####
1. cap deploy
2. 启动bitcoind
3. 如果是第一次需要初始化老数据(RAILS_ENV=production rake create_user_operations）
4. 确保redis/resque/resque_scheduler 都是启动的 （这些在cap命令中都是有的）

