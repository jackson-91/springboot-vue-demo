package org.dev.basic.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dev.common.core.entity.TenantEntity;

import java.util.List;

/**
 * <p>
 * 部门表
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-10-24
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysDept extends TenantEntity {

    private static final long serialVersionUID=1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 部门代码
     */
    private String deptCode;

    /**
     * 部门名称
     */
    private String deptName;

    /**
     * 部门描述
     */
    private String deptDesc;

    /**
     * 父级部门
     */
    private Long parentId;

    /**
     * 部门负责人
     */
    private Long deptHeader;

    /**
     * 负责人行明
     */
    private String deptHeaderJobscode;

    /**
     * 负责人职务
     */
    private Long deptHeaderJobs;

    /**
     * 负责人职务名称
     */
    private String deptHeaderJobsname;

    /**
     * 部门电话
     */
    private String deptPhone;

    @TableField(exist = false)
    private List<SysDept> children;
//    @TableField(exist = false)
//    private boolean hasChildren;
}
