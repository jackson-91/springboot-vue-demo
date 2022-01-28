package org.dev.basic.controller;

import org.dev.basic.service.SysEmailService;
import org.dev.basic.entity.SysEmail;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.dev.common.core.page.PaginAtion;
import org.dev.common.core.result.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.dev.common.core.aop.OperLog;

import javax.mail.internet.MimeMessage;
import java.util.List;

@RestController
@RequestMapping("/sysEmail")
public class SysEmailController {
    @Autowired
    public SysEmailService sysEmailService;

    @Autowired
    JavaMailSender javaMailSender;

    /**
     * 保存和修改公用的
     *
     * @param sysEmail 传递的实体
     * @return ResponseResult转换结果
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @OperLog(description = "sysEmail保存和修改")
    public ResponseResult<String> save(@RequestBody SysEmail sysEmail) {
        boolean result = false;
        try {
            if (sysEmail.getId() != null) {
                result = sysEmailService.updateById(sysEmail);
            } else {
                result = sysEmailService.save(sysEmail);
            }
        } catch (Exception e) {
            e.printStackTrace();
            result = false;
        }
        if (result)
            return ResponseResult.success();
        return ResponseResult.error();
    }

    /**
     * 获取对象信息
     *
     * @param id
     * @return
     */
    @GetMapping("/get")
    @OperLog(description = "sysEmail获取对象信息")
    public ResponseResult<SysEmail> get(@RequestParam("id") Long id) {
        SysEmail sysEmail = sysEmailService.getById(id);
        return ResponseResult.success(sysEmail);
    }

    /**
     * 删除对象信息
     *
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @OperLog(description = "sysEmail删除对象信息")
    public ResponseResult<String> delete(@RequestBody List<Long> ids) {
        try {
            sysEmailService.removeByIds(ids);
            return ResponseResult.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.error("删除对象失败！" + e.getMessage());
        }
    }

    /**
     * 分页查询数据信息
     *
     * @param ids
     * @param sysEmail
     * @return
     */
    @RequestMapping("/list")
    @OperLog(description = "sysEmail分页查询数据信息")
    public ResponseResult<IPage<SysEmail>> list(SysEmail sysEmail, PaginAtion pagination) {
        Page page = pagination.getPage();
        return ResponseResult.success(sysEmailService.page(page, new QueryWrapper<SysEmail>(sysEmail)));
    }


    /**
     * 测试发送邮件
     *
     * @param ids
     * @return
     */
    @PostMapping("/test")
    @OperLog(description = "测试发送邮件")
    public ResponseResult<String> test(@RequestBody String[] ids) {
        try {
            SysEmail sysEmail = sysEmailService.getOne(new QueryWrapper<>());
            MimeMessage message = javaMailSender.createMimeMessage();

            MimeMessageHelper helper = new MimeMessageHelper(message);

            helper.setFrom(sysEmail.getSmtpEmail());

            helper.setSubject("你好");

            helper.setTo(ids);


            helper.setText("<a href='http://www.baidu.com'>Thank you for ordering!</a>", true);

            javaMailSender.send(message);
            return ResponseResult.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.error("发送失败！" + e.getMessage());
        }
    }
}