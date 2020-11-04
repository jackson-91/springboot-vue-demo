package org.dev.common.core.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

@Data
public class CurrentUser implements UserDetails {

    /**
     * ID
     */
    private Long id;

    /**
     * 登录名
     */
    private String loginName;
    /**
     * 昵称
     */
    private String nickName;
    /**
     * 密码
     */
    private String password;
    /**
     * 性别
     */
    private String gender;
    /**
     * 邮箱
     */
    private String email;
    /**
     * 手机号码
     */
    private String mobilePhone;
    /**
     * 微信号
     */
    private String wechat;
    /**
     * QQ号
     */
    private String qq;
    /**
     * 传真
     */
    private String fax;
    /**
     * 最后登录时间
     */
    private Date lastLoginTime;
    /**
     * 有效期
     */
    private Date expireTime;
    /**
     * 是否禁用 1启用 0禁用
     */
    private Integer isEnable;
    /**
     * 用户头像
     */
    private String userImg;
    /**
     * 用户皮肤
     */
    private String userSkin;


    @TableField(exist = false)
    private List<CurrentRole> roles;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        CurrentRole currentRole = new CurrentRole();
        currentRole.setRoleCode("ROLE_LOGIN");
        currentRole.setRoleName("默认角色");
        currentRole.setMemo("设置默认角色用于访问需要登录访问但不需要特殊权限的接口");
        if (roles == null) {
            roles = new ArrayList<>();
        }
        roles.add(currentRole);
        return roles;
    }

    @Override
    public String getUsername() {
        return loginName;
    }

    @Override
    public boolean isAccountNonExpired() {
        if (expireTime == null) {
            return true;
        }
        return expireTime.compareTo(new Date()) > 0 ? true : false;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return isEnable == 1 ? true : false;
    }

}
