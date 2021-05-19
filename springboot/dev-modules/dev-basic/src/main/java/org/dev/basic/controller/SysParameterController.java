package org.dev.basic.controller;

import org.dev.basic.service.SysParameterService;
import org.dev.basic.entity.SysParameter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.dev.common.core.page.PaginAtion;
import org.dev.common.core.result.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/sysParameter")
public class SysParameterController {
    @Autowired
    public SysParameterService sysParameterService;

    /**
     * 保存和修改公用的
     *
     * @param sysParameter 传递的实体
     * @return ResponseResult转换结果
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ResponseResult<String> save(@RequestBody SysParameter sysParameter) {
        boolean result = false;
        try {
            if (sysParameter.getId() != null) {
                result = sysParameterService.updateById(sysParameter);
            } else {
                result = sysParameterService.save(sysParameter);
            }
        } catch (Exception e) {
            e.printStackTrace();
            result = false;
        }
        if (result)
            return ResponseResult.success();
        return ResponseResult.error();
    }

    /**
     * 获取对象信息
     *
     * @param id
     * @return
     */
    @GetMapping("/get")
    public ResponseResult<SysParameter> get(@RequestParam("id") Long id) {
        SysParameter sysParameter = sysParameterService.getById(id);
        return ResponseResult.success(sysParameter);
    }

    /**
     * 删除对象信息
     *
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    public ResponseResult<String> delete(@RequestBody List<Long> ids) {
        try {
            sysParameterService.removeByIds(ids);
            return ResponseResult.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.error("删除对象失败！" + e.getMessage());
        }
    }

    /**
     * 分页查询数据信息
     *
     * @param ids
     * @param sysParameter
     * @return
     */
    @RequestMapping("/list")
    public ResponseResult<IPage<SysParameter>> list(SysParameter sysParameter, PaginAtion pagination) {
        Page page = pagination.getPage();
        return ResponseResult.success(sysParameterService.page(page, new QueryWrapper<SysParameter>(sysParameter)));
    }
}