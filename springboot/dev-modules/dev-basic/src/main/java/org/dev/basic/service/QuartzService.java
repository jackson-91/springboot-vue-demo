package org.dev.basic.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.dev.basic.entity.QuartzJob;


public interface QuartzService {
    IPage<QuartzJob> page(Page<?> page, String jobName,String jobType);
}
