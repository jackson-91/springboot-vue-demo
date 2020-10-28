package org.dev.framework.modules.sys.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.dev.framework.common.PaginAtion;
import org.dev.framework.common.ResponseResult;
import org.dev.framework.modules.sys.entity.SysEmploye;
import org.dev.framework.modules.sys.service.SysEmployeService;
import org.springframework.beans.factory.annotation.Autowired;
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
            result = this.sysEmployeService.save(sysEmploye);
        } else {
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

