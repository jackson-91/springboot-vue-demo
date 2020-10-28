package org.dev.framework.modules.sys.service.impl;

import org.dev.framework.modules.sys.entity.SysJobs;
import org.dev.framework.modules.sys.mapper.SysJobsMapper;
import org.dev.framework.modules.sys.service.SysJobsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 岗位管理 服务实现类
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-10-22
 */
@Service
public class SysJobsServiceImpl extends ServiceImpl<SysJobsMapper, SysJobs> implements SysJobsService {

}
