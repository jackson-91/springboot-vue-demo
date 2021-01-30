package org.dev.basic.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import org.dev.basic.entity.SysDept;
import org.dev.basic.entity.SysEmploye;
import org.dev.basic.service.SysDeptService;
import org.dev.basic.service.SysEmployeService;
import org.dev.common.core.page.PaginAtion;
import org.dev.common.core.result.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 员工前端控制器
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-08-02
 */
@RestController
@RequestMapping("/sysEmploye")
public class SysEmployeController {
    @Autowired
    SysEmployeService sysEmployeService;

    @Autowired
    SysDeptService sysDeptService;

    /**
     * 系统用户列表
     *
     * @param sysEmploye
     * @param pagination
     * @return
     */
    @RequestMapping("/list")
    public ResponseResult<IPage<SysEmploye>> list(SysEmploye sysEmploye, PaginAtion pagination) {
        Page page = pagination.getPage();
        return ResponseResult.success(sysEmployeService.page(page, new QueryWrapper<SysEmploye>(sysEmploye)));
    }


    /**
     * @param sysEmploye
     * @return
     */
    @RequestMapping("/all-list")
    public ResponseResult<List<SysEmploye>> allList(SysEmploye sysEmploye) {
        return ResponseResult.success(sysEmployeService.list());
    }


    /**
     * 员工编辑
     *
     * @param sysEmploye
     * @return
     */
    @PostMapping("/save")
    public ResponseResult<String> save(@RequestBody SysEmploye sysEmploye) {
        boolean result = false;
        if (null == sysEmploye.getId()) {

            QueryWrapper queryWrapper = new QueryWrapper();
            queryWrapper.eq("work_no", sysEmploye.getWorkNo());
            List<SysEmploye> sysEmployes = this.sysEmployeService.list(queryWrapper);
            if (sysEmployes != null && sysEmployes.size() > 0) {
                return ResponseResult.error("工号已存在");
            }
            queryWrapper = new QueryWrapper();
            queryWrapper.eq("email", sysEmploye.getEmail());
            sysEmployes = this.sysEmployeService.list(queryWrapper);
            if (sysEmployes != null && sysEmployes.size() > 0) {
                return ResponseResult.error("邮箱已存在");
            }
            queryWrapper = new QueryWrapper();
            queryWrapper.eq("mobile_phone", sysEmploye.getMobilePhone());
            sysEmployes = this.sysEmployeService.list(queryWrapper);
            if (sysEmployes != null && sysEmployes.size() > 0) {
                return ResponseResult.error("手机号已经存在");
            }
            if (!StringUtils.isEmpty(sysEmploye.getDeptId())) {
                SysDept sysDept = this.sysDeptService.getById(sysEmploye.getDeptId());
                sysEmploye.setDeptCode(sysDept.getDeptCode());
                sysEmploye.setDeptName(sysDept.getDeptName());
            }
            result = this.sysEmployeService.save(sysEmploye);
        } else {
            if (!StringUtils.isEmpty(sysEmploye.getDeptId())) {
                SysDept sysDept = this.sysDeptService.getById(sysEmploye.getDeptId());
                sysEmploye.setDeptCode(sysDept.getDeptCode());
                sysEmploye.setDeptName(sysDept.getDeptName());
            }
            result = this.sysEmployeService.updateById(sysEmploye);
        }
        if (result)
            return ResponseResult.success();

        return ResponseResult.error();
    }

    /**
     * 获取员工信息
     *
     * @param id
     * @return
     */
    @GetMapping("/get")
    public ResponseResult<SysEmploye> get(@RequestParam("id") Long id) {
        SysEmploye sysEmploye = this.sysEmployeService.getById(id);
        return ResponseResult.success(sysEmploye);
    }


    /**
     * 获取员工信息
     *
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    public ResponseResult<String> delete(@RequestBody List<Long> ids) {
        this.sysEmployeService.removeByIds(ids);
        return ResponseResult.success();
    }
}

