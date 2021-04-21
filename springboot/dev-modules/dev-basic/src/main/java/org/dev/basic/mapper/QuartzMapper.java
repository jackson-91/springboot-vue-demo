package org.dev.basic.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import org.dev.basic.entity.QuartzJob;

public interface QuartzMapper {
    IPage<QuartzJob> page(Page<?> page, @Param("jobName") String jobName, @Param("jobType") String jobType);
}
