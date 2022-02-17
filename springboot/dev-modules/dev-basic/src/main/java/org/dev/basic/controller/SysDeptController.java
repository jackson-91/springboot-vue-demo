package org.dev.basic.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.dev.basic.entity.SysDept;
import org.dev.basic.entity.SysJobs;
import org.dev.basic.service.SysDeptService;
import org.dev.basic.service.SysJobsService;
import org.dev.common.core.page.PaginAtion;
import org.dev.common.core.result.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 部门表 前端控制器
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-10-24
 */
@RestController
@RequestMapping("/sysDept")
public class SysDeptController {
    @Autowired
    SysDeptService sysDeptService;

    @Autowired
    SysJobsService sysJobsService;

    /**
     * 部门列表
     *
     * @param sysDept
     * @param pagination
     * @return
     */
    @RequestMapping("/list")
    public ResponseResult<IPage<SysDept>> list(SysDept sysDept, PaginAtion pagination) {
        Page page = pagination.getPage();
        return ResponseResult.success(sysDeptService.page(page, new QueryWrapper<SysDept>(sysDept)));
    }


    /**
     * 部门列表
     *
     * @param sysDept
     * @return
     */
    @RequestMapping("/tree-list")
    public ResponseResult<IPage<SysDept>> treeList(SysDept sysDept, PaginAtion pagination) {
        Page page = pagination.getPage();
        if (StringUtils.isEmpty(sysDept.getDeptCode()) && StringUtils.isEmpty(sysDept.getDeptName())) {
            sysDept.setParentId(-1L);
            QueryWrapper queryWrapper = new QueryWrapper(sysDept);
            IPage<SysDept> sysDeptIPage = this.sysDeptService.page(page, queryWrapper);
            List<SysDept> sysDepts = sysDeptIPage.getRecords();
            if (sysDepts != null && sysDepts.size() > 0) {
                this.getChildren(sysDepts);
            }
            return ResponseResult.success(sysDeptIPage);
        } else {
            return ResponseResult.success(sysDeptService.page(page, new QueryWrapper<SysDept>(sysDept)));
        }
    }


    /**
     * 部门列表
     *
     * @return
     */
    @RequestMapping("/tree-all-list")
    public ResponseResult<List<SysDept>> treeAllList() {
        SysDept sysDept = new SysDept();
        sysDept.setParentId(-1L);
        QueryWrapper queryWrapper = new QueryWrapper(sysDept);
        List<SysDept> sysDeptList = this.sysDeptService.list(queryWrapper);
        if (sysDeptList != null && sysDeptList.size() > 0) {
            this.getChildren(sysDeptList);
        }
        return ResponseResult.success(sysDeptList);
    }


    /**
     * @param sysDepts
     */
    private void getChildren(List<SysDept> sysDepts) {
        for (SysDept sysDept : sysDepts) {
            SysDept sysDept1 = new SysDept();
            sysDept1.setParentId(sysDept.getId());
            QueryWrapper queryWrapper = new QueryWrapper(sysDept1);
            List<SysDept> _cSysDepts = this.sysDeptService.list(queryWrapper);
            if (_cSysDepts != null && _cSysDepts.size() > 0) {
                sysDept.setChildren(_cSysDepts);
                //sysDept.setHasChildren(true);
                this.getChildren(_cSysDepts);
            }
        }
    }

    /**
     * 部门编辑
     *
     * @param sysDept
     * @return
     */
    @PostMapping("/save")
    public ResponseResult<String> save(@RequestBody SysDept sysDept) {
        boolean result = false;

        if (null != sysDept.getDeptHeaderJobs()) {
            SysJobs sysJobs = this.sysJobsService.getById(sysDept.getDeptHeaderJobs());
            if (sysJobs != null) {
                sysDept.setDeptHeader(sysDept.getDeptHeaderJobs());
                sysDept.setDeptHeaderJobscode(sysJobs.getCode());
                sysDept.setDeptHeaderJobsname(sysJobs.getName());
            }
        }
        if (null == sysDept.getId()) {

            QueryWrapper queryWrapper = new QueryWrapper();
            queryWrapper.eq("dept_code", sysDept.getDeptCode());
            List<SysDept> sysDepts = this.sysDeptService.list(queryWrapper);
            if (sysDepts != null && sysDepts.size() > 0) {
                return ResponseResult.error("部门编码已存在");
            }
            queryWrapper = new QueryWrapper();
            queryWrapper.eq("dept_name", sysDept.getDeptName());
            sysDepts = this.sysDeptService.list(queryWrapper);
            if (sysDepts != null && sysDepts.size() > 0) {
                return ResponseResult.error("部门名称已存在");
            }
            result = this.sysDeptService.save(sysDept);
        } else {
            result = this.sysDeptService.updateById(sysDept);
        }
        if (result)
            return ResponseResult.success();

        return ResponseResult.error();
    }

    /**
     * 获取部门信息
     *
     * @param id
     * @return
     */
    @GetMapping("/get")
    public ResponseResult<SysDept> get(@RequestParam("id") Long id) {
        SysDept sysDept = this.sysDeptService.getById(id);
        return ResponseResult.success(sysDept);
    }


    /**
     * 获取部门信息
     *
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    public ResponseResult<String> delete(@RequestBody List<Long> ids) {
        for (Long id : ids) {
            SysDept sysDept = this.sysDeptService.getById(id);
            if (sysDept.getParentId() == -1L) {
                return ResponseResult.error("顶级结点不能删除");
            }
        }
        this.sysDeptService.removeByIds(ids);
        return ResponseResult.success();
    }
}

