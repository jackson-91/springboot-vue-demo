package org.dev.auth.module.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.dev.auth.module.entity.SysFunc;
import org.dev.auth.module.service.SysFuncService;
import org.dev.common.core.aop.DuplicateSubmit;
import org.dev.common.core.page.PaginAtion;
import org.dev.common.core.result.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
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
@RequestMapping("/sysFunc")
public class SysFuncController {

    @Autowired
    SysFuncService sysFuncService;


    /**
     * 返回菜单保存的方法列表
     *
     * @param menuId
     * @param pagination
     * @return
     */
    @RequestMapping("/menu-func-list")
    @DuplicateSubmit
    public ResponseResult<IPage<SysFunc>> menuFuncList(@RequestParam("menuId") Long menuId, PaginAtion pagination) {
        SysFunc sysFunc = new SysFunc();
        sysFunc.setMenuId(menuId);
        QueryWrapper entityWrapper = new QueryWrapper();
        entityWrapper.eq("menu_id", menuId);
        return ResponseResult.success(this.sysFuncService.page(pagination.getPage(), entityWrapper));
    }

    /**
     * 保存方法信息
     *
     * @param sysFunc
     * @return
     */
    @PostMapping("/save")
    public ResponseResult<String> save(@RequestBody SysFunc sysFunc) {
        if (null == sysFunc.getId()) {
            QueryWrapper queryWrapper = new QueryWrapper();
            queryWrapper.eq("func_code", sysFunc.getFuncCode());
            List<SysFunc> sysFuncList = this.sysFuncService.list(queryWrapper);
            if (sysFuncList != null && sysFuncList.size() > 0) {
                return ResponseResult.error("代码为:" + sysFunc.getFuncCode() + "的方法已存在");
            }
            //
            queryWrapper = new QueryWrapper();
            queryWrapper.eq("func_name", sysFunc.getFuncName());
            sysFuncList = this.sysFuncService.list(queryWrapper);
            if (sysFuncList != null && sysFuncList.size() > 0) {
                return ResponseResult.error("名称为:" + sysFunc.getFuncName() + "的方法已存在");
            }
            this.sysFuncService.save(sysFunc);
        } else {
            this.sysFuncService.updateById(sysFunc);
        }
        return ResponseResult.success();
    }

    /**
     * 批量删除方法
     *
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    public ResponseResult<String> delete(@RequestBody List<Long> ids) {
        this.sysFuncService.removeByIds(ids);
        return ResponseResult.success();
    }

}

