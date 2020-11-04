package org.dev.util.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dev.util.entity.SysLog;
import org.dev.util.mapper.SysLogMapper;
import org.dev.util.service.SysLogService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 操作记录 服务实现类
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-07-06
 */
@Service
public class SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog> implements SysLogService {

}
