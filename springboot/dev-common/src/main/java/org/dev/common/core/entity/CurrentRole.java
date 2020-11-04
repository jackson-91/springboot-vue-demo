package org.dev.common.core.entity;

import lombok.Data;
import org.springframework.security.core.GrantedAuthority;


@Data
public class CurrentRole implements GrantedAuthority {

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
    private String memo;

    @Override
    public String getAuthority() {
        return roleCode;
    }
}
