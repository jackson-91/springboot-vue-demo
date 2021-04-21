package org.dev.basic.job;

import lombok.extern.slf4j.Slf4j;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
@Slf4j
public class Job2 extends QuartzJobBean {
    @Override
    protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        log.info("**--开始执行任务---**");
        log.info("-------------------这是定时JOB2-----------------");
        log.info(jobExecutionContext.getJobDetail().getDescription()+jobExecutionContext.getJobDetail().getKey());
        log.info("-------------------这是定时JOB2-----------------");
        log.info("**--任务执行完成---**");
    }
}
