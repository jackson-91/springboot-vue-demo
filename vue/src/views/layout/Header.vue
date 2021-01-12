<template>
  <div>
    <div>
      <img src="../../assets/logo.png" alt />
      <span>后台管理系统</span>
    </div>
    <el-button type="info" @click="logout()">退出</el-button>
      <el-dropdown :show-timeout="0" placement="bottom">
        <span class="el-dropdown-link">
          <img src="~@/assets/img/avatar.png" :alt="userName" />{{ userName }}
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item @click.native="updatePasswordHandle()"
            >修改密码</el-dropdown-item
          >
          <el-dropdown-item @click.native="logoutHandle()"
            >退出</el-dropdown-item
          >
        </el-dropdown-menu>
      </el-dropdown>
  </div>
</template>
<script>
export default {
  name: "Header",
  props: {
    msg: String,
  },
  methods: {
    logout() {
      const _this = this;
      this.$http
        .post("/api/logout", {})
        .then((res) => {
          if (res.code == 0) {
            _this.$store.commit("set_token", "");
            _this.$message.success("登出成功");
            const vue = this;
            vue.$router.push("/home");
          } else {
            _this.$message.error(res.msg);
          }
        })
        .catch((err) => {
          console.log(err.message);
        });
    },
  },
};
</script>
<style lang="less" scoped>
html {
  padding: 0px;
}
.el-header {
  background-color: #20a0ff !important;
  display: flex;
  justify-content: space-between;
  padding-left: 5px;
  align-items: center;
  color: #fff;
  font-size: 20px;
  div {
    display: flex;
    align-items: center;
    span {
      margin-left: 15px;
    }
    img {
      height: 100%;
      height: 50px;
    }
  }
  .site-navbar__avatar {
    width: 100px;
    background-color: red;
  }
}
</style>
