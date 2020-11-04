package org.dev.util.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.dev.common.core.aop.OperLog;
import org.dev.common.core.page.PaginAtion;
import org.dev.common.core.result.ResponseResult;
import org.dev.util.entity.SysSequenceLog;
import org.dev.util.service.SysSequenceLogService;
import org.dev.util.service.SysSequenceService;
import org.dev.util.util.SequenceUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 生成的队列号 前端控制器
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-07-20
 */
@RestController
@RequestMapping("/sysSequenceLog")
public class SysSequenceLogController {
    @Autowired
    SysSequenceService sysSequenceService;
    @Autowired
    SysSequenceLogService sequenceLogService;
    @Autowired
    SequenceUtil sequenceUtil;

    /**
     * 流水码集合
     *
     * @return
     */
    @GetMapping("/list")
    @OperLog(description = "流水码日志查询")
    public ResponseResult<IPage<SysSequenceLog>> list(SysSequenceLog sysSequenceLog, PaginAtion pagination) {
        return ResponseResult.success(sequenceLogService.page(pagination.getPage(),
                new QueryWrapper<>(sysSequenceLog)));
    }
}

