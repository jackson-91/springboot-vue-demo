package org.dev.util.entity;


import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dev.common.core.entity.TenantEntity;

/**
 * <p>
 * 生成的队列号
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-07-20
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysSequenceLog extends TenantEntity {

    private static final long serialVersionUID=1L;

    private Long id;

    /**
     * 序列号ID
     */
    private Long sequenceId;

    /**
     * 自定义前缀
     */
    private String prefix;

    /**
     * 流水编码
     */
    private String flowCode;


}
