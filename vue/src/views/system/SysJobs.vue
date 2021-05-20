<template>
  <div>
    <div>
      <!--按钮列表-->
      <el-button-group class="toolBox">
        <el-button size="small" v-for="(item,index) in buttonGroups" :key="index" @click="dynamicMethod(item.method,item.params)" :icon="item.icon">
          {{item.label}}</el-button>
      </el-button-group>
    </div>
    <!--数据表格-->
    <el-row>
      <el-col :span="24">
        <el-table :data="tableData" border stripe highlight-current-row ref="multipleTable" :height="tableHeight" @row-click="handleRowClick"
          style="width: 100%">
          <el-table-column type="selection" width="55">
          </el-table-column>
          <el-table-column type="index" width="65" label="序号" align="center" fixed :show-overflow-tooltip="true"></el-table-column>
          <template v-for="(el,i) in tableColumns">
            <el-table-column :label="el.label" header-align="center" v-if="el.show && el.prop === 'level'" :width="el.width || ''" :key="el.prop"
              :fixed="el.fixed" :prop="el.prop" :sortable="el.sortable" show-overflow-tooltip>
              <template slot-scope="scope">{{
                scope.row.level | dic('JOBS_LEVEL')
              }}</template>
            </el-table-column>
            <el-table-column :label="el.label" header-align="center" v-else-if="el.show" :width="el.width || ''" :key="el.prop" :fixed="el.fixed"
              :prop="el.prop" :sortable="el.sortable" show-overflow-tooltip>
            </el-table-column>
          </template>
          <el-table-column fixed="right" label="操作" width="300">
            <template slot-scope="scope">
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
    <CustomTableCols :defaultCols="defaultColumns" customName="sysJobs" @changeColumns="changeColumns" />
    <!--查询条件-->
    <Search :show.sync="showSearch" :condition="searchCondition" :form="searchForm" @ok="setCondition" @hidden="showSearch=false" />
    <!--新增编辑页面-->
    <CustomForm :show.sync="showForm" title="职务编辑" :control="formControl" :model="formField" :rules="formRules" @ok="saveForm"
      @hidden="showForm=false" />
  </div>

</template>

