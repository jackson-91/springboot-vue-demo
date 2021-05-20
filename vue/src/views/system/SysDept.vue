<template>
  <div>
    <div>
      <!--按钮列表-->
      <el-button-group class="toolBox">
        <el-button size="small" v-for="(item, index) in buttonGroups" :key="index" @click="dynamicMethod(item.method, item.params)" :icon="item.icon">
          {{ item.label }}</el-button>
      </el-button-group>
    </div>
    <!--数据表格-->
    <el-row>
      <el-col :span="24">
        <el-table :data="tableData" border row-key="id" style="width: 100%; margin-bottom: 20px" default-expand-all highlight-current-row
          ref="multipleTable" :height="tableHeight" @row-click="handleRowClick" :tree-props="{ children: 'children', hasChildren: 'hasChildren' }">
          <template v-for="(el, i) in tableColumns">
            <el-table-column :label="el.label" header-align="center" v-if="el.show" :width="el.width || ''" :key="el.prop" :fixed="el.fixed"
              :prop="el.prop" :sortable="el.sortable" show-overflow-tooltip>
            </el-table-column>
          </template>
          <el-table-column fixed="right" label="操作" width="300">
            <template slot-scope="scope">
              <!-- <el-button @click="handleAuthVClick(scope.row)"
                         type="text"
                         size="small">权限查看</el-button> -->
              <el-button type="text" @click="handleDelClick(scope.row)" size="small">删除</el-button>
              <el-button type="text" @click="handleEditClick(scope.row)" size="small">编辑</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-col>
    </el-row>
    <!--分页插件-->
    <el-row>
      <el-col :span="24">
        <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="current" :page-sizes="pageSizeOptions"
          :page-size="size" layout="total, sizes, prev, pager, next, jumper" :total="total">
        </el-pagination>
      </el-col>
    </el-row>
    <!--列自定义-->
    <CustomTableCols :defaultCols="defaultColumns" customName="employe" @changeColumns="changeColumns" />
    <!--查询条件-->
    <Search :show.sync="showSearch" :condition="searchCondition" :form="searchForm" @ok="setCondition" @hidden="showSearch = false" />
    <!--新增编辑页面-->
    <CustomForm :show.sync="showForm" title="部门编辑" :control="formControl" :model="formField" :rules="formRules" @ok="saveForm"
      @hidden="showForm = false" />
  </div>
</template>

