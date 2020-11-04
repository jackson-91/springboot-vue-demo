package org.dev.basic.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dev.basic.entity.SysTenant;
import org.dev.basic.mapper.SysTenantMapper;
import org.dev.basic.service.SysTenantService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 租户信息 服务实现类
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-07-05
 */
@Service
public class SysTenantServiceImpl extends ServiceImpl<SysTenantMapper, SysTenant> implements SysTenantService {

}
