<template>
  <div>
    <div>
      <!--按钮列表-->
      <el-button-group class="toolBox">
        <el-button size="small"
                   v-for="(item,index) in buttonGroups"
                   :key="index"
                   @click="dynamicMethod(item.method,item.params)"
                   :icon="item.icon">{{item.label}}</el-button>
      </el-button-group>
    </div>
    <!--数据表格-->
    <el-row>
      <el-col :span="24">
        <el-table :data="tableData"
                  border
                  stripe
                  highlight-current-row
                  ref="multipleTable"
                  :height="tableHeight"
                  @row-click="handleRowClick"
                  style="width: 100%">
          <el-table-column type="selection"
                           width="55">
          </el-table-column>
          <el-table-column type="index"
                           width="65"
                           label="序号"
                           align="center"
                           fixed
                           :show-overflow-tooltip="true"></el-table-column>
          <template v-for="(el,i) in tableColumns">
            <el-table-column :label="el.label"
                             header-align="center"
                             v-if="el.show "
                             :width="el.width || ''"
                             :key="el.prop"
                             :fixed="el.fixed"
                             :prop="el.prop"
                             :sortable="el.sortable"
                             show-overflow-tooltip>
            </el-table-column>
          </template>
          <el-table-column fixed="right"
                           label="操作"
                           width="300">
            <template slot-scope="scope">
              <!-- <el-button @click="handleAuthVClick(scope.row)"
                         type="text"
                         size="small">权限查看</el-button> -->
              <el-button type="text"
                         @click="handleDelClick(scope.row)"
                         size="small">删除</el-button>
              <el-button type="text"
                         @click="handleEditClick(scope.row)"
                         size="small">编辑</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-col>
    </el-row>
    <!--分页插件-->
    <el-row>
      <el-col :span="24">
        <el-pagination @size-change="handleSizeChange"
                       @current-change="handleCurrentChange"
                       :current-page="current"
                       :page-sizes="pageSizeOptions"
                       :page-size="size"
                       layout="total, sizes, prev, pager, next, jumper"
                       :total="total">
        </el-pagination>
      </el-col>
    </el-row>
    <!--列自定义-->
    <CustomTableCols :defaultCols="defaultColumns"
                     customName="employe"
                     @changeColumns="changeColumns" />
    <!--查询条件-->
    <Search :show.sync="showSearch"
            :condition="searchCondition"
            :form="searchForm"
            @ok="setCondition"
            @hidden="showSearch=false" />
    <!--新增编辑页面-->
    <CustomForm :show.sync="showForm"
                title="员工编辑"
                :control="employeControl"
                :model="employeForm"
                :rules="employeRules"
                @ok="saveForm"
                @hidden="showForm=false" />
    <!--分配角色-->
    <el-dialog title="角色分配"
               :visible.sync="visible"
               width="400px"
               @close="visible=false">
      <el-tree node-key="id"
               style="height:400px!important;overflow-y: auto;"
               :data="treeData"
               :props="treeProps"
               ref="tree"
               show-checkbox
               :highlight-current="true"
               :default-checked-keys="checkedKeys"
               :default-expand-all="true"></el-tree>
      <div slot="footer"
           class="dialog-footer">
        <el-button @click="visible=false">取消</el-button>
        <el-button @click="selectAll()"
                   type="primary">全选</el-button>
        <el-button @click="submitRole()"
                   type="primary">确定</el-button>
      </div>
    </el-dialog>
    <!--赋权页面-->
    <treelist :show.sync="showTree"
              title="权限查看"
              ptype="employe"
              :pid="employeId"
              @ok="showTree=false"
              @hidden="showTree=false" />
  </div>

</template>

