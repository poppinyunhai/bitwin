'- [TODO](#todo)
- [NEWS](#news)
  - [v0.3 (2013-09-xx)](#v02-2013-09-xx)
 	- [v0.2 (2013-09-08)](#v02-2013-09-08)
	- [v0.1 (2013-09-01)](#v01-2013-09-01)



# TODO
* 每周日晚8点发布.

# NEWS
## v0.3 (2013-09-xx)
* DEPLOY NOTES
* Features
  * [#78] 完善密码找回
  * [#98] 当用户开启google认证，在登入时进行校验
  * [#issue_52] 完善个人中心基本信息修改
* Tech Stories
  * [#86] 个人中心url自动打开div
* Bugs

## v0.2 (2013-09-08)
* DEPLOY NOTES
  1. apt-get install imagemagick
* Features
* Tech Stories
  * [#47] 添加邮件发送队列
  * [#49] 完善注册页面
  * [#48] 添加redis做缓存
  * [#39] 修正cap部署   部署命令  cap deply:update  -> cap unicorn:restart
  * [#64] 关于帐户密码以及常量设置问题
  * [#51] 短信验证逻辑实现
  * [#69] 添加所有文件上传逻辑
  * [#57] IP地址纪录
  * [#55] google 认证
* Bugs
  * [#master] fixed travis ci test error bug


## v0.1 (2013-09-01)
* DEPLOY NOTES
* Features
* Tech Stories
  * [#12] 引入bootstrap-sass,mysql2,slim gems.
  * [#18] 添加NEWS. md
  * [#19] 添加.travis.yml 
  * [#11] 添加测试基础环境
  * [#23] 删除public下面的多余代码
  * [#13] 添加devise
  * [#14] 添加cancan
  * [#30] 添加settingslogic
  * [#26] 添加china_sms
  * [#16] 添加模板设计
  * [#25] 添加自动部署
* Bugs
