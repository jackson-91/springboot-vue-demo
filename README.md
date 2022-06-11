# springbootvue

#### 本项目来源码云，原项目路径：https://gitee.com/devframework/springbootvue

#### 介绍
springboot+vue+mysql+redis 前后分离快速开发框架(目前系统初具雏形，尚未完善，后续会不断改进完善)
以前一直时做net的，后来机缘巧合来做java，但是以前没有做过java，工作过程中磕磕碰碰。后来决定自己做一套权限管理系统，希望在做系统的过程中来不断学习知识来提高自己的能力。顺便将其开源出来供初学者一起学习进步。
系统已完成功能：
    系统管理：用户管理、角色管理、菜单管理、日志查询、流水码管理、数据字典管理、定时任务   
    流程管理: 流程设计、流程定义、流程签核、签核历史（尚不完善后续会逐渐完善）   
#### 软件架构
软件架构说明   
此为前后分离项目   
前端技术 vue+elementUi+axios+vuex+vueRouter+bpmn-js   
后端技术 springboot2.3.1+mybatis-plus3.3.2+spring security+quartz+activiti7   

#### 安装教程
开发工具
    IntelliJ IDEA    
    VsCode   
    Mysql   
    Redis   
下载代码 git clone https://gitee.com/devframework/springbootvue.git   
其中springboot为后端目录 vue为前端目录 db为数据库脚本目录    
1、db目录为数据脚本   
  db.sql 是系统表   
  data.sql   是部分数据   
  quartz.sql 是定时任务quarzt的表   
  activiti.sql 是工作流activiti7的表   
注：activiti7 也可采用自动生成表格 首次启动时需要在配置文件里面设置 database-schema-update: true 改为true即可   
2、springboot直接用idea打开即可
注：
3、vue 需要执行以下node指令   
   如果用cnpm 就用   
    cnpm install 安装依赖   
    cnpm run dev 运行项目   
    cnpm run build 发布项目   
   如果用cnpm 就用   
    npm install  安装依赖   
    npm run dev  运行项目   
    npm run build 发布项目   
   如果使用yarn 就用   
    yarn         安装依赖   
    yarn dev     运行项目   
    yarn build   发布项目   
注：运行时可能会报缺少image-webpack-loader依赖包异常 这个是用需要先删除一下这个依赖包 再用cnpm 安装一下   
   cnpm install image-webpack-loader --save -dev 之后重新启用一下即可   

#### 使用说明
1.  先启动springboot程序 之后启动vue项目 访问http://localhost:8080/即可 默认用户密码 admin/000000   
2.  在线体验 http://47.104.140.48:83/ 默认用户密码 admin/000000   
#### 系统截图
![用户管理](https://images.gitee.com/uploads/images/2020/0725/131825_b4bbe7c6_64704.png "屏幕截图.png")
![角色管理](https://images.gitee.com/uploads/images/2020/0725/131840_4682d856_64704.png "屏幕截图.png")
![菜单管理](https://images.gitee.com/uploads/images/2020/0725/131855_12c18adf_64704.png "屏幕截图.png")
![数据字典](https://images.gitee.com/uploads/images/2020/0725/131915_abe9f98c_64704.png "屏幕截图.png")
![日志管理](https://images.gitee.com/uploads/images/2020/0725/131927_d41d8cb6_64704.png "屏幕截图.png")
![定时任务](https://images.gitee.com/uploads/images/2020/0725/131942_7f75f6d3_64704.png "屏幕截图.png")
![流程设计](https://images.gitee.com/uploads/images/2020/0725/132003_e7030c96_64704.png "屏幕截图.png")
![流程定义](https://images.gitee.com/uploads/images/2020/0725/132020_0c93dcba_64704.png "屏幕截图.png")
![流程签核](https://images.gitee.com/uploads/images/2020/0725/132040_3127b602_64704.png "屏幕截图.png")
![流程签核](https://images.gitee.com/uploads/images/2020/0725/132040_3127b602_64704.png "屏幕截图.png")
![签核历史](https://images.gitee.com/uploads/images/2020/0725/132059_fbd1afc4_64704.png "屏幕截图.png")

#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request

