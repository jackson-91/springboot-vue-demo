package org.dev.basic.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dev.basic.entity.SysJobs;
import org.dev.basic.mapper.SysJobsMapper;
import org.dev.basic.service.SysJobsService;
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
