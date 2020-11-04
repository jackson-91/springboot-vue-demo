package org.dev.auth.module.service;

import com.baomidou.mybatisplus.extension.service.IService;

import org.dev.auth.module.entity.SysUser;
import org.springframework.security.core.userdetails.UserDetailsService;

/**
 * <p>
 * 用户基本信息 服务类
 * </p>
 *
 * @author hlt
 * @since 2020-06-24
 */
public interface SysUserService extends IService<SysUser>, UserDetailsService {

}
