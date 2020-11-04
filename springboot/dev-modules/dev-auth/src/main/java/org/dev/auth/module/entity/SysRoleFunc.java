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
public class SysRoleFunc extends TenantEntity {

    private static final long serialVersionUID = 1L;

    private Long id;
    /**
     * 权限id
     */
    private Long roleId;
    /**
     * 方法ID
     */
    private Long funcId;




}