<script>
import CustomTableCols from "../../components/CustomTableCols";
import Search from "../../components/Search";
import CustomForm from "../../components/CustomForm";
export default {
  components: {
    CustomTableCols,
    Search,
    CustomForm,
  },
  data() {
    return {
      deptArray: [],
      defaultProps: {
        children: "children",
        label: "label",
      },
      initData: {},
      tableData: [],
      tableHeight: "400px",
      current: 1,
      size: 10,
      total: 0,
      pageSizeOptions: [10, 20, 50, 100],
      searchForm: { deptCode: "", deptName: "" },
      searchCondition: [
        { index: 0, label: "部门代码", field: "deptCode", type: "input", show: true, },
        { index: 1, label: "部门名称", field: "deptName", type: "input", show: true, },
      ],
      showSearch: false,
      buttonGroups: [
        { index: 0, label: "查询", method: "showCondition", icon: "el-icon-search", },
        { index: 1, label: "新建", method: "addAndEdit", icon: "el-icon-plus" },
        { index: 5, label: "删除", method: "delete", icon: "el-icon-delete" },
        { index: 6, label: "刷新", method: "searchData", icon: "el-icon-refresh", },
      ],
      tableColumns: [],
      defaultColumns: [
        { label: "部门代码", prop: "deptCode", show: true, fixed: false, sortable: false, width: 200, },
        { label: "部门名称", prop: "deptName", show: true, fixed: false, sortable: false, width: 200, },
        { label: "负责人", prop: "deptHeaderName", show: true, fixed: false, sortable: false, width: 200, },
        { label: "创建时间", prop: "createTime", show: true, fixed: false, sortable: false, },
      ],
      showForm: false,
      formField: { id: "", deptCode: "", deptName: "", parentId: "", deptHeader: "", },
      formControl: [
        { label: "ID", field: "id", type: "hidden", show: false, readonly: true, },
        { label: "部门代码", field: "deptCode", type: "input", show: true, readonly: true, },
        { label: "部门名称", field: "deptName", type: "input", show: true, readonly: false, },
        {
          label: "上级部门", field: "parentId", type: "tree-select", show: true, options: null, isClearable: true, // 可清空（可选）
          isAccordion: true, // 可收起（可选
          props: {            // 配置项（必选）
            value: "id", label: "deptName", children: "children",
          },
        },
        { label: "负责人", field: "deptHeaderJobs", type: "select", show: true, readonly: false, options: null, },
      ],
      formRules: {
        deptCode: [
          { required: true, message: "请输入部门代码", trigger: "blur" },
          { min: 3, max: 20, message: "长度在 3 到 20 个字符", trigger: "blur", },
        ],
        deptName: [
          { required: true, message: "请输入部门名称", trigger: "blur" },
          { min: 1, max: 50, message: "长度在 3 到 50 个字符", trigger: "blur", },
        ],
        parentId: [
          { required: true, message: "请选择上级部门", trigger: "blur" },
        ],
        deptHeader: [
          { required: true, message: "请选择负责人", trigger: "blur" },
        ],
      },
      multipleSelection: [],
      visible: false,
      deptId: null,
      jobsArray: [],
    };
  },

  methods: {
    /**
     *
     */
    getDept() {
      this.$http
        .get("/api/sysDept/tree-all-list", {
          params: {
            dicCode: "EDUCATION",
          },
        })
        .then((res) => {
          if (res.code == 0) {
            if (res.data) {
              let that = this;
              that.deptArray = res.data;
            }
          } else {
            this.$message.error(res.msg);
          }
        })
        .catch((err) => {
          console.log(err.message);
        });
    },
    searchData() {
      this.$http
        .get("/api/sysDept/tree-list", {
          params: this._handerParams(),
        })
        .then((res) => {
          if (res.code == 0) {
            this.tableData = this.handleTree(res.data.records, "deptId");
            console.log(this.tableData);
            this.total = res.data.total;
            this.current = res.data.current;
            this.size = res.data.size;
          } else {
            this.$message.error(res.msg);
          }
        })
        .catch((err) => {
          console.log(err.message);
        });
    },

    handleTree(data, id, parentId, children, rootId) {
      id = id || "id";
      parentId = parentId || "parentId";
      children = children || "children";
      rootId =
        rootId ||
        Math.min.apply(
          Math,
          data.map((item) => {
            return item[parentId];
          })
        ) ||
        0;
      //对源数据深度克隆
      const cloneData = JSON.parse(JSON.stringify(data));
      //循环所有项
      const treeData = cloneData.filter((father) => {
        let branchArr = cloneData.filter((child) => {
          //返回每一项的子级数组
          return father[id] === child[parentId];
        });
        branchArr.length > 0 ? (father.children = branchArr) : "";
        //返回第一层
        return father[parentId] === rootId;
      });
      return treeData != "" ? treeData : data;
    },

    /**
     * 查询条件处理
     */
    _handerParams() {
      const params = {
        current: this.current,
        size: this.size,
        deptCode: this.searchForm.deptCode,
        deptName: this.searchForm.deptName,
      };
      return params;
    },
    /**
     * 新增修改数据
     */
    addAndEdit() {
      // 设置账号栏位可编辑
      for (const item in this.formField) {
        this.formField[item] = "";
      }
      this.formControl[1].readonly = false;
      this.formControl[3].options = this.deptArray;
      this.formControl[4].options = this.jobsArray;
      this.showForm = true;
    },

    /**
     * 选择事件
     */
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    // 点击行触发，选中或不选中复选框
    handleRowClick(row, column, event) {
      this.$refs.multipleTable.toggleRowSelection(row);
    },

    /**
     * 动态调用方法
     */
    dynamicMethod(methodname, params) {
      this[methodname](params);
    },
    /**
     * 展示查询条件
     */
    showCondition() {
      this.showSearch = true;
      console.log(this.showSearch);
    },
    /**
     * 设置查询条件
     */
    setCondition(from) {
      const newData = JSON.parse(JSON.stringify(from));
      this.searchForm = newData;
      this.searchData();
    },
    /**
     * 加载职位列表
     * */
    getJobs() {
      this.$http
        .get("/api/sysJobs/all-list", {})
        .then((res) => {
          if (res.code == 0) {
            if (res.data) {
              let that = this;
              res.data.forEach((item) => {
                that.jobsArray.push({
                  label: item.name,
                  value: item.id,
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
    /**
     * 保存表单
     */
    saveForm(from) {
      const newData = JSON.parse(JSON.stringify(from));
      this.formField = newData;
      this.$http
        .post("/api/sysDept/save", this.formField)
        .then((res) => {
          if (res.code == "0") {
            this.$message.success(res.msg);
            this.showForm = false;
            this.searchData();
            this.getDept();
          } else {
            this.$message.error(res.msg);
          }
        })
        .catch((err) => {
          console.log(err.message);
        });
    },
    /**
     * 删除部门
     */
    handleDelClick(row) {
      // 设置账号栏位不可编辑
      this.$confirm("此操作将永久删除该部门, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          const idArray = [];
          this.$refs.multipleTable.selection.forEach((element) => {
            idArray.push(element.id);
          });
          this.$http
            .post("/api/sysDept/delete", idArray)
            .then((res) => {
              if (res.code == "0") {
                this.$message.success(res.msg);
                this.searchData();
                this.getDept();
              } else {
                this.$message.error(res.msg);
              }
            })
            .catch((err) => {
              console.log(err.message);
            });
        })
        .catch(() => {
          this.$message.info("已取消删除");
        });
    },
    /**
     * 修改数据
     */
    handleEditClick(row) {
      // 设置账号栏位不可编辑
      for (const item in this.formField) {
        this.formField[item] = "";
      }
      this.formControl[1].readonly = true;
      this.formControl[3].options = this.deptArray;
      this.formControl[4].options = this.jobsArray;
      this.showForm = true;
      this.formField.deptCode = row.deptCode;
      this.formField.deptName = row.deptName;
      this.formField.parentId = row.parentId;
      this.formField.deptHeaderJobs = row.deptHeaderJobs;
      this.formField.id = row.id;
    },
    /**
     * 授权
     */
    handleAuthClick() { },
    /**
     *权限查看
     */
    handleAuthVClick(row) {
      this.deptId = row.id;
      this.showTree = true;
    },

    /**
     * 删除部门
     */
    delete() {
      if (this.$refs.multipleTable.selection.length <= 0) {
        this.$message.warning("请选择要操作的部门");
        return;
      }
      this.$confirm("此操作将永久删除选择的部门, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          const idArray = [];
          this.$refs.multipleTable.selection.forEach((element) => {
            idArray.push(element.id);
          });
          this.$http
            .post("/api/sysDept/delete", idArray)
            .then((res) => {
              if (res.code == "0") {
                this.$message.success(res.msg);
                this.searchData();
                this.getDept();
              } else {
                this.$message.error(res.msg);
              }
            })
            .catch((err) => {
              console.log(err.message);
            });
        })
        .catch(() => {
          this.$message.info("已取消删除");
        });
    },
    /**
     * 自定义列修改
     */
    changeColumns(val) {
      console.log("changeColumns--" + val);
      this.tableColumns = [];
      this.$nextTick(() => {
        this.tableColumns = val;
      });
    },
    /**
     * table每页数字变化
     */
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      this.size = val;
      this.searchData();
    },
    /**
     * table页数变化
     */
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      this.current = val;
      this.searchData();
    },
  },
  created() {
    this.tableHeight = document.documentElement.clientHeight - 280;
    //
    this.tableColumns = this.defaultColumns;
    this.getDept();
    this.searchData();
    this.getJobs();
  },
  activated() { },
};
</script>
