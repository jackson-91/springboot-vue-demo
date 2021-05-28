<template>
  <el-container class="home-container">
    <!--头部-->
    <el-header>
      <div>
        <img src="../../assets/logo.png" alt />
        <span>后台管理系统</span>
      </div>
      <el-dropdown :show-timeout="0" placement="bottom">
        <span class="el-dropdown-link">
          <img src="~@/assets/img/avatar.png" :alt="userName" />{{ userName }}
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item @click.native="updatePasswordHandle()">修改密码</el-dropdown-item>
          <el-dropdown-item @click.native="logout()">退出</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </el-header>

    <el-container class="main-container">
      <!--左侧菜单-->
      <el-aside :width="isCollapse ? '64px' : '200px'">
        <Menu v-bind:isCollapse="isCollapse" :BreadcrumbList="BreadcrumbList" @changeBreadcrumb="changeBreadcrumb" ref="menu" />
        <div class="toggle-button" @click="toggleCollapse">
          <i :class="
              isCollapse ? 'el-icon-d-arrow-right' : 'el-icon-d-arrow-left'
            "></i>
        </div>
      </el-aside>
      <!--右侧主体-->
      <el-main :style="setMarginLeft">

        <el-dropdown class="site-tabs__tools" :show-timeout="0">
          <i class="el-icon-arrow-down el-icon--right"></i>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item @click.native="tabsCloseCurrentHandle">关闭当前标签页</el-dropdown-item>
            <el-dropdown-item @click.native="tabsCloseOtherHandle">关闭其它标签页</el-dropdown-item>
            <el-dropdown-item @click.native="tabsCloseAllHandle">关闭全部标签页</el-dropdown-item>
            <!-- <el-dropdown-item @click.native="tabsRefreshCurrentHandle">刷新当前标签页</el-dropdown-item> -->
          </el-dropdown-menu>
        </el-dropdown>
        <keep-alive>
          <el-tabs v-model="mainTabsActiveName" type="border-card" @tab-click="tabClick" @tab-remove="removeTab">
            <el-tab-pane :key="item.name" v-for="(item, index) in editableTabs" :label="item.title" :name="item.name"
              :closable="item.name == '/welcome' ? false : true">
            </el-tab-pane>
            <el-card :body-style="siteContentViewHeight">
              <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item @click="goHome">首页</el-breadcrumb-item>
                <el-breadcrumb-item v-for="item in BreadcrumbList" :index="item.id" :key="item.id">{{ item.menuName }}</el-breadcrumb-item>
              </el-breadcrumb>
              <!-- <keep-alive>
                <router-view
                  v-if="item.name === mainTabsActiveName"
                ></router-view>
              </keep-alive> -->

              <router-view></router-view>
            </el-card>
          </el-tabs>
        </keep-alive>
      </el-main>
    </el-container>
  </el-container>
