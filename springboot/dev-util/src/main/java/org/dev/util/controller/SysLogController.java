package org.dev.util.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.dev.common.core.page.PaginAtion;
import org.dev.common.core.result.ResponseResult;
import org.dev.util.entity.SysLog;
import org.dev.util.service.SysLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 操作记录 前端控制器
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-07-06
 */
@RestController
@RequestMapping("/sysLog")
public class SysLogController {

    @Autowired
    SysLogService sysLogService;

    /**
     * 查询日志列表
     *
     * @param sysLog
     * @param pagination
     * @return
     */
    @RequestMapping("/list")
    public ResponseResult<IPage<SysLog>> list(SysLog sysLog, PaginAtion pagination) {
        return ResponseResult.success(sysLogService.page(pagination.getPage(),
                new QueryWrapper<>(sysLog)));
    }
}

