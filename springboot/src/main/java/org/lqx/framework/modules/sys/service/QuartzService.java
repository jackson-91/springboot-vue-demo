package org.lqx.framework.modules.sys.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.lqx.framework.modules.sys.entity.QuartzJob;

public interface QuartzService {
    IPage<QuartzJob> page(Page<?> page, String jobName);
}
