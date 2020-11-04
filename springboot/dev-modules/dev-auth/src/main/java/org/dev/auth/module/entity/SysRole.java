package org.dev.auth.module.entity;

import lombok.Data;
import lombok.experimental.Accessors;
import org.dev.common.core.entity.TenantEntity;
import org.springframework.security.core.GrantedAuthority;

/**
 * <p>
 * 权限管理-角色管理
 * </p>
 *
 * @author hlt
 * @since 2020-06-24
 */
@Data
@Accessors(chain = true)
public class SysRole extends TenantEntity implements  GrantedAuthority {

    private static final long serialVersionUID = 1L;

    /**
     * COLUMN_COMMENT
     */
    private Long id;
    /**
     * 角色名称
     */
    private String roleName;
    /**
     * 角色等级
     */
    private Integer roleLevel;
    /**
     * 角色代码
     */
    private String roleCode;


    @Override
    public String getAuthority() {
        return roleCode;
    }
}
