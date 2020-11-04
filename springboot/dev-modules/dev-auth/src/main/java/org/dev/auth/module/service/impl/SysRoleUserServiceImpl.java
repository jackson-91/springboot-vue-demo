package org.dev.auth.module.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dev.auth.module.entity.SysRoleUser;
import org.dev.auth.module.mapper.SysRoleUserMapper;
import org.dev.auth.module.service.SysRoleUserService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 角色用户关系表 服务实现类
 * </p>
 *
 * @author hlt
 * @since 2020-06-24
 */
@Service
public class SysRoleUserServiceImpl extends ServiceImpl<SysRoleUserMapper, SysRoleUser> implements SysRoleUserService {

}
