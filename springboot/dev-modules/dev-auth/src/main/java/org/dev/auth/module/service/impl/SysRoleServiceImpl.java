package org.dev.auth.module.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dev.auth.module.entity.SysRole;
import org.dev.auth.module.mapper.SysRoleMapper;
import org.dev.auth.module.service.SysRoleService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 权限管理-角色管理 服务实现类
 * </p>
 *
 * @author hlt
 * @since 2020-06-24
 */
@Service
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole> implements SysRoleService {

}
