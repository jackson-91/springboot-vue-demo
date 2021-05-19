package org.dev.workflow.listener;

import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.ExecutionListener;

/**
 * 流程监听器
 */
@Slf4j
public class DevExecutionListener implements ExecutionListener {
    @Override
    public void notify(DelegateExecution delegateExecution) {
        String eventName = delegateExecution.getEventName();
        log.info("监听到了---------------------------");
        log.info(JSON.toJSONString(delegateExecution));
        log.info("监听到了---------------------------");
        if ("start".equals(eventName)) {
            log.info("start=========");
        } else if ("end".equals(eventName)) {
            log.info("end=========");
        }

    }
}
