package org.dev.common.utils;

import org.dev.common.core.entity.CurrentUser;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class SpringSecurityUtils {

    /***
     * 获取当前用户信息
     * @return
     */
    public static CurrentUser CurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        CurrentUser currentUser = (CurrentUser) authentication.getPrincipal();
        return currentUser;
    }
}
