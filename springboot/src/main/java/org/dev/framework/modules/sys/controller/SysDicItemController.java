package org.dev.framework.modules.sys.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.netty.util.Constant;
import org.dev.framework.modules.sys.entity.SysDic;
import org.dev.framework.modules.sys.entity.SysDicItem;
import org.dev.framework.common.PaginAtion;
import org.dev.framework.common.ResponseResult;
import org.dev.framework.core.aop.OperLog;
import org.dev.framework.modules.sys.entity.SysDicItem;
import org.dev.framework.modules.sys.service.SysDicItemService;
import org.dev.framework.modules.sys.service.SysDicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>
 * 数据库字典组-子级 前端控制器
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-07-05
 */
@RestController
@RequestMapping("/sysDicItem")
public class SysDicItemController {


    @Autowired
    SysDicItemService sysDicItemService;

    @Autowired
    SysDicService sysDicService;

    /**
     * 数据字典子项集合
     *
     * @return
     */
    @GetMapping("/list")
    @OperLog(description = "数据字典集合")
    public ResponseResult<IPage<SysDicItem>> list(SysDicItem sysDicItem, PaginAtion pagination) {
        return ResponseResult.success(sysDicItemService.page(pagination.getPage(),
                new QueryWrapper<>(sysDicItem)));
    }


    /**
     * 数据字典子项集合
     *
     * @return
     */
    @GetMapping("/item-list-bydiccode")
    @OperLog(description = "数据字典集合")
    public ResponseResult<List<SysDicItem>> listByDicCode(@RequestParam("dicCode") String dicCode) {
        SysDic sysDic = new SysDic();
        sysDic.setDicCode(dicCode);
        QueryWrapper queryWrapper = new QueryWrapper(sysDic);
        SysDic sysDic1 = this.sysDicService.getOne(queryWrapper);
        SysDicItem sysDicItem = new SysDicItem();
        sysDicItem.setDicId(sysDic1.getId());
        return ResponseResult.success(sysDicItemService.list(new QueryWrapper<>(sysDicItem)));
    }


    /**
     * 数据字典子项集合
     *
     * @return
     */
    @GetMapping("/item-list-bydiccodes")
    @OperLog(description = "数据字典集合")
    public ResponseResult<Map<String, List<SysDicItem>>> listByDicCodes(@RequestParam("dicCode") Collection<String> dicCodes) {
        Map<String, List<SysDicItem>> map = new HashMap<>();
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.in("dic_code", dicCodes);
        List<SysDic> sysDicList = this.sysDicService.list(queryWrapper);
        List<Long> dicLongs = sysDicList.stream().map(SysDic::getId).distinct().collect(Collectors.toList());
        QueryWrapper queryWrapper1 = new QueryWrapper();
        queryWrapper1.in("dicId", dicLongs);
        List<SysDicItem> sysDicItems = sysDicItemService.list(queryWrapper1);
        for (String dicCode : dicCodes) {
            Optional<SysDic> sysDicOptional = sysDicList.stream().filter(x -> x.getDicCode().equals(dicCode)).findFirst();
            if (sysDicOptional.isPresent()) {
                List<SysDicItem> sysDicItems1 = sysDicItems.stream().filter(x -> x.getDicId().equals(sysDicOptional.get().getId())).collect(Collectors.toList());
                map.put("dicCode", sysDicItems1);
            }
        }
        return ResponseResult.success(map);
    }


    /**
     * 保存数据字典子项信息
     *
     * @param sysDicItem
     * @return
     */
    @PostMapping("/save")
    public ResponseResult<String> save(@RequestBody SysDicItem sysDicItem) {
        if (null == sysDicItem.getId()) {
            SysDicItem sysDicItem1 = new SysDicItem();
            sysDicItem1.setDicItemCode(sysDicItem.getDicItemCode());
            sysDicItem1.setDicId(sysDicItem.getDicId());
            QueryWrapper queryWrapper = new QueryWrapper(sysDicItem1);
            List<SysDicItem> sysDicList = this.sysDicItemService.list(queryWrapper);
            if (sysDicList != null && sysDicList.size() > 0) {
                return ResponseResult.error("代码为:" + sysDicItem.getDicItemCode() + "的子项已存在");
            }
            this.sysDicItemService.save(sysDicItem);
        } else {
            this.sysDicItemService.updateById(sysDicItem);
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
        this.sysDicItemService.removeByIds(ids);
        return ResponseResult.success();
    }


}

