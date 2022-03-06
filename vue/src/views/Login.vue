<template>
  <div class="login_container">
    <div class="login_box">
      <div class="avatar_box">
        <img src="../assets/logo.png" alt />
      </div>
      <el-form ref="loginFormRef" :model="loginForm" :rules="loginFormRules" label-width="0px" class="login_form">
        <!--用户名-->
        <el-form-item prop="username">
          <el-input v-model="loginForm.username" prefix-icon="el-icon-user-solid"></el-input>
        </el-form-item>
        <!--密码-->
        <el-form-item prop="password">
          <el-input v-model="loginForm.password" type="password" prefix-icon="el-icon-star-on"></el-input>
        </el-form-item>
        <!--密码-->
        <el-form-item prop="verifyCode">
          <el-input v-model="loginForm.verifyCode" prefix-icon="el-icon-picture-outline" auto-complete="off" placeholder="验证码" style="width: 67%"
            @keyup.enter.native="onSubmit" />
          <div class="login-code">
            <img src="api/captcha/verifyCode?type=math" ref="verifyCodeImg" onclick="this.src='api/captcha/verifyCode?type=math&d='+new Date()*1"
              class="login-code-img" />
          </div>
        </el-form-item>
        <!--按钮-->
        <el-form-item class="btns">
          <el-button type="primary" @click="onSubmit">登录</el-button>
          <el-button type="info" @click="reset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      loginForm: {
        username: "",
        password: "",
      },
      loginFormRules: {
        username: [
          { required: true, message: "请输入用户名称", trigger: "blur" },
        ],
        password: [{ required: true, message: "请输入密码", trigger: "blur" }],
        verifyCode: [{ required: true, message: "请输入验证码", trigger: "blur" }],
      },
      // 验证码开关
      captchaFlag: true,
      codeUrl: 'api/captcha/verifyCode?type=char',
    };
  },
  methods: {
    onSubmit() {
      if (!this.captchaFlag) {
        this.loginFormRules.verifyCode[0]['required'] = false;
      }
      this.$refs.loginFormRef.validate((valid) => {
        if (valid) {
          const formData = new FormData();
          formData.append("username", this.loginForm.username);
          formData.append("password", this.loginForm.password);
          formData.append("verifyCode", this.loginForm.verifyCode);
          const _this = this;
          this.$http
            .post("/api/login", formData)
            .then((res) => {
              if (res.code == 0) {
                _this.$store.commit("set_token", res.data);
                _this.$message.success("登录成功");
                const vue = this;
                // vue.$router.push("/home");
                _this.loadDic();
                _this.loadUserInfo();
              } else {
                _this.$refs.verifyCodeImg.onclick();
                _this.$message.error(res.msg);
              }
            })
            .catch((err) => {
              debugger;
              _this.$refs.verifyCodeImg.onclick();
              console.log(err.message);
            });
        } else {
          this.$refs.verifyCodeImg.onclick();
          console.log("error submit!!");
          return false;
        }
      });
    },
    /**
     * 加载数据字典
     */
    loadDic() {
      const _this = this;
      this.$http
        .get("/api/sysDic/all-list", {})
        .then((res) => {
          if (res.code == 0) {
            _this.$store.commit("set_dicset", res.data);
          }
        })
        .catch((err) => { });
    },
    /**
     * 加载用户信息
     */
    loadUserInfo() {
      const _this = this;
      const vue = this;
      this.$http
        .post("/api/sysUser/user-info", {})
        .then((res) => {
          if (res.code == 0) {
            _this.$store.commit("set_user", res.data);
          }
          vue.$router.push("/home");
        })
        .catch((err) => { });
    },
    reset() {
      this.$refs.loginFormRef.resetFields();
    },
  },
  created() {
    this.$http
      .get("/api/captcha/verifyCodeFlag", {})
      .then((res) => {
        if (res.code == 0) {
          this.captchaFlag = res.data;
        }
      })
      .catch((err) => { });
  }
};
</script>

<style lang="less" scoped>
.login_container {
  background-color: #2b4b6b;
  height: 100%;
}
.login_box {
  width: 450px;
  height: 300px;
  background-color: #ffffff;
  border-radius: 3px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}
.avatar_box {
  height: 130px;
  width: 130px;
  border: 1px solid #eeeeee;
  border-radius: 50%;
  padding: 10px;
  box-shadow: 0 0 10px #ddd;
  position: absolute;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: #ffffff;
  img {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    background-color: #eee;
  }
}
.login_form {
  position: absolute;
  bottom: 0;
  width: 100%;
  padding: 0 20px;
  box-sizing: border-box;
}
.btns {
  display: flex;
  justify-content: flex-end;
}
.login-code {
  width: 33%;
  height: 38px;
  float: right;
  img {
    cursor: pointer;
    vertical-align: middle;
  }
}
.login-code-img {
  height: 32px;
}
</style>
