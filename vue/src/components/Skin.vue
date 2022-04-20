<template>
  <div>
    <span class="el-icon-setting" style="font-size: 14px; cursor: pointer; margin-left: 10px;" @click="drawerFlag = true"></span>
    <!--皮肤-->
    <el-drawer :visible.sync="drawerFlag" :with-header="false" style="text-align: left;" :append-to-body="true">
      <div style="padding: 10px">
        <div style="padding: 10px 10px 20px 8px">皮肤</div>
        <div>
          <ul class="list-unstyled clearfix skin-list">
            <li @click="doBgItem('skin-blue')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 20%; height: 27px; background: #4e73df">
                    <span style=" width: 100%;   height: 7px;  margin-top: 0px;  background: #ffffff;  "></span> </span><span style="width: 80%; height: 27px; background: #f4f5f7"></span>
                </div>
              </a>
              <p class="text-center no-margin">Blue</p>
            </li>
            <li @click="doBgItem('skin-black')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 20%; height: 27px; background: #000"><span style="
                          width: 100%;
                          height: 7px;
                          margin-top: 0px;
                          background: #ffffff;
                        "></span></span><span style="width: 80%; height: 27px; background: #f4f5f7"></span>
                </div>
              </a>
              <p class="text-center no-margin">Black</p>
            </li>
            <li @click="doBgItem('skin-purple')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 20%; height: 27px; background: #605ca8"><span style="
                          width: 100%;
                          height: 7px;
                          margin-top: 0px;
                          background: #ffffff;
                        "></span></span><span style="width: 80%; height: 27px; background: #f4f5f7"></span>
                </div>
              </a>
              <p class="text-center no-margin">Purple</p>
            </li>
            <li @click="doBgItem('skin-green')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 20%; height: 7px" class="bg-green-active"></span><span class="bg-green" style="width: 80%; height: 7px"></span>
                </div>
                <div>
                  <span style="width: 20%; height: 20px; background: #000"></span><span style="width: 80%; height: 20px; background: #f4f5f7"></span>
                </div>
              </a>
              <p class="text-center no-margin">Green</p>
            </li>
            <li @click="doBgItem('skin-red')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 20%; height: 7px" class="bg-red-active"></span><span class="bg-red" style="width: 80%; height: 7px"></span>
                </div>
                <div>
                  <span style="width: 20%; height: 20px; background: #000"></span><span style="width: 80%; height: 20px; background: #f4f5f7"></span>
                </div>
              </a>
              <p class="text-center no-margin">Red</p>
            </li>
            <li @click="doBgItem('skin-yellow')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 20%; height: 7px" class="bg-yellow-active"></span><span class="bg-yellow" style="width: 80%; height: 7px"></span>
                </div>
                <div>
                  <span style="width: 20%; height: 20px; background: #000"></span><span style="width: 80%; height: 20px; background: #f4f5f7"></span>
                </div>
              </a>
              <p class="text-center no-margin">Yellow</p>
            </li>

            <li @click="doBgItem('skin-blue-light')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 100%; height: 7px; background: #4e73df"></span>
                </div>
                <div>
                  <span style="width: 100%; height: 20px; background: #f9fafc"></span>
                </div>
              </a>
              <p class="text-center no-margin" style="font-size: 12px">
                Blue Light
              </p>
            </li>
            <li @click="doBgItem('skin-black-light')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 100%; height: 7px; background: #000"></span>
                </div>
                <div>
                  <span style="width: 100%; height: 20px; background: #f9fafc"></span>
                </div>
              </a>
              <p class="text-center no-margin" style="font-size: 12px">
                Black Light
              </p>
            </li>
            <li @click="doBgItem('skin-purple-light')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 100%; height: 7px; background: #605ca8"></span>
                </div>
                <div>
                  <span style="width: 100%; height: 20px; background: #f9fafc"></span>
                </div>
              </a>
              <p class="text-center no-margin" style="font-size: 12px">
                Purple Light
              </p>
            </li>
            <li @click="doBgItem('skin-green-light')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 100%; height: 7px" class="bg-green"></span>
                </div>
                <div>
                  <span style="width: 100%; height: 20px; background: #f9fafc"></span>
                </div>
              </a>
              <p class="text-center no-margin" style="font-size: 12px">
                Green Light
              </p>
            </li>
            <li @click="doBgItem('skin-red-light')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 100%; height: 7px" class="bg-red"></span>
                </div>
                <div>
                  <span style="width: 100%; height: 20px; background: #f9fafc"></span>
                </div>
              </a>
              <p class="text-center no-margin" style="font-size: 12px">
                Red Light
              </p>
            </li>
            <li @click="doBgItem('skin-yellow-light')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 100%; height: 7px" class="bg-yellow"></span>
                </div>
                <div>
                  <span style="width: 100%; height: 20px; background: #f9fafc"></span>
                </div>
              </a>
              <p class="text-center no-margin" style="font-size: 12px">
                Yellow Light
              </p>
            </li>

            <li @click="doBgItem('skin-black-blue')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 20%; height: 27px; background: #000">
                    <span style="
                          width: 100%;
                          height: 7px;
                          margin-top: 0px;
                          background: #ffffff;
                        "></span>
                    <span style="
                          width: 100%;
                          height: 3px;
                          margin-top: 10px;
                          background: #4e73df;
                        "></span></span><span style="width: 80%; height: 27px; background: #f4f5f7"></span>
                </div>
              </a>
              <p class="text-center no-margin">Black Blue</p>
            </li>
            <li @click="doBgItem('skin-black-purple')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 20%; height: 27px; background: #000">
                    <span style="
                          width: 100%;
                          height: 7px;
                          margin-top: 0px;
                          background: #ffffff;
                        "></span>
                    <span style="
                          width: 100%;
                          height: 3px;
                          margin-top: 10px;
                          background: #605ca8;
                        "></span></span><span style="width: 80%; height: 27px; background: #f4f5f7"></span>
                </div>
              </a>
              <p class="text-center no-margin">Black Purple</p>
            </li>
            <li @click="doBgItem('skin-black-green')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 20%; height: 27px; background: #000">
                    <span style="
                          width: 100%;
                          height: 7px;
                          margin-top: 0px;
                          background: #ffffff;
                        "></span>
                    <span style="width: 100%; height: 3px; margin-top: 10px" class="bg-green"></span></span><span style="width: 80%; height: 27px; background: #f4f5f7"></span>
                </div>
              </a>
              <p class="text-center no-margin">Black Green</p>
            </li>
            <li @click="doBgItem('skin-black-red')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 20%; height: 27px; background: #000">
                    <span style="
                          width: 100%;
                          height: 7px;
                          margin-top: 0px;
                          background: #ffffff;
                        "></span>
                    <span style="width: 100%; height: 3px; margin-top: 10px" class="bg-red"></span></span><span style="width: 80%; height: 27px; background: #f4f5f7"></span>
                </div>
              </a>
              <p class="text-center no-margin">Black Red</p>
            </li>
            <li @click="doBgItem('skin-black-yellow')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 20%; height: 27px; background: #000">
                    <span style="
                          width: 100%;
                          height: 7px;
                          margin-top: 0px;
                          background: #ffffff;
                        "></span>
                    <span style="width: 100%; height: 3px; margin-top: 10px" class="bg-yellow"></span></span><span style="width: 80%; height: 27px; background: #f4f5f7"></span>
                </div>
              </a>
              <p class="text-center no-margin">Black Yellow</p>
            </li>
            <li @click="doBgItem('skin-black-pink')">
              <a href="javascript:;" class="clearfix full-opacity-hover">
                <div>
                  <span style="width: 20%; height: 27px; background: #000">
                    <span style="
                          width: 100%;
                          height: 7px;
                          margin-top: 0px;
                          background: #ffffff;
                        "></span>
                    <span style="
                          width: 100%;
                          height: 3px;
                          margin-top: 10px;
                          background: #f5549f;
                        "></span></span><span style="width: 80%; height: 27px; background: #f4f5f7"></span>
                </div>
              </a>
              <p class="text-center no-margin">Black Pink</p>
            </li>
          </ul>
        </div>
      </div>
    </el-drawer>
  </div>
