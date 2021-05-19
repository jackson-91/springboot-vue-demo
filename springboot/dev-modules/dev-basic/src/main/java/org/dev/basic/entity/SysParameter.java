package org.dev.basic.entity;

import org.dev.common.core.entity.TenantEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 系统参数
 * </p>
 *
 * @author dean.x.liu
 * @since 2021-05-19
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysParameter extends TenantEntity {

    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 参数代码
     */
    private String pCode;

    /**
     * 参数名称
     */
    private String pName;

    /**
     * 参数描述
     */
    private String pDesc;

    /**
     * 参数值
     */
    private String pValue;

    /**
     * 参数值1
     */
    private String pValue1;

    /**
     * 参数值2
     */
    private String pValue2;


}
