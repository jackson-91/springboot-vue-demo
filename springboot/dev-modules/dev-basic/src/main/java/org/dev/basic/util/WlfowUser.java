package org.dev.basic.util;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.dev.auth.module.entity.SysUser;
import org.dev.auth.module.service.SysUserService;
import org.dev.basic.entity.SysDept;
import org.dev.basic.entity.SysEmploye;
import org.dev.basic.entity.SysJobs;
import org.dev.basic.service.SysDeptService;
import org.dev.basic.service.SysEmployeService;
import org.dev.basic.service.SysJobsService;
import org.dev.common.core.entity.CurrentUser;
import org.dev.common.exception.CustomException;
import org.dev.common.utils.SpringSecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.convert.EntityWriter;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.stream.Collectors;

@Component
public class WlfowUser {

    @Autowired
    SysEmployeService sysEmployeService;

    @Autowired
    SysDeptService sysDeptService;

    @Autowired
    SysJobsService jobsService;

    @Autowired
    SysUserService sysUserService;

    /**
     * @return
     */
    public Map<String, Object> SignedPersonnel() throws CustomException {
        CurrentUser currentUser = SpringSecurityUtils.CurrentUser();
        SysUser sysUser1 = this.sysUserService.getById(currentUser.getId());
        Long employeId = sysUser1.getEmployeId();
        // 获取绑定员工共
        SysEmploye sysEmploye = this.sysEmployeService.getById(employeId);
        if (sysEmploye == null) {
            throw new CustomException("找不到员工信息,无法启动流程");
        }

        List<SysDept> sysDepts = new ArrayList<>();
        // 获取所属部门
        SysDept sysDept = this.sysDeptService.getById(sysEmploye.getDeptId());
        sysDepts.add(sysDept);
        // 获取关联的所有部门
        deptTree(sysDept, sysDepts);
        //
        deptCTree(sysDept, sysDepts);
        //
        // sysDepts=sysDepts.stream().map(SysDept::getDeptHeaderJobs);
        // 获取关联的职务
        List<Long> jobIdArray = sysDepts.stream().map(SysDept::getDeptHeaderJobs).distinct().collect(Collectors.toList());
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.in("id", jobIdArray);
        List<SysJobs> sysJobsList = this.jobsService.list(queryWrapper);
        // 获取关联的员工

        List<Long> deptIdArray = sysDepts.stream().map(SysDept::getId).distinct().collect(Collectors.toList());
        List<String> jobCodes = sysDepts.stream().map(SysDept::getDeptHeaderJobscode).distinct().collect(Collectors.toList());
        queryWrapper = new QueryWrapper();
        queryWrapper.in("dept_id", deptIdArray);
        queryWrapper.in("position", jobCodes);
        List<SysEmploye> sysEmployeList = this.sysEmployeService.list(queryWrapper);
        //获取关联的用户
        List<Long> employeIdArray = sysEmployeList.stream().map(SysEmploye::getId).distinct().collect(Collectors.toList());
        queryWrapper = new QueryWrapper();
        queryWrapper.in("employe_id", employeIdArray);
        List<SysUser> sysUserList = this.sysUserService.list(queryWrapper);
        //
        Map<String, Object> map = new HashMap<>();
        for (SysUser sysUser : sysUserList) {
            for (SysEmploye sysEmploye1 : sysEmployeList) {
                if (sysEmploye1.getId().equals(sysUser.getEmployeId())) {
                    if (map.containsKey(sysEmploye1.getPosition())) {
                        //throw new CustomException;
                    }
                    map.put(sysEmploye1.getPosition(), sysUser.getId());
                    break;
                }
            }
        }
        return map;
    }


//    /**
//     * 根据职位代码查找签核人
//     *
//     * @param JobCode
//     * @return
//     */
//    public Long SignedPersonnel(String JobCode) throws CustomException {
//        CurrentUser currentUser = SpringSecurityUtils.CurrentUser();
//        SysUser sysUser1 = this.sysUserService.getById(currentUser.getId());
//        Long employeId = sysUser1.getEmployeId();
//        // 获取绑定员工共
//        SysEmploye sysEmploye = this.sysEmployeService.getById(employeId);
//        if (sysEmploye == null) {
//            throw new CustomException("找不到员工信息,无法启动流程");
//        }
//
//        List<SysDept> sysDepts = new ArrayList<>();
//        // 获取所属部门
//        SysDept sysDept = this.sysDeptService.getById(sysEmploye.getDeptId());
//        sysDepts.add(sysDept);
//        // 获取关联的所有部门
//        deptTree(sysDept, sysDepts);
//        //
//        deptCTree(sysDept, sysDepts);
//    }

    /**
     * @param sysDept
     * @param sysDepts
     */
    public void deptTree(SysDept sysDept, List<SysDept> sysDepts) {

        SysDept sysDeptP = this.sysDeptService.getById(sysDept.getParentId());
        if (sysDeptP != null) {
            return;
        }
        sysDepts.add(sysDeptP);
        deptTree(sysDeptP, sysDepts);
    }

    /**
     * @param sysDept
     * @param sysDepts
     */
    public void deptCTree(SysDept sysDept, List<SysDept> sysDepts) {

        SysDept sysDeptWrpper = new SysDept();
        sysDeptWrpper.setParentId(sysDept.getId());
        QueryWrapper queryWrapper = new QueryWrapper(sysDeptWrpper);
        List<SysDept> sysDepts1 = this.sysDeptService.list(queryWrapper);
        if (sysDepts1 != null && sysDepts1.size() > 0) {
            for (SysDept sysDept1 : sysDepts1) {
                sysDepts.add(sysDept1);
                deptCTree(sysDept1, sysDepts);
            }
        }
        return;
    }

}
