package org.dev.workflow.entity;

import lombok.Data;

import java.util.Date;

/**
 * 历史流程
 */
@Data
public class WflowInstance {
    private String id;

    private String pusinessKey;

    private String processDefinitionId;

    private String processDefinitionName;

    private String processDefinitionKey;

    private Integer processDefinitionVersion;


    private String deploymentId;

    private Date startTime;

    private Date endTime;

    private Long durationInMillis;


    private String endActivityId;

    private String startUserId;
    private String startActivityId;

    private String deleteReason;

    private String superProcessInstanceId;

    private String tenantId;

    private String tName;

    private String description;
}
