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
    <CustomTableCols :defaultCols="defaultColumns" customName="sysEmail" @changeColumns="changeColumns" />
    <!--查询条件-->
    <Search :show.sync="showSearch" :condition="searchCondition" :form="searchForm" @ok="setCondition" @hidden="hidCondition" />
    <!--新增编辑页面-->
    <CustomForm :show.sync="showForm" title="服务器编辑" :control="formControl" :model="formField" :rules="formRules" @ok="saveForm" @hidden="hidForm" />

    <el-dialog title="收件邮箱" :visible.sync="visible2" :close-on-click-modal="false" append-to-body @close="cancel2">
      <el-input v-model="toEmail"></el-input>
      <div slot="footer" class="dialog-footer">
        <el-button @click="cancel2()">取消</el-button>
        <el-button @click="reset2()">清空</el-button>
        <el-button @click="ok2()" type="primary">确定</el-button>
      </div>
    </el-dialog>
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
      searchForm: { smtpServer: '', },
      searchCondition: [
        { index: 0, label: '服务器', field: 'smtpServer', type: 'input', show: true },
      ],
      showSearch: false,
      buttonGroups: [
        { index: 0, label: '查询', method: 'showCondition', icon: 'el-icon-search' },
        { index: 1, label: '新建', method: 'addAndEdit', icon: 'el-icon-plus' },
        { index: 5, label: '删除', method: 'delete', icon: 'el-icon-delete' },
        { index: 5, label: '测试发送邮件', method: 'test', icon: 'el-icon-plus' },
        { index: 6, label: '刷新', method: 'searchData', icon: 'el-icon-refresh' }
      ],
      tableColumns: [],
      defaultColumns: [
        { label: '服务器', prop: 'smtpServer', show: true, fixed: false, sortable: false, width: 200 },
        { label: '端口', prop: 'smtpPort', show: true, fixed: false, sortable: false, width: 200 },
        { label: '用户名', prop: 'smtpUsername', show: true, fixed: false, sortable: false },
        { label: '密码', prop: 'smtpPassword', show: true, fixed: false, sortable: false },
        { label: '发件邮箱', prop: 'smtpEmail', show: true, fixed: false, sortable: false },
      ],
      showForm: false,
      formField: { id: '', smtpServer: '', smtpPort: '', smtpUsername: '', smtpPassword: '' },
      formControl: [
        { label: 'ID', field: 'id', type: 'hidden', show: false, readonly: true },
        { label: '服务器', field: 'smtpServer', type: 'input', show: true, readonly: false },
        { label: '端口', field: 'smtpPort', type: 'number', show: true, readonly: false },
        { label: '用户名', field: 'smtpUsername', type: 'input', show: true, readonly: false },
        { label: '密码', field: 'smtpPassword', type: 'password', show: true, readonly: false },
        { label: '发件邮箱', field: 'smtpEmail', type: 'input', show: true, readonly: false },
      ],
      formRules: {
        smtpServer: [
          { required: true, message: '请输入服务器', trigger: 'blur' },
        ],
        smtpPort: [
          { required: true, message: '请输入端口', trigger: 'blur' },
        ],
        smtpUsername: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 3, max: 50, message: '长度在 3 到 50 个字符', trigger: 'blur' }
        ],
        smtpPassword: [
          { required: true, message: '请输入密码', trigger: 'blur' }
        ],
        smtpEmail: [
          { required: true, message: '请输入发件邮箱', trigger: 'blur' }
        ]
      },
      multipleSelection: [],
      visible: false,
      visible2: false,
      toEmail: '',
    }
  },

  methods: {
    searchData() {
      this.$http
        .get('/api/sysEmail/list', {
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
        smtpServer: this.searchForm.smtpServer,
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
      this.current = 1;
      const newData = JSON.parse(JSON.stringify(from))
      this.searchForm = newData
      this.searchData()
    },
    test() {
      this.visible2 = true;
    },
    cancel2() { this.visible2 = false; },
    reset2() { this.toEmail = ''; },
    ok2() {
      if (!this.toEmail) {
        this.$message.error("请输入收件邮箱");
        return;
      }
      let ids = this.toEmail.split(',');
      this.$http.post('/api/sysEmail/test', ids).then(res => {
        if (res.code == '0') {
          this.$message.success(res.msg)
        } else {
          this.$message.error(res.msg)
        }
      }).catch(err => {
        console.log(err.message)
      })
    },
    /**,
     * 保存表单
     */
    saveForm(from) {
      const newData = JSON.parse(JSON.stringify(from))
      this.formField = newData
      this.$http.post('/api/sysEmail/save', this.formField).then(res => {
        if (res.code == '0') {
          this.$message.success(res.msg)
          this.searchData()
          this.showForm = false;
        } else {
          this.$message.error(res.msg)
        }
      }).catch(err => {
        console.log(err.message)
      })
    },
    /**
     * 删除服务器
     */
    handleDelClick(row) {
      // 设置账号栏位不可编辑
      this.$confirm('此操作将永久删除该服务器, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        const idArray = []
        this.$refs.multipleTable.selection.forEach(element => {
          idArray.push(element.id)
        })
        this.$http.post('/api/sysEmail/delete', idArray).then(res => {
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
      // this.formControl[1].readonly = true
      this.showForm = true
      this.formField.id = row.id
      this.formField.smtpServer = row.smtpServer
      this.formField.smtpPort = row.smtpPort
      this.formField.smtpUsername = row.smtpUsername
      this.formField.smtpPassword = row.smtpPassword
      this.formField.smtpEmail = row.smtpEmail
    },
    /**
     * 隐藏编辑表单
     */
    hidForm(val) {
      console.log('hiddiv' + val)
      this.showForm = val
    },
    /**
     * 删除服务器
     */
    delete() {
      if (this.$refs.multipleTable.selection.length <= 0) {
        this.$message.warning('请选择要操作的服务器')
        return
      }
      this.$confirm('此操作将永久删除选择的服务器, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        const idArray = []
        this.$refs.multipleTable.selection.forEach(element => {
          idArray.push(element.id)
        })
        this.$http.post('/api/sysEmail/delete', idArray).then(res => {
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
