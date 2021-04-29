<template>
  <div class="property-panel" ref="propertyPanel">
    <el-form :model="form" label-width="80px" size="mini">
      <el-form-item label="编号">
        <el-input v-model="form.id" disabled></el-input>
      </el-form-item>
      <el-form-item label="名称">
        <el-input v-model="form.name" @input="nameChange"></el-input>
      </el-form-item>
      <el-form-item label="描述">
        <el-input v-model="form.description" type="textarea" rows="4" @input="descriptionChange"></el-input>
      </el-form-item>
      <!-- 任务节点允许选择人员 -->
      <el-form-item label="审核人员" v-if="userTask">
        <el-select v-model="form.assigneeType" placeholder="请选择" @change="typeChange">
          <el-option value="user" label="指定人员"></el-option>
          <el-option value="role" label="角色"></el-option>
          <el-option value="job" label="岗位"></el-option>
          <el-option value="custom" label="自定义"></el-option>
        </el-select>
      </el-form-item>
      <!-- 指定人员 -->
      <el-form-item label="指定人员" v-if="userTask && form.assigneeType === 'user'">
        <el-select v-model="form.assigneeSelect" placeholder="请选择" key="1" @change="
            (value) =>
              addUser({
                'activiti:assignee': value,
                'activiti:assigneeSelect': value,
              })
          ">
          <el-option v-for="item in users" :key="item.id" :label="item.nickName" :value="item.id"></el-option>
        </el-select>
      </el-form-item>
      <!-- 指定角色 候选组 -->
      <el-form-item label="角色" v-else-if="userTask && form.assigneeType === 'role'">
        <el-select v-model="form.candidateUsersSelect" placeholder="请选择" key="2" @change="
            (value) =>
              addUser({
                'activiti:candidateGroups': value,
                'activiti:candidateUsersSelect': value,
              })
          ">
          <el-option v-for="item in roles" :key="item.id" :label="item.roleName" :value="item.roleCode"></el-option>
        </el-select>
      </el-form-item>
      <!-- 指定岗位 -->
      <el-form-item label="岗位" v-else-if="userTask && form.assigneeType === 'job'">
        <el-select v-model="form.candidateGroupsSelect" placeholder="请选择" @change="
            (value) =>
              addUser({
                'activiti:assignee': '${' + value + '}',
                'activiti:candidateGroupsSelect': value,
              })
          ">
          <el-option v-for="item in jobs" :key="item.code" :label="item.name" :value="item.code"></el-option>
        </el-select>
      </el-form-item>
      <!-- 自定义 -->
      <el-form-item label="自定义" v-else-if="userTask && form.assigneeType === 'custom'">
        <el-input v-model="form.assignee" @input="assigneeChange"></el-input>
      </el-form-item>
      <!-- 分支允许添加条件 -->
      <el-form-item label="分支条件" v-if="sequenceFlow">
        <el-input v-model="form.conditionExpression.body" @input="expressionChange"></el-input>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  name: "PropertyPanel",
  props: {
    modeler: {
      type: Object,
      required: true,
    },
  },
  computed: {
    userTask() {
      if (!this.element) {
        return;
      }
      return this.element.type === "bpmn:UserTask";
    },
    sequenceFlow() {
      if (!this.element) {
        return;
      }
      return this.element.type === "bpmn:SequenceFlow";
    },
    root() {
      if (!this.element) {
        return;
      }
      return this.element.type === "bpmn:Process";
    },
  },
  data() {
    return {
      form: {
        id: "",
        name: "",
        color: null,
        description: "",
        assignee: null,
        conditionExpression: { body: null },
      },
      element: {},
      users: [],
      roles: [],
      jobs: [],
    };
  },
  mounted() {
    this.handleModeler();
  },
  methods: {
    handleModeler() {
      // 监听节点选择变化
      this.modeler.on("selection.changed", (e) => {
        const element = e.newSelection[0];
        this.element = element;
        console.log(this.element);
        if (!element) return;
        const modeling = this.modeler.get("modeling");
        this.form = {
          ...element.businessObject,
          ...element.businessObject.$attrs,
        };
        if (this.sequenceFlow) {
          if (!this.form.conditionExpression) {
            this.form.conditionExpression = { body: null };
          }
        }

        if (element.businessObject.$attrs["activiti:description"]) {
          this.form.description =
            element.businessObject.$attrs["activiti:description"];
        }
        // activiti:assigneeSelect activiti:candidateUsersSelect activiti:candidateGroupsSelect
        if (element.type === "bpmn:UserTask") {
          if (element.businessObject.$attrs["activiti:assigneeSelect"]) {
            this.form.assigneeSelect =
              element.businessObject.$attrs["activiti:assigneeSelect"];
          }
          if (element.businessObject.$attrs["activiti:candidateUsersSelect"]) {
            this.form.candidateUsersSelect =
              element.businessObject.$attrs["activiti:candidateUsersSelect"];
          }
          if (element.businessObject.$attrs["activiti:candidateGroupsSelect"]) {
            this.form.candidateGroupsSelect =
              element.businessObject.$attrs["activiti:candidateGroupsSelect"];
          }
          if (element.businessObject.$attrs["activiti:assigneeType"]) {
            this.form.assigneeType =
              element.businessObject.$attrs["activiti:assigneeType"];
          }
          console.log(this.form);
        }
        modeling.updateProperties(this.element, {
          extensionElements: null,
        });
        let extensionElements = this.element.businessObject.get(
          "extensionElements"
        );
        if (!extensionElements) {
          extensionElements = this.modeler
            .get("moddle")
            .create("bpmn:ExtensionElements");
        }

        const bpmnFactory = this.modeler.get("bpmnFactory");
        //   elementFactory = this.modeler.get("elementFactory");
        //  let executionListener=  bpmnFactory.create('activiti:ExecutionListener', {
        //    event: 'start',
        //    value: 'org.dev.workflow.listener.DevExecutionListener',
        //  });

        let executionListener = this.modeler
          .get("moddle")
          .create(
            "activiti:ExecutionListener",
            null,
            this.element,
            bpmnFactory
          );
        executionListener.$attrs["event"] = "statrt";
        executionListener.$attrs["class"] =
          "org.dev.workflow.listener.DevExecutionListener";
        extensionElements.get("values").push(executionListener);
        executionListener = this.modeler
          .get("moddle")
          .create(
            "activiti:ExecutionListener",
            null,
            this.element,
            bpmnFactory
          );
        executionListener.$attrs["event"] = "end";
        executionListener.$attrs["class"] =
          "org.dev.workflow.listener.DevExecutionListener";
        extensionElements.get("values").push(executionListener);
        if (element.type === "bpmn:UserTask") {
          let taskListener = this.modeler
            .get("moddle")
            .create("activiti:TaskListener", null, this.element, bpmnFactory);
          taskListener.$attrs["event"] = "all";
          taskListener.$attrs["class"] =
            "org.dev.workflow.listener.DevTaskListener";
          extensionElements.get("values").push(taskListener);
        }
        modeling.updateProperties(this.element, {
          extensionElements: extensionElements,
        });
      });

      //  监听节点属性变化
      this.modeler.on("element.changed", (e) => {
        const { element } = e;
        if (!element) return;
        //  新增节点需要更新回属性面板
        if (element.id === this.form.id) {
          this.form.name = element.businessObject.name;
          this.form = { ...this.form };
        }
      });
      // 监听节点点击
      this.modeler.on("element.click", (e) => {
        console.log("点击事件");
        if (!e || e.element.type == "bpmn:Process") {
          this.element = e.element;
          this.form = {
            ...e.element.businessObject,
            ...e.element.businessObject.$attrs,
          };
          if (e.element.businessObject.$attrs["activiti:description"]) {
            this.form.description =
              e.element.businessObject.$attrs["activiti:description"];
          }
        }
      });
    },
    // 属性面板名称，更新回流程节点
    nameChange(name) {
      const modeling = this.modeler.get("modeling");
      if (this.element.type == "bpmn:Process") {
        modeling.updateProperties(this.element, {
          name: name,
        });
      } else {
        modeling.updateLabel(this.element, name);
      }
    },
    // 属性面板名称，更新回流程节点
    descriptionChange(description) {
      const modeling = this.modeler.get("modeling");
      modeling.updateProperties(this.element, {
        "activiti:description": description,
      });
    },
    // 属性面板颜色，更新回流程节点
    colorChange(color) {
      const modeling = this.modeler.get("modeling");
      modeling.setColor(this.element, {
        fill: null,
        stroke: color,
      });
      modeling.updateProperties(this.element, { color: color });
    },
    // 属性面板名称，更新回流程节点
    assigneeChange(assignee) {
      const modeling = this.modeler.get("modeling");
      modeling.updateProperties(this.element, {
        "activiti:assigneeType": this.form.assigneeType,
        "activiti:assignee": assignee,
      });
    },
    // 属性面板名称，更新回流程节点
    expressionChange(condition) {
      const modeling = this.modeler.get("modeling");
      //   modeling.updateProperties(this.element, {
      //     conditionExpression: newCondition,
      //   });
      var newCondition = this.modeler
        .get("moddle")
        .create("bpmn:FormalExpression", {
          body: condition,
        });

      modeling.updateProperties(this.element, {
        conditionExpression: newCondition,
      });
    },
    // 任务节点配置人员
    addUser(properties) {
      this.updateProperties(
        Object.assign(properties, {
          "activiti:assigneeType": this.form.assigneeType,
        })
      );
    },
    // 切换人员类型
    typeChange() {
      const types = ["user", "role", "job", "custom"];
      types.forEach((type) => {
        delete this.element.businessObject.$attrs[type];
        delete this.form[type];
      });
    },
    // 在这里我们封装一个通用的更新节点属性的方法
    updateProperties(properties) {
      console.log(properties);
      const modeling = this.modeler.get("modeling");
      modeling.updateProperties(this.element, properties);
    },
    //加载用户数据
    loadUser() {
      this.$http
        .get("/api/sysUser/list-signed", {})
        .then((res) => {
          if (res.code == 0) {
            this.users = res.data;
          } else {
            this.$message.error(res.msg);
          }
        })
        .catch((err) => {
          console.log(err.message);
        });
    },
    //加载角色数据
    loadRoles() {
      this.$http
        .get("/api/sysRole/list-signed", {})
        .then((res) => {
          if (res.code == 0) {
            this.roles = res.data;
          } else {
            this.$message.error(res.msg);
          }
        })
        .catch((err) => {
          console.log(err.message);
        });
    },
    //加载职位
    loadJobs() {
      this.$http
        .get("/api/sysJobs/all-list", {})
        .then((res) => {
          if (res.code == 0) {
            this.jobs = res.data;
          } else {
            this.$message.error(res.msg);
          }
        })
        .catch((err) => {
          console.log(err.message);
        });
    },
  },
  created() {
    //加载审核人员列表
    this.loadUser();
    //加载审核角色列表
    this.loadRoles();
    //加载岗位信息
    this.loadJobs();
  },
};
</script>

<style lang="less" scoped>
.property-panel {
  position: absolute;
  right: 0px;
  top: 0px;
  border: 1px solid #cccccc;
  background-color: #ffffff;
  width: 280px;
  height: 100%;
  padding-top: 30px;
  padding-right: 20px;
  z-index: 1000;
}
</style>
