package org.dev.framework.modules.sys.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.dev.framework.common.PaginAtion;
import org.dev.framework.common.ResponseResult;
import org.dev.framework.modules.sys.entity.SysJobs;
import org.dev.framework.modules.sys.service.SysJobsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 岗位管理 前端控制器
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-10-22
 */
@RestController
@RequestMapping("/sysJobs")
public class SysJobsController {

    @Autowired
    SysJobsService sysJobsService;
    /**
     * 岗位列表
     *
     * @param sysJobs
     * @param pagination
     * @return
     */
    @RequestMapping("/list")
    public ResponseResult<IPage<SysJobs>> list(SysJobs sysJobs, PaginAtion pagination) {
        Page page = pagination.getPage();
        return ResponseResult.success(sysJobsService.page(page, new QueryWrapper<SysJobs>(sysJobs)));
    }


    /**
     *
     * @return
     */
    @RequestMapping("/all-list")
    public ResponseResult<List<SysJobs>> allList() {
        return ResponseResult.success(sysJobsService.list());
    }

    /**
     * 员工编辑
     *
     * @param sysJobs
     * @return
     */
    @PostMapping("/save")
    public ResponseResult<String> save(@RequestBody SysJobs sysJobs) {
        boolean result = false;
        if (null == sysJobs.getId()) {

            QueryWrapper queryWrapper = new QueryWrapper();
            queryWrapper.eq("code", sysJobs.getCode());
            List<SysJobs> sysJobss = this.sysJobsService.list(queryWrapper);
            if (sysJobss != null && sysJobss.size() > 0) {
                return ResponseResult.error("职务编码已存在");
            }
            queryWrapper = new QueryWrapper();
            queryWrapper.eq("name", sysJobs.getName());
            sysJobss = this.sysJobsService.list(queryWrapper);
            if (sysJobss != null && sysJobss.size() > 0) {
                return ResponseResult.error("职务名称已存在");
            }
            result = this.sysJobsService.save(sysJobs);
        } else {
            result = this.sysJobsService.updateById(sysJobs);
        }
        if (result)
            return ResponseResult.success();

        return ResponseResult.error();
    }

    /**
     * 获取职务信息
     *
     * @param id
     * @return
     */
    @GetMapping("/get")
    public ResponseResult<SysJobs> get(@RequestParam("id") Long id) {
        SysJobs sysJobs = this.sysJobsService.getById(id);
        return ResponseResult.success(sysJobs);
    }


    /**
     * 获取职务信息
     *
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    public ResponseResult<String> delete(@RequestBody List<Long> ids) {
        this.sysJobsService.removeByIds(ids);
        return ResponseResult.success();
    }
}

