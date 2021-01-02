
<template>
  <el-menu
    background-color="#FFFFFF"
    text-color="#000000"
    active-text-color="#409BFF"
    :unique-opened="true"
    :collapse="isCollapse"
    :collapse-transition="true"
    :router="true"
    :default-active="defaultActive"
  >
    <el-menu-item index="/welcome" @click="saveNavHomeState()">
      <i class="el-icon-s-home" />
      <span slot="title">首页</span>
    </el-menu-item>
    <el-submenu v-for="item in menuList" :index="item.id" :key="item.id">
      <template slot="title">
        <i :class="item.menuIcon"></i>
        <span>{{ item.menuName }}</span>
      </template>
      <el-menu-item
        :index="subitem.menuUrl"
        v-for="subitem in item.childrens"
        :key="subitem.id"
        @click="saveNavState(item, subitem)"
      >
        <template slot="title">
          <i :class="subitem.menuIcon"></i>
          <span>{{ subitem.menuName }}</span>
        </template>
      </el-menu-item>
    </el-submenu>
  </el-menu>
</template>
<script>
export default {
  name: "Menu",
  data() {
    return {
      menuList: [],
      defaultActive: "/welcome",
    };
  },
  props: {
    BreadcrumbList: Array,
  },
  methods: {
    /**
     * 加载用户有权限的菜单信息
     * 非树形结构
     */
    loadMenu() {
      this.$http
        .get("/api/sysMenu/user-list")
        .then((res) => {
          if (res.code == 0) {
            this.$store.commit("set_menu", res.data);
          }
        })
        .catch((err) => {
          console.log(err.message);
        });
    },
    /**
     * 加载用户菜单 树形结构
     */
    loadTreeMenu() {
      this.$http
        .get("/api/sysMenu/user-tree-list")
        .then((res) => {
          if (res.code == 0) {
            this.menuList = res.data;
            if (this.defaultActive == "/welcome") {
              this.$emit("changeBreadcrumb", [
                { menuName: "首页", menuUrl: "/welcome" },
              ]);
            } else {
              this.menuList.forEach((element) => {
                element.childrens.forEach((citem) => {
                  if (citem.menuUrl == this.defaultActive) {
                    this.$emit("changeBreadcrumb", [element, citem]);
                    return;
                  }
                });
              });
            }
          } else {
            this.$message.error(res.msg);
          }
        })
        .catch((err) => {
          console.log(err.message);
        });
    },
    saveNavState(pmenu, event) {
      console.log("点击的菜单----" + JSON.stringify(event));
      this.$emit("changeBreadcrumb", [pmenu, event]);
    },
    saveNavHomeState() {
      console.log("点击的菜单----" + JSON.stringify(event));
      let menu = { menuUrl: "/welcome", menuName: "首页" };
      this.$emit("changeBreadcrumb", [menu]);
    },
    setCurrentRoute() {
      this.defaultActive = this.$route.path; // 关键   通过他就可以监听到当前路由状态并激活当前菜单
    },
  },
  created() {
    this.loadTreeMenu();
    this.loadMenu();
    this.setCurrentRoute();
  },
  props: {
    // eslint-disable-next-line vue/require-prop-type-constructor
    isCollapse: false,
  },
};
</script> 
<style lang="less" scoped>
.el-menu-item.is-active {
  color: #409eff;
  border-right: #409eff solid 3px;
}
</style>