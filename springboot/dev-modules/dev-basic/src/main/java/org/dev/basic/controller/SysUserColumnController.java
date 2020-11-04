package org.dev.basic.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import org.dev.basic.entity.SysUserColumn;
import org.dev.basic.service.SysUserColumnService;
import org.dev.common.core.entity.CurrentUser;
import org.dev.common.core.result.ResponseResult;
import org.dev.common.utils.SpringSecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author hlt
 * @since 2020-06-24
 */
@RestController
@RequestMapping("/sysUserColumn")
public class SysUserColumnController {

    private static final Logger logger = LoggerFactory.getLogger(SysUserColumnController.class);
    @Autowired
    SysUserColumnService sysUserColumnService;

    /**
     * 查询某个表格自定义列
     *
     * @return
     */
    @GetMapping("/get")
    public ResponseResult<SysUserColumn> get(SysUserColumn sysUserColumn) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        CurrentUser currentUser = (CurrentUser) authentication.getPrincipal();
        sysUserColumn.setUserId(currentUser.getId());
        QueryWrapper queryWrapper = new QueryWrapper(sysUserColumn);
        List<SysUserColumn> sysUserColumns = sysUserColumnService.list(queryWrapper);
        if (sysUserColumns == null || sysUserColumns.size() == 0) {
            return ResponseResult.success(null);
        }
        SysUserColumn sysUserColumn1 = sysUserColumns.get(0);
        logger.info("---" + sysUserColumn1.getId());
        return ResponseResult.success(sysUserColumn1);
    }

    /**
     * 新增/保存某个表格自定义列
     *
     * @return
     */
    @PostMapping("/save")
    public ResponseResult<SysUserColumn> save(@RequestBody SysUserColumn sysUserColumn) {
        sysUserColumn.setUserId(SpringSecurityUtils.CurrentUser().getId());
        if (null != sysUserColumn.getId()) {
            SysUserColumn sysUserColumn1 = this.sysUserColumnService.getById(sysUserColumn.getId());
            sysUserColumn1.setTableColumns(sysUserColumn.getTableColumns());
            sysUserColumn1.setColumnValue(sysUserColumn.getColumnValue());
            sysUserColumn1.setModelCode(sysUserColumn.getModelCode());
            sysUserColumnService.updateById(sysUserColumn1);
        } else {
            sysUserColumnService.save(sysUserColumn);
        }
        return ResponseResult.success(sysUserColumn);
    }
}

