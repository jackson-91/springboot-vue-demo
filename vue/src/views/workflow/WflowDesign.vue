<template>
  <div class="flow-container">
    <div class="containers"
         ref="content">
      <div class="canvas"
           ref="canvas"></div>
      <div id="js-properties-panel"
           class="panel"></div>
      <ul class="buttons">
        <li>
          <el-upload :show-file-list="false"
                     action=""
                     :auto-upload="false"
                     :on-change="handleOpenFile"
                     class="import">
            <a slot="trigger"
               ref="import"
               href="javascript:"
               title="import BPMN diagram">导入 BPMN diagram</a>
          </el-upload>
        </li>
        <li>
          <a ref="saveDiagram"
             href="javascript:"
             title="download BPMN diagram">下载 BPMN diagram</a>
        </li>
        <li>
          <a ref="saveSvg"
             href="javascript:"
             title="download as SVG image">下载 SVG image</a>
        </li>
        <li style="display:none"> 
          <a ref="deployBpm" class="active"
             @click="deployBpm"
             title="部署流程">部署</a>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
// 引入相关的依赖
// import BpmnViewer from 'bpmn-js'
import BpmnModeler from 'bpmn-js/lib/Modeler'
import propertiesPanelModule from 'bpmn-js-properties-panel-activiti'
//import propertiesPanelModule from 'bpmn-js-properties-panel'
// import activitiModdleDescriptor from '../../plugins/activiti.json'
import propertiesProviderModule from 'bpmn-js-properties-panel-activiti/lib/provider/activiti'
//import propertiesProviderModule from 'bpmn-js-properties-panel/lib/provider/camunda'
import camundaModdleDescriptor from 'activiti-bpmn-moddle/resources/activiti'
//import camundaModdleDescriptor from 'camunda-bpmn-moddle/resources/camunda'
import customTranslate from '../../plugins/translate/customTranslate'
// import activitiExtensionModule from 'activiti-bpmn-moddle/lib'
// import activitiModdle from 'activiti-bpmn-moddle/resources/activiti'
export default {
  data () {
    return {
      // bpmn建模器
      bpmnModeler: null,
      container: null,
      canvas: null,
      xmlStr: null,
      processName: ''
    }
  },
  methods: {
    /**
     * 设置默认模板
     */
    createNewDiagram () {
      const bpmnXmlStr = '<?xml version="1.0" encoding="UTF-8"?>\n' +
        '<bpmn2:definitions xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:activiti="http://activiti.org/bpmn" xmlns:normal="http://flowable.org/bpmn/normal" xmlns:bpmn2="http://www.omg.org/spec/BPMN/20100524/MODEL" xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI" xmlns:dc="http://www.omg.org/spec/DD/20100524/DC" xmlns:di="http://www.omg.org/spec/DD/20100524/DI" xsi:schemaLocation="http://www.omg.org/spec/BPMN/20100524/MODEL BPMN20.xsd" id="sample-diagram" targetNamespace="http://bpmn.io/schema/bpmn">\n' +
        '  <bpmn2:process id="test_process"  >\n' +
        '    <bpmn2:startEvent id="StartEvent_1"/>\n' +
        '  </bpmn2:process>\n' +
        '  <bpmndi:BPMNDiagram id="BPMNDiagram_1">\n' +
        '    <bpmndi:BPMNPlane id="BPMNPlane_1" bpmnElement="Process_1">\n' +
        '      <bpmndi:BPMNShape id="_BPMNShape_StartEvent_2" bpmnElement="StartEvent_1">\n' +
        '        <dc:Bounds height="36.0" width="36.0" x="412.0" y="240.0"/>\n' +
        '      </bpmndi:BPMNShape>\n' +
        '    </bpmndi:BPMNPlane>\n' +
        '  </bpmndi:BPMNDiagram>\n' +
        '</bpmn2:definitions>'
      // 将字符串转换成图显示出来
      this.bpmnModeler.importXML(bpmnXmlStr, function (err) {
        if (err) {
          console.error(err)
        }
      })
    },
    // 下载为SVG格式,done是个函数，调用的时候传入的
    saveSVG (done) {
      // 把传入的done再传给bpmn原型的saveSVG函数调用
      this.bpmnModeler.saveSVG(done)
    },
    // 下载为SVG格式,done是个函数，调用的时候传入的
    saveDiagram (done) {
      // 把传入的done再传给bpmn原型的saveXML函数调用
      this.bpmnModeler.saveXML({ format: true }, function (err, xml) {
        done(err, xml)
      })
    },
    // 下载为SVG格式,done是个函数，调用的时候传入的
    deployBpm (done) {
      // 把传入的done再传给bpmn原型的saveSVG函数调用
      // this.bpmnModeler.saveSVG(done)  
      console.log(this.xmlStr);
    },
    // 上传文件
    handleOpenFile (file) {
      let _this = this
      let reads = new FileReader()
      let f = file.raw
      reads.readAsText(f, 'utf-8')
      reads.onload = function (e) {
        let newXml = e.target.result
        _this.bpmnModeler.importXML(newXml, function (err) {
          if (err) {
            console.error(err)
          }
        })
      }
    },
    // 当图发生改变的时候会调用这个函数，这个data就是图的xml
    setEncoded (link, name, data) {
      // 把xml转换为URI，下载要用到的
      const encodedData = encodeURIComponent(data)
      // 获取到图的xml，保存就是把这个xml提交给后台
      this.xmlStr = data
      // 下载图的具体操作,改变a的属性，className令a标签可点击，href令能下载，download是下载的文件的名字
      if (data) {
        link.className = 'active'
        link.href = 'data:application/bpmn20-xml;charset=UTF-8,' + encodedData
        link.download = name
      }
    }
  },
  mounted () {
    const customTranslateModule = {
      translate: ['value', customTranslate]
    }
    // 获取到属性ref为“content”的dom节点
    this.container = this.$refs.content
    // 获取到属性ref为“canvas”的dom节点
    const canvas = this.$refs.canvas

    // 建模，官方文档这里讲的很详细
    this.bpmnModeler = new BpmnModeler({
      container: canvas,
      // 添加控制板
      propertiesPanel: {
        parent: '#js-properties-panel'
      },
      additionalModules: [
        // 左边工具栏以及节点
        propertiesProviderModule,
        // 右边的工具栏
        propertiesPanelModule,
        // 汉化
        customTranslateModule
        // activiti
        // activitiExtensionModule
      ],
      moddleExtensions: {
        camunda: camundaModdleDescriptor
        // activiti: activitiModdleDescriptor
        // activiti: activitiModdle
      }
    })

    // 下载画图
    const _this = this
    // 获取a标签dom节点
    const downloadLink = this.$refs.saveDiagram
    const downloadSvgLink = this.$refs.saveSvg
    const deployBpmLink = this.$refs.deployBpm
    const handleOpenFileLink = this.$refs.handleOpenFile
    // 给图绑定事件，当图有发生改变就会触发这个事件
    this.bpmnModeler.on('commandStack.changed', function () {
      _this.saveSVG(function (err, svg) {
        _this.setEncoded(downloadSvgLink, 'diagram.svg', err ? null : svg)
      })

      _this.saveDiagram(function (err, xml) {
        console.log('xiazaixml---' + xml)
        _this.setEncoded(downloadLink, 'diagram.bpmn', err ? null : xml)
      })

    })

    this.createNewDiagram(this.bpmnModeler)
  }
}
</script>

<style lang="less" scoped>
/*左边工具栏以及编辑节点的样式*/
@import "~bpmn-js/dist/assets/diagram-js.css";
@import "~bpmn-js/dist/assets/bpmn-font/css/bpmn.css";
@import "~bpmn-js/dist/assets/bpmn-font/css/bpmn-codes.css";
@import "~bpmn-js/dist/assets/bpmn-font/css/bpmn-embedded.css";
.flow-container {
  display: flex;
}
/*右边工具栏样式*/
@import "~bpmn-js-properties-panel/dist/assets/bpmn-js-properties-panel.css";
.containers {
  position: absolute;
  background-color: #ffffff;
  width: 85%;
  height: 85%;
}
.canvas {
  width: 100%;
  height: 100%;
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