<script>
import CustomTableCols from '../../components/CustomTableCols'
import Search from '../../components/Search'
import CustomForm from '../../components/CustomForm'
import treelist from '../../components/TreeList'
export default {
  components: {
    CustomTableCols,
    Search,
    CustomForm,
    treelist
  },
  data () {
    var validateComfirmPwd = (rule, value, callback) => {
      if (this.employeForm.cmfPassWord !== value) {
        callback(new Error('确认密码与新密码不一致！'))
      } else {
        callback()
      }
    }
    return {
      initData: {},
      tableData: [],
      educationArray: [],
      deptArray: [],
      jobsArray: [],
      tableHeight: '400px',
      current: 1,
      size: 10,
      total: 0,
      pageSizeOptions: [10, 20, 50, 100],
      searchForm: { workNo: '', name: '', foreignName: '', mobilePhone: '', email: '', status: '' },
      searchCondition: [
        { index: 0, label: '工号', field: 'workNo', type: 'input', show: true },
        { index: 1, label: '姓名', field: 'name', type: 'input', show: true },
        { index: 2, label: '英文名', field: 'foreignName', type: 'input', show: true },
        { index: 3, label: '手机号', field: 'mobilePhone', type: 'input', show: true },
        { index: 4, label: '邮箱', field: 'email', type: 'input', show: true },
        { index: 6, label: '状态', field: 'status', type: 'input', show: true }
      ],
      showSearch: false,
      buttonGroups: [
        { index: 0, label: '查询', method: 'showCondition', icon: 'el-icon-search' },
        { index: 1, label: '新建', method: 'addAndEdit', icon: 'el-icon-plus' },
        { index: 2, label: '离职', method: 'enableemploye', params: false, icon: 'el-icon-delete' },
        { index: 5, label: '删除', method: 'delete', icon: 'el-icon-delete' },
        { index: 6, label: '刷新', method: 'searchData', icon: 'el-icon-refresh' }
      ],
      tableColumns: [],
      defaultColumns: [
        { label: '工号', prop: 'workNo', show: true, fixed: false, sortable: false, width: 100 },
        { label: '姓名', prop: 'name', show: true, fixed: false, sortable: false, width: 100 },
        { label: '英文名', prop: 'foreignName', show: true, fixed: false, sortable: false, width: 100 },
        { label: '手机', prop: 'mobilePhone', show: true, fixed: false, sortable: false, width: 100 },
        { label: '座机号', prop: 'telePhone', show: true, fixed: false, sortable: false, width: 100 },
        { label: '邮箱', prop: 'email', show: true, fixed: false, sortable: false, width: 150 },
        { label: '生日', prop: 'birthday', show: true, fixed: false, sortable: false, width: 120 },
        { label: '学历', prop: 'education', show: true, fixed: false, sortable: false, width: 100 },
        { label: '部门', prop: 'department', show: true, fixed: false, sortable: false, width: 100 },
        { label: '职位', prop: 'position', show: true, fixed: false, sortable: false, width: 100 },
        { label: '状态', prop: 'status', show: true, fixed: false, sortable: false, width: 80 },
        { label: '入职日期', prop: 'entryDate', show: true, fixed: false, sortable: false, width: 120 },
        { label: '离职日期', prop: 'departureDate', show: true, fixed: false, sortable: false, width: 120 }
      ],
      showForm: false,
      employeForm: {
        id: '', workNo: '', name: '', foreignName: '', mobilePhone: '', telePhone: '', email: '', birthday: '', education: '', department: '', position: ''
        , status: '', entryDate: '', departureDate: ''
      },
      employeControl: [
        { label: 'ID', field: 'id', type: 'hidden', show: false, readonly: true },
        { label: '工号', field: 'workNo', type: 'input', show: true, readonly: true },
        { label: '姓名', field: 'name', type: 'input', show: true, readonly: false },
        { label: '英文名', field: 'foreignName', type: 'input', show: true, readonly: false },
        { label: '手机', field: 'mobilePhone', type: 'input', show: true, readonly: false },
        { label: '座机号', field: 'telePhone', type: 'input', show: true, readonly: false },
        { label: '邮箱', field: 'email', type: 'input', show: true },
        { label: '生日', field: 'birthday', type: 'date', show: true },
        { label: '学历', field: 'education', type: 'select', show: true, options: null },
        {
          label: '部门', field: 'department', type: 'tree-select', show: true, options: null, isClearable: true,      // 可清空（可选）
          isAccordion: true,      // 可收起（可选
          props: {                // 配置项（必选）
            value: 'deptCode',
            label: 'deptName',
            children: 'children',
          },
        },
        { label: '职位', field: 'position', type: 'select', show: true, options: null },
        { label: '入职日期', field: 'entryDate', type: 'date', show: true },
        { label: '离职日期', field: 'departureDate', type: 'date', show: true }
      ],
      employeRules: {
        workNo: [
          { required: true, message: '请输入工号', trigger: 'blur' },
          { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
        ],
        name: [
          { required: true, message: '请输入姓名', trigger: 'blur' },
          { min: 1, max: 50, message: '长度在 3 到 50 个字符', trigger: 'blur' }
        ],
        mobilePhone: [
          { required: true, message: '请输入手机', trigger: 'blur' },
          { min: 11, max: 11, message: '长度11 个字符', trigger: 'blur' }
        ],
        email: [
          { required: true, message: '请输入邮箱', trigger: 'blur' },
        ],
        birthday: [
          { required: true, message: '请输入生日', trigger: 'blur' },
        ],
        education: [
          { required: true, message: '请输入学历', trigger: 'blur' },
        ],
        department: [
          { required: true, message: '请输入部门', trigger: 'blur' },
        ],
        position: [
          { required: true, message: '请输入职位', trigger: 'blur' },
        ],
      },
      multipleSelection: [],
      visible: false,
      treeData: [],
      treeProps: {
        label: 'roleName'
      },
      checkedKeys: [],
      employeId: null,
      showTree: false
    }
  },

  methods: {
    /**
     * 
     */
    getDicItem () {
      this.$http
        .get('/api/sysDicItem/item-list-bydiccode', {
          params: {
            dicCode: 'EDUCATION'
          }
        })
        .then(res => {
          if (res.code == 0) {
            if (res.data) {
              let that = this;
              res.data.forEach(item => {
                that.educationArray.push({
                  label: item.dicItemName,
                  value: item.dicItemValue
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
     * 加载职位列表 
     * */
    getJobs () {
      this.$http
        .get('/api/sysJobs/all-list', {
          params: {
            dicCode: 'EDUCATION'
          }
        })
        .then(res => {
          if (res.code == 0) {
            if (res.data) {
              let that = this;
              res.data.forEach(item => {
                that.jobsArray.push({
                  label: item.name,
                  value: item.code
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
     * 
     */
    getDept () {
      this.$http
        .get('/api/sysDept/tree-all-list', {
          params: {
            dicCode: 'EDUCATION'
          }
        })
        .then(res => {
          if (res.code == 0) {
            if (res.data) {
              let that = this;
              that.deptArray = res.data;
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
     *
     */
    searchData () {
      this.$http
        .get('/api/sysEmploye/list', {
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
    _handerParams () {
      const params = {
        current: this.current,
        size: this.size,
        workNo: this.searchForm.workNo,
        name: this.searchForm.name,
        foreignName: this.searchForm.foreignName,
        mobilePhone: this.searchForm.mobilePhone,
      }
      return params
    },
    /**
     * 新增修改数据
     */
    addAndEdit () {
      // 设置账号栏位可编辑
      for (const item in this.employeForm) {
        this.employeForm[item] = ''
      }
      this.employeControl[1].readonly = false
      this.employeControl[8].options = this.educationArray
      this.employeControl[9].options = this.deptArray
      this.employeControl[10].options = this.jobsArray
      this.showForm = true
    },
    /**
     * 是否启用/禁用员工
     */
    enableemploye (isEnable) {
      console.log(this.multipleSelection)
      if (this.$refs.multipleTable.selection.length <= 0) {
        this.$message.warning('请选择要操作的员工')
        return
      }
      const idArray = []
      this.$refs.multipleTable.selection.forEach(element => {
        idArray.push(element.id)
      })
      this.$http.post('/api/sysEmploye/enable?enable=' + isEnable, idArray).then(res => {
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
    handleSelectionChange (val) {
      this.multipleSelection = val
    },
    // 点击行触发，选中或不选中复选框
    handleRowClick (row, column, event) {
      this.$refs.multipleTable.toggleRowSelection(row)
    },

    /**
     * 动态调用方法
     */
    dynamicMethod (methodname, params) {
      this[methodname](params)
    },
    /**
     * 展示查询条件
     */
    showCondition () {
      this.showSearch = true
      console.log(this.showSearch)
    },
    /**
     * 设置查询条件
     */
    setCondition (from) {
      const newData = JSON.parse(JSON.stringify(from))
      this.searchForm = newData
      this.searchData()
    },

    /**
     * 保存表单
     */
    saveForm (from) {
      const newData = JSON.parse(JSON.stringify(from))
      this.employeForm = newData
      this.$http.post('/api/sysEmploye/save', this.employeForm).then(res => {
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
    handleDelClick (row) {
      // 设置账号栏位不可编辑
      this.$confirm('此操作将永久删除该员工, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        const idArray = []
        this.$refs.multipleTable.selection.forEach(element => {
          idArray.push(element.id)
        })
        this.$http.post('/api/sysEmploye/delete', idArray).then(res => {
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
     * 密码重置
     */
    handleResetClick (row) {
      this.$http.post('/api/sysEmploye/rest-password', [row.id]).then(res => {
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
   * 角色分配
   */
    handleRoleClick (row) {
      this.visible = true
      this.employeId = row.id
      this.$http.get('/api/sysRoleemploye/role-list-set', { params: { employeId: row.id } }).then(res => {
        console.log(res)
        this.treeData = res.data.tree
        this.checkedKeys = res.data.checkIds
      }).catch(err => {
        console.log(err.message)
      })
    },
    /**
     * 修改数据 
     */
    handleEditClick (row) {
      // 设置账号栏位不可编辑
      for (const item in this.employeForm) {
        this.employeForm[item] = ''
      }
      this.employeControl[1].readonly = true
      this.employeControl[8].options = this.educationArray
      this.employeControl[9].options = this.deptArray
      this.employeControl[10].options = this.jobsArray
      this.showForm = true
      this.employeForm.workNo = row.workNo
      this.employeForm.name = row.name
      this.employeForm.foreignName = row.foreignName
      this.employeForm.email = row.email
      this.employeForm.mobilePhone = row.mobilePhone
      this.employeForm.telePhone = row.telePhone
      this.employeForm.birthday = row.birthday
      this.employeForm.education = row.education
      this.employeForm.department = row.department
      this.employeForm.position = row.position
      this.employeForm.entryDate = row.entryDate
      this.employeForm.departureDate = row.departureDate
      this.employeForm.id = row.id
    },
    /**
     * 授权
     */
    handleAuthClick () {
    },
    /**
     *权限查看
     */
    handleAuthVClick (row) {
      this.employeId = row.id
      this.showTree = true
    },
    /**
     * 分配角色
     */
    setRole () {
      if (this.$refs.multipleTable.selection.length <= 0) {
        this.$message.warning('请选择要操作的员工')
      }
      if (this.$refs.multipleTable.selection.length > 1) {
        this.$message.warning('只能选择一个员工')
      }
      const id = this.$refs.multipleTable.selection[0].id
      this.employeId = id
      this.visible = true
      this.$http.get('/api/sysRoleemploye/role-list-set', { params: { employeId: id } }).then(res => {
        console.log(res)
        this.treeData = res.data.tree
        this.checkedKeys = res.data.checkIds
      }).catch(err => {
        console.log(err.message)
      })
    },
    // 树形全选操作
    selectAll () {
      var keys = []
      if (this.treeData.length > this.$refs.tree.getCheckedNodes().length) {
        this.treeData.map(function (item) {
          keys.push(item.id)
        })
        this.$refs.tree.setCheckedKeys(keys)
      } else {
        this.$refs.tree.setCheckedKeys([])
      }
    },

    /**
     * 角色分配提交
     */
    submitRole () {
      const nodes = this.$refs.tree.getCheckedNodes()
      this.$http.post('/api/sysRoleemploye/save?employeId=' + this.employeId, nodes).then(res => {
        this.visible = false
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
     * 重置密码
     */
    restPwd () {
      if (this.$refs.multipleTable.selection.length <= 0) {
        this.$message.warning('请选择要操作的员工')
        return
      }
      const idArray = []
      this.$refs.multipleTable.selection.forEach(element => {
        idArray.push(element.id)
      })
      this.$http.post('/api/sysEmploye/rest-password', idArray).then(res => {
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
     * 删除员工
     */
    delete () {
      if (this.$refs.multipleTable.selection.length <= 0) {
        this.$message.warning('请选择要操作的员工')
        return
      }
      this.$confirm('此操作将永久删除选择的员工, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        const idArray = []
        this.$refs.multipleTable.selection.forEach(element => {
          idArray.push(element.id)
        })
        this.$http.post('/api/sysEmploye/delete', idArray).then(res => {
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
    changeColumns (val) {
      console.log('changeColumns--' + val)
      this.tableColumns = []
      this.$nextTick(() => {
        this.tableColumns = val
      })
    },
    /**
     * table每页数字变化
     */
    handleSizeChange (val) {
      console.log(`每页 ${val} 条`)
      this.size = val
      this.searchData()
    },
    /**
     * table页数变化
     */
    handleCurrentChange (val) {
      console.log(`当前页: ${val}`)
      this.current = val
      this.searchData()
    }
  },
  created () {
    this.tableHeight = document.documentElement.clientHeight - 280
    //
    this.tableColumns = this.defaultColumns

    this.getDicItem();
    this.getDept();
    this.getJobs();
    this.searchData()
  }
}
</script>
