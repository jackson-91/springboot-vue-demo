package org.dev.framework.modules.workflow.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.extern.slf4j.Slf4j;
import org.activiti.engine.HistoryService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricProcessInstanceQuery;
import org.dev.framework.common.PaginAtion;
import org.dev.framework.common.ResponseResult;
import org.dev.framework.modules.workflow.entity.WflowInstance;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

/**
 * 历史流程
 */
@RestController
@RequestMapping("wflowInstance")
@Slf4j
public class WflowInstanceController {
    /**
     * 历史流程
     *
     * @param wflowInstance
     * @param pagination
     * @return
     */
    @RequestMapping("/list")
    public ResponseResult<IPage<WflowInstance>> list(WflowInstance wflowInstance, PaginAtion pagination) {
        IPage page = pagination.getPage();
        int firstResult = (pagination.getCurrent() - 1) * pagination.getSize();
        int maxResults = pagination.getCurrent() * pagination.getSize();
        //获取ProcessEngine对象 默认配置文件名称：activiti.cfg.xml 并且configuration的Bean实例ID为processEngineConfiguration
        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
        //获取HistoryService接口
        HistoryService historyService = processEngine.getHistoryService();
        //获取历史任务
        HistoricProcessInstanceQuery historicProcessInstanceQuery = historyService.createHistoricProcessInstanceQuery();
        //获取指定流程实例的任务
        //historicActivityInstanceQuery.processInstanceId("2501");
        //获取任务列表
        List<HistoricProcessInstance> list = historicProcessInstanceQuery.orderByProcessInstanceEndTime().finished().desc().listPage(firstResult, maxResults);
        //查询总数
        Long count = historicProcessInstanceQuery.finished().count();
        //
        List<WflowInstance> wflowInstances = new ArrayList<>();
        for (HistoricProcessInstance ai : list) {
            wflowInstance = new WflowInstance();
            BeanUtils.copyProperties(ai, wflowInstance);
            wflowInstances.add(wflowInstance);
        }
        page.setTotal(count);
        page.setRecords(list);
        return ResponseResult.success(page);
    }
}
