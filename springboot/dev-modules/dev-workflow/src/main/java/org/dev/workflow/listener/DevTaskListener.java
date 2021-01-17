package org.dev.workflow.listener;

import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;

@Slf4j
public class DevTaskListener implements TaskListener {
    @Override
    public void notify(DelegateTask delegateTask) {
        String eventName = delegateTask.getEventName();
        log.info("TaskListener监听到了---------------------------");
        log.info(JSON.toJSONString(delegateTask));
        log.info("TaskListener监听到了---------------------------");
        if ("create".endsWith(eventName)) {
            log.info("create=========");
        } else if ("assignment".endsWith(eventName)) {
            log.info("assignment========" + delegateTask.getAssignee());
        } else if ("complete".endsWith(eventName)) {
            log.info("complete===========");
        } else if ("delete".endsWith(eventName)) {
            log.info("delete=============");
        }
    }
}
