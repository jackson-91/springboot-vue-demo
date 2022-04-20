package org.dev.common.core.handler;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.dev.common.core.entity.CurrentUser;
import org.dev.common.security.jwt.JwtUtil;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.util.Date;

@Slf4j
@Component
public class DevMetaHandler implements MetaObjectHandler {

    /**
     * 新增数据执行
     *
     * @param metaObject
     */
    @Override
    public void insertFill(MetaObject metaObject) {
        Object createTime = metaObject.getValue("createTime");
        if (null == createTime) {
            this.setFieldValByName("createTime", new Date(), metaObject);
        }
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (null != authentication) {
            CurrentUser sysUser = (CurrentUser) authentication.getPrincipal();
            this.setFieldValByName("createBy", sysUser.getId(), metaObject);
        }
        Object updateTime = metaObject.getValue("updateTime");
        if (null == updateTime) {
            this.setFieldValByName("updateTime", new Date(), metaObject);
        }
        if (null != authentication) {
            CurrentUser sysUser = (CurrentUser) authentication.getPrincipal();
            this.setFieldValByName("updateBy", sysUser.getId(), metaObject);
        }

    }

    /**
     * 更新数据执行
     *
     * @param metaObject
     */
    @Override
    public void updateFill(MetaObject metaObject) {
        //this.setFieldValByName("updateBy", JwtUtil.CurrentUserId(), metaObject);
        //this.setFieldValByName("updateTime", new Date(), metaObject);
        Object updateTime = metaObject.getValue("updateTime");
        if (null == updateTime) {
            this.setFieldValByName("updateTime", new Date(), metaObject);
        }
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (null != authentication) {
            CurrentUser sysUser = (CurrentUser) authentication.getPrincipal();
            this.setFieldValByName("updateBy", sysUser.getId(), metaObject);
        }

    }

}