package org.dev.basic.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;

import org.dev.basic.entity.SysDic;
import org.dev.basic.entity.SysDicItem;
import org.dev.basic.service.SysDicItemService;
import org.dev.basic.service.SysDicService;
import org.dev.common.core.aop.OperLog;
import org.dev.common.core.page.PaginAtion;
import org.dev.common.core.result.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 数据库字典组 前端控制器
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-07-05
 */
@RestController
@RequestMapping("/sysDic")
public class SysDicController {


    @Autowired
    SysDicService sysDicService;

    @Autowired
    SysDicItemService sysDicItemService;

    /**
     * 数据字典集合
     *
     * @return
     */
    @GetMapping("/list")
    @OperLog(description = "数据字典集合")
    public ResponseResult<IPage<SysDic>> list(SysDic sysDic, PaginAtion pagination) {
        return ResponseResult.success(sysDicService.page(pagination.getPage(),
                new QueryWrapper<>(sysDic)));
    }

    /**
     * 数据字典集合
     *
     * @return
     */
    @GetMapping("/all-list")
    @OperLog(description = "全部数据字典集合")
    public ResponseResult<List<SysDic>> allList() {
        List<SysDic> sysDicList = sysDicService.list();
        List<SysDicItem> sysDicItems = sysDicItemService.list();
        for (SysDic sysDic : sysDicList) {
            List<SysDicItem> sysDicItems1 = sysDicItems.stream().filter(x -> x.getDicId().equals(sysDic.getId())).distinct().collect(Collectors.toList());
            sysDic.setSysDicItems(sysDicItems1);
        }
        return ResponseResult.success(sysDicList);
    }

    /**
     * 保存数据字典信息
     *
     * @param sysDic
     * @return
     */
    @PostMapping("/save")
    @OperLog(description = "新增/修改数据字典")
    public ResponseResult<String> save(@RequestBody SysDic sysDic) {
        if (null == sysDic.getId()) {
            SysDic sysDic1 = new SysDic();
            sysDic1.setDicCode(sysDic.getDicCode());
            QueryWrapper queryWrapper = new QueryWrapper(sysDic1);
            List<SysDic> sysDicList = this.sysDicService.list(queryWrapper);
            if (sysDicList != null && sysDicList.size() > 0) {
                return ResponseResult.error("代码为:" + sysDic.getDicCode() + "的字典已存在");
            }
            sysDic1 = new SysDic();
            sysDic1.setDicCode(sysDic.getDicName());
            queryWrapper = new QueryWrapper(sysDic1);
            sysDicList = this.sysDicService.list(queryWrapper);
            if (sysDicList != null && sysDicList.size() > 0) {
                return ResponseResult.error("名称为:" + sysDic.getDicName() + "的字典已存在");
            }
            this.sysDicService.save(sysDic);
        } else {
            this.sysDicService.updateById(sysDic);
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
    @OperLog(description = "批量删除数据字典")
    @Transactional
    public ResponseResult<String> delete(@RequestBody List<Long> ids) {
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.in("dic_id", ids);
        this.sysDicItemService.remove(queryWrapper);
        this.sysDicService.removeByIds(ids);
        return ResponseResult.success();
    }

}