</template>

<script>
export default {
  data() {
    return {
      drawerFlag: false,
    }
  },
  methods: {
    doBgItem(item) {
      console.log(item);
      document.body.setAttribute("class", item);
      localStorage.setItem("skin", item);
    },
  }
}
</script>

<style lang="less" scoped>
.el-drawer__wrapper {
  /deep/ .el-drawer__body {
    background: #222d32;
    color: #fff;
  }
}
ul {
  list-style: none;
  padding: 0;
}
li {
  text-align: center;
  box-sizing: border-box;
  font-size: 12px;
}
.skin-list li {
  float: left;
  width: 33.33333%;
  padding: 5px;
}
.skin-list li a {
  display: block;
  box-shadow: 0 0 3px rgb(0 0 0 / 40%);
}
.skin-list li a span {
  display: block;
  float: left;
}

.list-unstyled,
.chart-legend,
.contacts-list,
.users-list,
.mailbox-attachments {
  list-style: none;
  margin: 0;
  padding: 0;
}
.clearfix:before,
.clearfix:after,
.content:before,
.content:after {
  content: " ";
  display: table;
}
.clearfix:after {
  clear: both;
}
.full-opacity-hover {
  opacity: 0.65;
}
.full-opacity-hover:hover {
  opacity: 1;
}
.bg-red-active,
.modal-danger .modal-header,
.modal-danger .modal-footer {
  background-color: #e43321 !important;
}
.bg-red,
.callout.callout-danger,
.alert-danger,
.alert-error,
.modal-danger .modal-body {
  background-color: #e74c3c !important;
}
.bg-yellow-active,
.modal-warning .modal-header,
.modal-warning .modal-footer {
  background-color: #db8b0b !important;
}
.bg-yellow,
.callout.callout-warning,
.alert-warning,
.modal-warning .modal-body {
  background-color: #f39c12 !important;
}
.bg-green-active,
.modal-success .modal-header,
.modal-success .modal-footer {
  background-color: #15a589 !important;
}
.bg-green,
.callout.callout-success,
.alert-success,
.modal-success .modal-body {
  background-color: #18bc9c !important;
}
</style>