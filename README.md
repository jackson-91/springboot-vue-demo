# springbootvue

#### 介绍
springboot+vue+mysql+redis 前后分离快速开发框架(目前系统初具雏形，尚未完善，后续会不断改进完善),开源出来供初学者一起学习进步。
系统已完成功能：
    系统管理：用户管理、角色管理、菜单管理、日志查询、流水码管理、数据字典管理、定时任务   
    流程管理: 流程设计、流程定义、流程签核、签核历史（尚不完善后续会逐渐完善）   
#### 软件架构
软件架构说明   
此为前后分离项目   
前端技术 vue+elementUi+axios+vuex+vueRouter+bpmn-js   
后端技术 springboot2.3.5+mybatis-plus 3.4.0+spring security+quartz+activiti7
springboot     
├── dev-admin             // 启动模块    
├── dev-common            // 通用模块    
├── dev-util              // 通用工具    
├── dev-generator         // 代码生成器   
├── dev-modules           // 业务模块   
│       └── dev-auth      				// 权限认证模块   
│       └── dev-basic     				// 基础数据   
│       └── dev-workflow  				// 工作流   
├──pom.xml                // 公共依赖   
vue                       // 前端框架   
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


#### 码云特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  码云官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解码云上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是码云最有价值开源项目，是码云综合评定出的优秀开源项目
5.  码云官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  码云封面人物是一档用来展示码云会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
