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
            <el-table-column :label="el.label" header-align="center" v-if="el.show " :width="el.width || ''" :key="el.prop" :fixed="el.fixed"
              :prop="el.prop" :sortable="el.sortable" show-overflow-tooltip>
            </el-table-column>
          </template>
          <el-table-column fixed="right" label="操作" width="300">
            <template slot-scope="scope">
              <el-button type="text" @click="handleEditClick(scope.row)" size="small">编辑</el-button>
              <el-button type="text" @click="handleDelClick(scope.row)" size="small">删除</el-button>
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
    <CustomTableCols :defaultCols="defaultColumns" customName="user" @changeColumns="changeColumns" />
    <!--查询条件-->
    <Search :show.sync="showSearch" :condition="searchCondition" :form="searchForm" @ok="setCondition" @hidden="hidCondition" />
    <!--新增编辑页面-->
    <CustomForm :show.sync="showForm" title="用户编辑" :control="formControl" :model="formField" :rules="formRules" @ok="saveForm" @hidden="hidForm" />
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
    CustomForm
  },
  data() {
    return {
      initData: {},
      tableData: [],
      tableHeight: '400px',
      current: 1,
      size: 10,
      total: 0,
      pageSizeOptions: [10, 20, 50, 100],
      searchForm: { pCode: '', pName: '', pDesc: '', pValue: '' },
      searchCondition: [
        { index: 0, label: '参数代码', field: 'pCode', type: 'input', show: true },
        { index: 1, label: '参数名称', field: 'pName', type: 'input', show: true },
        { index: 2, label: '参数描述', field: 'pDesc', type: 'input', show: true },
        { index: 3, label: '参数值', field: 'pValue', type: 'input', show: true },
      ],
      showSearch: false,
      buttonGroups: [
        { index: 0, label: '查询', method: 'showCondition', icon: 'el-icon-search' },
        { index: 1, label: '新建', method: 'addAndEdit', icon: 'el-icon-plus' },
        { index: 5, label: '删除', method: 'delete', icon: 'el-icon-delete' },
        { index: 6, label: '刷新', method: 'searchData', icon: 'el-icon-refresh' }
      ],
      tableColumns: [],
      defaultColumns: [
        { label: '参数代码', prop: 'pCode', show: true, fixed: false, sortable: false, width: 200 },
        { label: '参数名称', prop: 'pName', show: true, fixed: false, sortable: false, width: 200 },
        { label: '参数描述', prop: 'pDesc', show: true, fixed: false, sortable: false },
        { label: '参数值', prop: 'pValue', show: true, fixed: false, sortable: false },
        { label: '参数值1', prop: 'pValue1', show: true, fixed: false, sortable: false },
        { label: '参数值2', prop: 'pValue2', show: true, fixed: false, sortable: false },
      ],
      showForm: false,
      formField: { id: '', pCode: '', pName: '', pDesc: '', pValue: '', pValue1: '', pValue2: '' },
      formControl: [
        { label: 'ID', field: 'id', type: 'hidden', show: false, readonly: true },
        { label: '参数代码', field: 'pCode', type: 'input', show: true, readonly: true },
        { label: '参数名称', field: 'pName', type: 'input', show: true, readonly: false },
        { label: '参数描述', field: 'pDesc', type: 'input', show: true, readonly: false },
        { label: '参数值', field: 'pValue', type: 'input', show: true, readonly: false },
        { label: '参数值1', field: 'pValue1', type: 'input', show: true, readonly: false },
        { label: '参数值2', field: 'pValue2', type: 'input', show: true },
      ],
      formRules: {
        pCode: [
          { required: true, message: '请输入参数代码', trigger: 'blur' },
          { min: 1, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
        ],
        pName: [
          { required: true, message: '参数名称', trigger: 'blur' },
          { min: 1, max: 50, message: '长度在 1 到 50 个字符', trigger: 'blur' }
        ],
        pValue: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          { min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur' }
        ],
      },
      multipleSelection: [],
      visible: false,
      checkedKeys: [],
      formId: null,
      showTree: false
    }
  },

  methods: {
    searchData() {
      this.$http
        .get('/api/sysParameter/list', {
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
        pCode: this.searchForm.pCode,
        pName: this.searchForm.pName,
        pDesc: this.searchForm.pDesc,
        pValue: this.searchForm.pValue,
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
      this.showForm = true
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
     * 隐藏查询条件
     */
    hidCondition(val) {
      console.log('hiddiv' + val)
      this.showSearch = val
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
      this.$http.post('/api/sysParameter/save', this.formField).then(res => {
        if (res.code == '0') {
          this.$message.success('保存成功')
          this.showForm = false;
          this.searchData()
        } else {
          this.$message.error(res.message)
        }
      }).catch(err => {
        this.$message.error('保存失败')
        console.log(err.message)
      })
    },
    /**
     * 删除用户
     */
    handleDelClick(row) {
      // 设置账号栏位不可编辑
      this.$confirm('此操作将永久删除该参数, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => { 
        this.$http.post('/api/sysParameter/delete', [row.id]).then(res => {
          if (res.code == '0') {
            this.$message.success('操作成功')
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
      this.formField.pCode = row.pCode
      this.formField.pName = row.pName
      this.formField.pDesc = row.pDesc
      this.formField.pValue = row.pValue
      this.formField.pValue1 = row.pValue1
      this.formField.pValue2 = row.pValue2
      this.formField.id = row.id
    },
    /**
     * 隐藏编辑表单
     */
    hidForm(val) {
      console.log('hiddiv' + val)
      this.showForm = val
    },
    /**
     * 删除用户
     */
    delete() {
      if (this.$refs.multipleTable.selection.length <= 0) {
        this.$message.warning('请选择要操作的数据')
        return
      }
      this.$confirm('此操作将永久删除选择的参数, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        const idArray = []
        this.$refs.multipleTable.selection.forEach(element => {
          idArray.push(element.id)
        })
        this.$http.post('/api/sysParameter/delete', idArray).then(res => {
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
    this.searchData()
  }
}
</script>
