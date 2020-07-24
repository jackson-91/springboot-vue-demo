package org.lqx.framework.modules.sys.entity;


import lombok.Data;
import lombok.experimental.Accessors;
import org.lqx.framework.core.entity.TenantEntity;

/**
 * <p>
 * 角色用户关系表
 * </p>
 *
 * @author hlt
 * @since 2020-06-24
 */
@Data
@Accessors(chain = true)
public class SysRoleUser extends TenantEntity {

    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private Long roleId;



}