</template>
<script>
// import Header from './Header.vue'
import Menu from "./Menu.vue";
export default {
  data() {
    return {
      userName: "",
      isCollapse: false,
      BreadcrumbList: [],
      mainTabsActiveName: "/welcome",
      editableTabs: [
        {
          title: "首页",
          name: "/welcome",
        },
      ],
    };
  },
  methods: {
    toggleCollapse() {
      this.isCollapse = !this.isCollapse;
    },
    logout() {
      const _this = this;
      this.$http
        .post("/api/logout", {})
        .then((res) => {
          if (res.code == 0) {
            _this.$store.commit("clear_state");
            const vue = this;
            vue.$router.push("/login");
          } else {
            _this.$message.error(res.msg);
          }
        })
        .catch((err) => {
          console.log(err.message);
        });
    },
    changeBreadcrumb(params) {
      this.mainTabsActiveName = "";
      this.BreadcrumbList = params;
      if (params.length == 2) {
        let tab = this.editableTabs.filter(
          (item) => item.name === params[1].menuUrl
        );
        if (tab.length >= 1) {
          this.mainTabsActiveName = params[1].menuUrl;
        } else {
          if (params[1].menuUrl != "/welcome") {
            // this.editableTabs.push({
            //   title: params[1].menuName,
            //   name: params[1].menuUrl,
            //   BreadcrumbList: params,
            // });
            tab = {
              title: params[1].menuName,
              name: params[1].menuUrl,
              BreadcrumbList: params,
            };
            this.editableTabs = this.editableTabs.concat(tab);
          }
          this.mainTabsActiveName = params[1].menuUrl;
        }
      } else {
        let tab = this.editableTabs.filter(
          (item) => item.name === params[0].menuUrl
        );
        if (params[0].menuUrl != "/welcome") {
          // this.editableTabs.push({
          //   title: params[0].menuName,
          //   name: params[0].menuUrl,
          //   BreadcrumbList: params,
          // });
          tab = {
            title: params[0].menuName,
            name: params[0].menuUrl,
            BreadcrumbList: params,
          };
          this.editableTabs = this.editableTabs.concat(tab);
        }
        this.mainTabsActiveName = params[0].menuUrl;
      }
    },
    removeTab(tab) {
      this.editableTabs = this.editableTabs.filter((item) => item.name !== tab);
      if (this.editableTabs.length >= 1) {
        // 当前选中tab被删除
        if (tab === this.mainTabsActiveName) {
          let path = this.editableTabs[this.editableTabs.length - 1].name;
          this.mainTabsActiveName = path;
          this.$router.push({
            path: path,
          });
          this.$refs.menu.defaultActive = path;
        }
      } else {
        this.mainTabsActiveName = "/welcome";
        this.$router.push({ path: "/welcome" });
        this.$refs.menu.defaultActive = "/welcome";
      }
    },
    tabClick(tab) {
      tab = this.editableTabs.filter((item) => item.name === tab.name);
      console.log("tab.length---" + tab.length);
      if (tab.length >= 1) {
        //this.$router.replace(tab[0].name);
        this.$router.push({ path: tab[0].name });
        this.$refs.menu.defaultActive = tab[0].name;
        this.BreadcrumbList = tab[0].BreadcrumbList;
      }
    },
    goHome() {
      this.mainTabsActiveName = "/welcome";
      this.$router.push({ path: "/welcome" });
      this.$refs.menu.defaultActive = "/welcome";
    },
    // tabs, 关闭当前
    tabsCloseCurrentHandle() {
      this.removeTab(this.mainTabsActiveName)
    },
    // tabs, 关闭其它
    tabsCloseOtherHandle() {
      this.editableTabs = this.editableTabs.filter(item => item.name === this.mainTabsActiveName || item.name == '/welcome')
      let path = this.editableTabs[this.editableTabs.length - 1].name;
      this.mainTabsActiveName = path;
      this.$router.push({
        path: path,
      });
      this.$refs.menu.defaultActive = path;
    },
    // tabs, 关闭全部
    tabsCloseAllHandle() {
      this.editableTabs = this.editableTabs.filter(item => item.name === '/welcome')
      let path = this.editableTabs[this.editableTabs.length - 1].name;
      this.mainTabsActiveName = path;
      this.$router.push({
        path: path,
      });
      this.$refs.menu.defaultActive = path;
    },
    // tabs, 刷新当前
    tabsRefreshCurrentHandle() {
      let path = this.mainTabsActiveName;
      this.removeTab(this.mainTabsActiveName)
      this.$router.push({
        path: path,
      });
    }
  },
  computed: {
    siteContentViewHeight() {
      var height = document.documentElement["clientHeight"] - 50 - 30 - 2;
      return { minHeight: height + "px" };
    },
    setMarginLeft() {
      if (this.isCollapse) {
        return { marginLeft: "64px" };
      } else {
        return { marginLeft: "200px" };
      }
      // if (this.isCollapse) {
      //   return { marginLeft: "0px" };
      // } else {
      //   return { marginLeft: "0px" };
      // }
    },
  },
  components: {
    Menu,
  },
};
</script>
<style lang="less" scoped>
.home-container {
  height: 100%;
}
.el-header {
  background-color: #20a0ff !important;
  display: flex;
  justify-content: space-between;
  padding-left: 5px;
  align-items: center;
  color: #fff;
  font-size: 20px;
  position: fixed;
  height: 50px !important;
  line-height: 50px !important;
  left: 0px;
  top: 0px;
  width: 100%;
  z-index: 230;
  div {
    display: flex;
    align-items: center;
    span {
      margin-left: 15px;
    }
    img {
      height: 100%;
      height: 45px;
    }
  }
  .el-dropdown-link {
    > img {
      width: 36px;
      height: auto;
      margin-right: 5px;
      border-radius: 100%;
      vertical-align: middle;
    }
  }
}
.main-container {
  position: relative;
  top: 50px;
  .el-aside {
    background-color: white;
    position: fixed;
    max-width: 200px;

    .el-menu {
      border-right: none;
      text-align: left;
    }
    .toggle-button {
      background-color: white;
      font-size: 10px;
      line-height: 24px;
      color: #000000;
      text-align: center;
      letter-spacing: 0.2em;
      cursor: pointer;
      border-top: solid 1px #cccccc;
      border-bottom: solid 1px #cccccc;
    }
  }
  .el-main {
    background-color: #eaedf1;
    padding: 0px;
    .el-tabs {
      .el-tabs__header {
        background-color: red !important;
      }
      .el-tabs__content {
        background-color: #eaedf1 !important;

        .el-breadcrumb {
          height: 20px;
        }
        .el-tabs__item {
          min-width: 90px !important;
        }
        .site-tabs__tools {
          position: absolute !important;
        }
      }
    }
  }
}
.site-tabs__tools {
  position: absolute;
  top: 0px;
  right: 0;
  z-index: 100;
  height: 40px;
  padding: 0 12px;
  font-size: 16px;
  line-height: 40px;
  background-color: #ffffff;
  cursor: pointer;
}
</style>
