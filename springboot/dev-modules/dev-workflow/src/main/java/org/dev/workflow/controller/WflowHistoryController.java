package org.dev.workflow.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.extern.slf4j.Slf4j;
import org.activiti.engine.*;
import org.activiti.engine.history.*;
import org.dev.common.core.page.PaginAtion;
import org.dev.common.core.result.ResponseResult;
import org.dev.common.utils.SpringSecurityUtils;
import org.dev.workflow.entity.WflowHis;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("wflowHistory")
@Slf4j
public class WflowHistoryController {



    /**
     * 签核历史查询
     *
     * @param wflowHis
     * @param pagination
     * @return
     */
    @RequestMapping("/list")
    public ResponseResult<IPage<WflowHis>> list(WflowHis wflowHis, PaginAtion pagination) {
        IPage page = pagination.getPage();
        int firstResult = (pagination.getCurrent() - 1) * pagination.getSize();
        int maxResults = pagination.getCurrent() * pagination.getSize();
        //获取ProcessEngine对象 默认配置文件名称：activiti.cfg.xml 并且configuration的Bean实例ID为processEngineConfiguration
        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
        //获取HistoryService接口
        HistoryService historyService = processEngine.getHistoryService();
        //获取历史任务
        HistoricActivityInstanceQuery historicActivityInstanceQuery = historyService.createHistoricActivityInstanceQuery().taskAssignee(SpringSecurityUtils.CurrentUser().getLoginName());
        //获取指定流程实例的任务
        //historicActivityInstanceQuery.processInstanceId("2501");
        //获取任务列表
        List<HistoricActivityInstance> list = historicActivityInstanceQuery.orderByHistoricActivityInstanceEndTime().desc().listPage(firstResult, maxResults);
        //查询总数
        Long count = historicActivityInstanceQuery.taskAssignee(SpringSecurityUtils.CurrentUser().getLoginName()).count();
        //
        List<WflowHis> wflowHisList = new ArrayList<>();
        for (HistoricActivityInstance ai : list) {
            WflowHis wflowHis1 = new WflowHis();
            BeanUtils.copyProperties(ai, wflowHis1);
            wflowHisList.add(wflowHis1);
        }
        page.setTotal(count);
        page.setRecords(list);
        return ResponseResult.success(page);
    }

    /**
     * 流程历史查询
     *
     * @param wflowHis
     * @param pagination
     * @return
     */
    @RequestMapping("/all-list")
    public ResponseResult<IPage<WflowHis>> allList(WflowHis wflowHis, PaginAtion pagination) {
        IPage page = pagination.getPage();
        int firstResult = (pagination.getCurrent() - 1) * pagination.getSize();
        int maxResults = pagination.getCurrent() * pagination.getSize();
        //获取ProcessEngine对象 默认配置文件名称：activiti.cfg.xml 并且configuration的Bean实例ID为processEngineConfiguration
        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
        //获取HistoryService接口
        HistoryService historyService = processEngine.getHistoryService();
        //获取历史任务
        HistoricActivityInstanceQuery historicActivityInstanceQuery = historyService.createHistoricActivityInstanceQuery();
        //获取指定流程实例的任务
        //historicActivityInstanceQuery.processInstanceId("2501");
        //获取任务列表
        List<HistoricActivityInstance> list = historicActivityInstanceQuery.finished().listPage(firstResult, maxResults);
        //
        Long count = historicActivityInstanceQuery.count();
        //
        List<WflowHis> wflowHisList = new ArrayList<>();
        for (HistoricActivityInstance ai : list) {
            WflowHis wflowHis1 = new WflowHis();
            BeanUtils.copyProperties(ai, wflowHis1);
            wflowHisList.add(wflowHis1);
        }
        page.setTotal(count);
        page.setRecords(list);
        return ResponseResult.success(page);
    }
}
