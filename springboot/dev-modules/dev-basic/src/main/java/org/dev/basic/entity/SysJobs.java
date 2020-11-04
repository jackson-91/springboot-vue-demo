package org.dev.basic.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dev.common.core.entity.TenantEntity;

/**
 * <p>
 * 岗位管理
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-10-22
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysJobs extends TenantEntity {

    private static final long serialVersionUID=1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 岗位代码
     */
    private String code;

    /**
     * 岗位名称
     */
    private String name;

    /**
     * 职务等级
     */
    private Integer level;

    /**
     * 是否有效 1 有效 0 无效
     */
    private String isActive;


}
