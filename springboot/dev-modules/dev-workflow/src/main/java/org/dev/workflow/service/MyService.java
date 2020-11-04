package org.dev.workflow.service;

import org.activiti.engine.task.Task;

import java.util.List;

public interface MyService {

    void startProcess();


    List<Task> getTasks(String assignee);
}
