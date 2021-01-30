<template>
  <div class="containers">
    <div class="canvas" ref="canvas"></div>
  </div>
</template>

<script>
import BpmnViewer from "bpmn-js/lib/NavigatedViewer";

export default {
  name: "BpmnViewer",
  props: {
    // 流程定义ID
    definitionId: {
      type: String,
      require: true,
    },
  },
  mounted() {
    this.init();
  },
  data() {
    return {
      bpmnViewer: null,
      container: null,
      canvas: null,
    };
  },
  methods: {
    init() {
      const canvas = this.$refs.canvas;
      this.bpmnViewer = new BpmnViewer({
        container: canvas,
      });
    },
  },
  watch: {
    // 监听show,visible 随着show变化而变化
    definitionId: {
      immediate: true,
      handler(definitionId) {
        this.processDefinitionId = definitionId;
        this.$http
          .get("/api/wflowDefine/bpmnXml", {
            params: {
              definitionId: this.processDefinitionId,
            },
          })
          .then((res) => {
            if (res.code == "0") {
              const bpmnXmlStr = res.data;
              console.log(bpmnXmlStr);
              this.xmlStr = bpmnXmlStr;
              // 将字符串转换成图显示出来
              this.bpmnViewer.importXML(bpmnXmlStr, function (err) {
                if (err) {
                  console.error(err);
                  this.$message.error(err);
                }
              });
            } else {
              this.$message.error(res.msg);
            }
          })
          .catch((err) => {
            console.log(err.message);
          });
      },
    },
  },
};
</script>
<style lang="less" scoped>
.flow-container {
  display: flex;
}
.containers {
  position: absolute;
  background-color: #ffffff;
  width: 95%;
  height: 85%;
}
.canvas {
  width: 100%;
  height: 100%;
  background-image: linear-gradient(
      90deg,
      rgba(235, 235, 235, 1) 5%,
      rgba(0, 0, 0, 0) 5%
    ),
    linear-gradient(rgba(235, 235, 235, 1) 5%, rgba(0, 0, 0, 0) 5%);
  background-size: 1rem 1rem;
}
.panel {
  position: absolute;
  right: 0;
  top: 0;
  width: 320px;
  height: 100%;
  overflow-y: scroll;
  text-align: left !important;
  font-size: 15px !important;
}
.buttons {
  position: absolute;
  left: 20px;
  bottom: 20px;
  & > li {
    display: inline-block;
    margin: 5px;
    & > a {
      color: #999;
      background: #eee;
      cursor: not-allowed;
      padding: 8px;
      border: 1px solid #ccc;
      &.active {
        color: #333;
        background: #fff;
        cursor: pointer;
      }
    }
  }
}

.import {
  color: #333;
  background: #fff;
  cursor: pointer;
  padding: 8px;
  border: 1px solid #ccc;
}
.import a {
  color: #333;
  cursor: pointer;
}
.group-label {
  font-weight: normal !important;
  display: inline-block !important;
  vertical-align: middle !important;
  color: #666 !important;
  margin-top: 5px !important;
  margin-bottom: 10px !important;
  transition: margin 0.218s linear !important;
  font-style: italic !important;
  font-size: 15px !important;
}
input {
  width: 95% !important;
}
</style>