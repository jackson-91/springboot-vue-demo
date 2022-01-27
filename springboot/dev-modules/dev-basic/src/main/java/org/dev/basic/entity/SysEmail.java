package org.dev.basic.entity;

import org.dev.common.core.entity.TenantEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 
 * </p>
 *
 * @author dean.x.liu
 * @since 2022-01-27
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysEmail extends TenantEntity {

    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 邮件服务器
     */
    private String smtpServer;

    /**
     * 邮件服务器端口
     */
    private String smtpPort;

    /**
     * 邮件账号
     */
    private String smtpUsername;

    /**
     * 邮件服务器密码
     */
    private String smtpPassword;


}
