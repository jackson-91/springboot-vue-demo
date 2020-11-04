package org.dev.auth.module.entity;


import lombok.Data;
import lombok.experimental.Accessors;
import org.dev.common.core.entity.TenantEntity;

/**
 * <p>
 * 
 * </p>
 *
 * @author hlt
 * @since 2020-06-24
 */
@Data
@Accessors(chain = true)
public class SysRoleMenu extends TenantEntity {

    private static final long serialVersionUID = 1L;

    private Long id;
    /**
     * 权限id
     */
    private Long roleId;
    /**
     * 菜单ID
     */
    private Long menuId;



}
