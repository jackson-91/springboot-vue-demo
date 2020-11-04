package org.dev.basic.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dev.common.core.entity.TenantEntity;

/**
 * <p>
 * 上传文件
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-07-18
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysUpload extends TenantEntity {

    private static final long serialVersionUID=1L;

    private Long id;

    /**
     * 名称
     */
    private String name;

    /**
     * 地址
     */
    private String url;

    /**
     * 排序
     */
    private Integer sort;


}
