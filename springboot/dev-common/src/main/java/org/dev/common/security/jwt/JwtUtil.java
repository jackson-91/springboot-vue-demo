package org.dev.common.security.jwt;

import org.dev.common.core.entity.CurrentUser;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class JwtUtil {

    /**
     * 获取用户ID
     *
     * @return
     */
    public static Long CurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        CurrentUser sysUser = (CurrentUser) authentication.getPrincipal();
        return sysUser.getId();
    }

    /**
     * 获取用户名
     */
    public static String CurrentUserName() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        CurrentUser sysUser = (CurrentUser) authentication.getPrincipal();
        return sysUser.getUsername();
    }

    /**
     * 获取用户
     */
    public static CurrentUser CurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        CurrentUser sysUser = (CurrentUser) authentication.getPrincipal();
        return sysUser;
    }
}
