package org.dev.basic.entity;

import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDateTime;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dev.common.core.entity.TenantEntity;

/**
 * <p>
 *
 * </p>
 *
 * @author dean.x.liu
 * @since 2020-08-02
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysEmploye extends TenantEntity {

    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 工号
     */
    private String workNo;

    /**
     * 姓名
     */
    private String name;

    /**
     * 英文名
     */
    private String foreignName;

    /**
     * 性别
     */
    private String gender;

    /**
     * 手机号
     */
    private String mobilePhone;

    /**
     * 座机号码
     */
    private String telephone;

    /**
     * 学历
     */
    private String education;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 生日
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDateTime birthday;

    /**
     * 所属部门
     */
    // private String department;

    /**
     * 部门代码
     */
    private String deptId;

    /**
     * 部门代码
     */
    private String deptCode;

    /**
     * 部门名称
     */
    private String deptName;


    /**
     * 职位
     */
    private String position;

    /**
     * 状态 离职 试用期 在职
     */
    private String status;

    /**
     * 入职日期
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDateTime entryDate;

    /**
     * 离职日期
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @TableField(updateStrategy = FieldStrategy.IGNORED)
    private LocalDateTime departureDate;


}
