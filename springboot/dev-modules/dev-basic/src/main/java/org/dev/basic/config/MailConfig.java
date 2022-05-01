package org.dev.basic.config;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.dev.basic.entity.SysEmail;
import org.dev.basic.service.SysEmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;


/**
 * 加载邮件服务器配置
 */
@Configuration
public class MailConfig {

    @Autowired
    SysEmailService sysEmailService;

    @Bean(name = "javaMailSender")
    public JavaMailSenderImpl javaMailSender() {
        SysEmail sysEmail = sysEmailService.getOne(new QueryWrapper<>());
        if (sysEmail != null) {
            // 默认配置相关
            JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
            javaMailSender.setHost(sysEmail.getSmtpServer());
            javaMailSender.setPort(Integer.valueOf(sysEmail.getSmtpPort()));
            javaMailSender.setUsername(sysEmail.getSmtpUsername());
            javaMailSender.setPassword(sysEmail.getSmtpPassword());
            // 认证相关
            Properties properties = new Properties();
            properties.setProperty("mail.host", sysEmail.getSmtpServer());
            properties.setProperty("mail.transport.protocol", "smtp");
            properties.setProperty("mail.smtp.auth", "true");
            properties.setProperty("mail.smtp.port", String.valueOf(sysEmail.getSmtpPort()));
            properties.setProperty("mail.smtp.socketFactory.port", String.valueOf(sysEmail.getSmtpPort()));
            properties.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            javaMailSender.setJavaMailProperties(properties);
            return javaMailSender;
        } else {
            return null;
        }
    }
}