<script>
import CustomTableCols from '../../components/CustomTableCols'
import Search from '../../components/Search'
import CustomForm from '../../components/CustomForm'
export default {
  components: {
    CustomTableCols,
    Search,
    CustomForm,
  },
  data() {
    return {
      initData: {},
      tableData: [],
      optionsArray: [],
      tableHeight: '400px',
      current: 1,
      size: 10,
      total: 0,
      pageSizeOptions: [10, 20, 50, 100],
      searchForm: { code: '', name: '' },
      searchCondition: [
        { index: 0, label: '职务编码', field: 'workNo', type: 'input', show: true },
        { index: 1, label: '职务名称', field: 'name', type: 'input', show: true },
      ],
      showSearch: false,
      buttonGroups: [
        { index: 0, label: '查询', method: 'showCondition', icon: 'el-icon-search' },
        { index: 1, label: '新建', method: 'addAndEdit', icon: 'el-icon-plus' },
        // { index: 2, label: '失效', method: 'enablejob', params: false, icon: 'el-icon-delete' },
        { index: 5, label: '删除', method: 'delete', icon: 'el-icon-delete' },
        { index: 6, label: '刷新', method: 'searchData', icon: 'el-icon-refresh' }
      ],
      tableColumns: [],
      defaultColumns: [
        { label: '职务编码', prop: 'code', show: true, fixed: false, sortable: false, width: 200 },
        { label: '职务名称', prop: 'name', show: true, fixed: false, sortable: false, width: 200 },
        { label: '职务级别', prop: 'level', show: true, fixed: false, sortable: false, width: 200 },
        // { label: '是否有效', prop: 'isActive', show: true, fixed: false, sortable: false },
        { label: '创建时间', prop: 'createTime', show: true, fixed: false, sortable: false }
      ],
      showForm: false,
      formField: {
        id: '', code: '', name: '', level: ''
      },
      formControl: [
        { label: 'ID', field: 'id', type: 'hidden', show: false, readonly: true },
        { label: '职务编码', field: 'code', type: 'input', show: true, readonly: true },
        { label: '职务名称', field: 'name', type: 'input', show: true, readonly: false },
        { label: '职务级别', field: 'level', type: 'select', show: true, readonly: false, options: null }
      ],
      formRules: {
        code: [
          { required: true, message: '请输入职务编码', trigger: 'blur' },
          { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
        ],
        name: [
          { required: true, message: '请输入职务名称', trigger: 'blur' },
          { min: 1, max: 50, message: '长度在 3 到 50 个字符', trigger: 'blur' }
        ],
      },
      multipleSelection: [],
      visible: false,
      jobsId: null,
    }
  },

  methods: {
    /**
     * 
     */
    getJobsLevels() {
      this.$http
        .get('/api/sysDicItem/item-list-bydiccode', {
          params: {
            dicCode: 'JOBS_LEVEL'
          }
        })
        .then(res => {
          if (res.code == 0) {
            if (res.data) {
              let that = this;
              res.data.forEach(item => {
                that.optionsArray.push({
                  label: item.dicItemName,
                  value: Number(item.dicItemValue)
                });
              });
            }
          } else {
            this.$message.error(res.msg)
          }
        })
        .catch(err => {
          console.log(err.message)
        })
    },
    /**
     * 数据查询
     */
    searchData() {
      this.$http
        .get('/api/sysJobs/list', {
          params: this._handerParams()
        })
        .then(res => {
          if (res.code == 0) {
            this.tableData = res.data.records
            this.total = res.data.total
            this.current = res.data.current
            this.size = res.data.size
          } else {
            this.$message.error(res.msg)
          }
        })
        .catch(err => {
          console.log(err.message)
        })
    },
    /**
     * 查询条件处理
     */
    _handerParams() {
      const params = {
        current: this.current,
        size: this.size,
        code: this.searchForm.code,
        name: this.searchForm.name,
      }
      return params
    },
    /**
     * 新增修改数据
     */
    addAndEdit() {
      // 设置账号栏位可编辑
      for (const item in this.formField) {
        this.formField[item] = ''
      }
      this.formControl[1].readonly = false
      this.formControl[3].options = this.optionsArray
      this.showForm = true
    },
    /**
     * 是否启用/禁用员工
     */
    enablejob(isEnable) {
      console.log(this.multipleSelection)
      if (this.$refs.multipleTable.selection.length <= 0) {
        this.$message.warning('请选择要操作的职务')
        return
      }
      const idArray = []
      this.$refs.multipleTable.selection.forEach(element => {
        idArray.push(element.id)
      })
      this.$http.post('/api/sysJobs/enable?enable=' + isEnable, idArray).then(res => {
        if (res.code == '0') {
          this.$message.success(res.msg)
          this.searchData()
        } else {
          this.$message.error(res.msg)
        }
      }).catch(err => {
        console.log(err.message)
      })
    },

    /**
     * 选择事件
     */
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    // 点击行触发，选中或不选中复选框
    handleRowClick(row, column, event) {
      this.$refs.multipleTable.toggleRowSelection(row)
    },

    /**
     * 动态调用方法
     */
    dynamicMethod(methodname, params) {
      this[methodname](params)
    },
    /**
     * 展示查询条件
     */
    showCondition() {
      this.showSearch = true
      console.log(this.showSearch)
    },
    /**
     * 设置查询条件
     */
    setCondition(from) {
      const newData = JSON.parse(JSON.stringify(from))
      this.searchForm = newData
      this.searchData()
    },

    /**
     * 保存表单
     */
    saveForm(from) {
      const newData = JSON.parse(JSON.stringify(from))
      this.formField = newData
      this.$http.post('/api/sysJobs/save', this.formField).then(res => {
        if (res.code == '0') {
          this.$message.success(res.msg)
          this.showForm = false
          this.searchData()
        } else {
          this.$message.error(res.msg)
        }
      }).catch(err => {
        console.log(err.message)
      })
    },
    /**
     * 删除员工
     */
    handleDelClick(row) {
      // 设置账号栏位不可编辑
      this.$confirm('此操作将永久删除该职务, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        const idArray = []
        this.$refs.multipleTable.selection.forEach(element => {
          idArray.push(element.id)
        })
        this.$http.post('/api/sysJobs/delete', idArray).then(res => {
          if (res.code == '0') {
            this.$message.success(res.msg)
            this.searchData()
          } else {
            this.$message.error(res.msg)
          }
        }).catch(err => {
          console.log(err.message)
        })
      }).catch(() => {
        this.$message.info('已取消删除')
      })
    },

    /**
     * 修改数据
     */
    handleEditClick(row) {
      // 设置账号栏位不可编辑
      for (const item in this.formField) {
        this.formField[item] = ''
      }
      this.formControl[1].readonly = true
      this.showForm = true
      this.formField.id = row.id
      this.formField.name = row.name
      this.formField.code = row.code
      this.formField.level = row.level;
      this.formControl[3].options = this.optionsArray
    },



    /**
     * 删除员工
     */
    delete() {
      if (this.$refs.multipleTable.selection.length <= 0) {
        this.$message.warning('请选择要操作的职务')
        return
      }
      this.$confirm('此操作将永久删除选择的职务, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        const idArray = []
        this.$refs.multipleTable.selection.forEach(element => {
          idArray.push(element.id)
        })
        this.$http.post('/api/sysJobs/delete', idArray).then(res => {
          if (res.code == '0') {
            this.$message.success(res.msg)
            this.searchData()
          } else {
            this.$message.error(res.msg)
          }
        }).catch(err => {
          console.log(err.message)
        })
      }).catch(() => {
        this.$message.info('已取消删除')
      })
    },
    /**
     * 自定义列修改
     */
    changeColumns(val) {
      console.log('changeColumns--' + val)
      this.tableColumns = []
      this.$nextTick(() => {
        this.tableColumns = val
      })
    },
    /**
     * table每页数字变化
     */
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`)
      this.size = val
      this.searchData()
    },
    /**
     * table页数变化
     */
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`)
      this.current = val
      this.searchData()
    }
  },
  created() {
    this.tableHeight = document.documentElement.clientHeight - 280
    //
    this.tableColumns = this.defaultColumns
    this.searchData();
    this.getJobsLevels();
  }
}
</script>
