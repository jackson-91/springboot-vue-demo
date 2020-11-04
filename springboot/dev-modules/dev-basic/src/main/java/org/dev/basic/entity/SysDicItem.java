package org.dev.basic.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dev.common.core.entity.TenantEntity;

/**
 * <p>
 * 数据库字典组-子级
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-07-05
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysDicItem extends TenantEntity {

    private static final long serialVersionUID=1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 数据字典id
     */
    private Long dicId;

    /**
     * 编码
     */
    private String dicItemCode;

    /**
     * 值
     */
    private String dicItemValue;

    /**
     * 名称
     */
    private String dicItemName;

    /**
     * 描述
     */
    private String description;


}
