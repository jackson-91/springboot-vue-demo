<template>
  <div class="containers">
    <div class="canvas" ref="canvas"></div>
  </div>
</template>

<script>
// import BpmnViewer from "bpmn-js/lib/Viewer";
import BpmnModeler from "bpmn-js/lib/Modeler";
export default {
  name: "FlowBpmnViewer",
  props: {
    // 流程定义ID
    instanceId: {
      type: String,
      require: true,
    },
    //任务ID
    taskId: {
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
      flowCurrentId: [],
      flowEndId: [],
    };
  },
  methods: {
    init() {
      const canvas = this.$refs.canvas;
      this.bpmnViewer = new BpmnModeler({
        container: canvas,
        additionalModules: [
          {
            // 禁用滚轮滚动
            zoomScroll: ["value", ""],
            // 禁止拖动线
            bendpoints: ["value", ""],
            // 禁用左侧面板
            paletteProvider: ["value", ""],
            // 禁止点击节点出现contextPad
            contextPadProvider: ["value", ""],
            // 禁止双击节点出现label编辑框
            labelEditingProvider: ["value", ""],
            // 禁止拖拽
            //moveCanvas: ['value', ''],
          }
        ]
      });
    },
  },
  watch: {
    // 监听show,visible 随着show变化而变化
    instanceId: {
      immediate: true,
      handler(instanceId) {
        if (this.bpmnViewer) {
          this.bpmnViewer.clear();
        }
        this.processInstanceId = instanceId;
        this.$http
          .get("/api/wflowChart/bpmn-traceprocess", {
            params: {
              processInstanceId: this.processInstanceId,
              taskId: this.taskId
            },
          })
          .then((res) => {
            if (res.code == "0") {
              const bpmnXmlStr = res.data.bpmXml;
              this.flowEndId = res.data.flowElementPassed;
              this.flowCurrentId = res.data.flowElementGoIng;
              console.log(bpmnXmlStr);
              this.xmlStr = bpmnXmlStr;
              let that = this;
              // 将字符串转换成图显示出来
              this.bpmnViewer.importXML(bpmnXmlStr, function (err) {
                let bpmnModeler = that.bpmnViewer;
                var elementRegistry = bpmnModeler.get('elementRegistry');
                var modeling = bpmnModeler.get('modeling');
                const allShapes = bpmnModeler.get("elementRegistry").getAll();

                //循环节点添加颜色
                allShapes.forEach(element => {
                  const shapeId = element.businessObject.id;
                  const shapeAttrs = element.businessObject.$attrs;
                  if (element.businessObject.$type != "bpmn:Group") {
                    if (element.businessObject.$type == "bpmn:SequenceFlow") {
                      //连线
                      if (that.flowEndId) {
                        let flowElement = that.flowEndId.filter(x => x == shapeId);
                        if (flowElement.length > 0) {
                          modeling.setColor([element], {
                            stroke: 'green',
                            fill: '#d7f6ce'
                          });
                        }
                      }
                    } else {
                      if (shapeAttrs.status == '1') {
                        //已完成任务结点
                        modeling.setColor([element], {
                          stroke: 'black',
                          fill: '#d7f6ce'
                        });
                      } else if (shapeAttrs.status == '0') {
                        //当前任务结点
                        modeling.setColor([element], {
                          stroke: 'green',
                          fill: '#faa755'
                        });
                      } else {
                        //已完成结点
                        if (that.flowEndId) {
                          let flowElement = that.flowEndId.filter(x => x == shapeId);
                          if (flowElement.length > 0) {
                            modeling.setColor([element], {
                              stroke: 'black',
                              fill: '#d7f6ce'
                            });
                          }
                        }
                        //当前任务结点
                        if (that.flowCurrentId) {
                          let flowElement = that.flowCurrentId.filter(x => x == shapeId);
                          if (flowElement.length > 0) {
                            modeling.setColor([element], {
                              stroke: 'green',
                              fill: '#faa755'
                            });
                          }
                        }
                      }
                    }
                  }
                });
                // add marker
                //   if (element.businessObject.$type != "bpmn:Group") {
                //     if (element.businessObject.$type == "bpmn:SequenceFlow") {
                //       if (shapeAttrs.status == '1') {
                //         modeling.setColor([element], {
                //           stroke: 'green',
                //           fill: 'rgba(0, 80, 0, 0.4)'
                //         });
                //       } else {
                //         let flowElement = that.flowEndId.filter(x => x == shapeId);
                //         if (flowElement) {
                //           modeling.setColor([element], {
                //             stroke: 'green',
                //             fill: 'rgba(0, 80, 0, 0.4)'
                //           });
                //         }
                //       }
                //     } else {
                //       if (shapeAttrs.status == '1') {
                //         modeling.setColor([element], {
                //           stroke: 'green',
                //           fill: 'rgba(0, 80, 0, 0.4)'
                //         });
                //       } else {
                //         let flowElement = that.flowEndId.filter(x => x == shapeId);
                //         if (flowElement.lengt > 0) {
                //           modeling.setColor([element], {
                //             stroke: 'green',
                //             fill: 'rgba(0, 80, 0, 0.4)'
                //           });
                //         }
                //       }
                //     }
                //   }
                // });

                // const canvas = that.bpmnViewer.get("canvas");
                // canvas.zoom("fit-viewport", "auto");
                // let viewer = that.bpmnViewer;
                // let canvasP = viewer.get('canvas');
                //canvasP.addMarker('Activity_0hyrhxo', 'highlight');
                // access viewer components
                // const canvas = that.bpmnViewer.get("canvas");

                // // 获取到全部节点
                // const allShapes = that.bpmnViewer.get("elementRegistry").getAll();

                // //循环节点添加颜色
                // allShapes.forEach(element => {
                //   const shapeId = element.businessObject.id;
                //   const shapeAttrs = element.businessObject.$attrs;

                //   // add marker
                //   if (element.businessObject.$type != "bpmn:Group") {
                //     if (element.businessObject.$type == "bpmn:SequenceFlow") {
                //       canvas.addMarker(shapeId, "highlight");
                //     } else {
                //       canvas.addMarker(shapeId, "highlight");
                //     }
                //   }
                // });
                // var overlays = viewer.get('overlays'), elementRegistry = viewer.get('elementRegistry');
                // var shape = elementRegistry.get('Activity_0hyrhxo');
                // var $overlayHtml = $('<div class="highlight-overlay">').css({ width: shape.width, height: shape.height });
                // overlays.add('Activity_0hyrhxo', { position: { top: 0, left: 0 }, html: $overlayHtml });
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
<style  lang="less"  scoped>
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