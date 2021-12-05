package org.dev.common.kaptcha;

import org.apache.commons.lang3.StringUtils;
import org.dev.common.exception.ValidateCodeException;
import org.dev.common.security.handler.MyAuthenticationFailureHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class VerifyCodeFilter extends OncePerRequestFilter {

    @Bean
    public VerifyCodeFilter getVerifyCodeFilter() {
        return new VerifyCodeFilter();
    }

    @Autowired
    MyAuthenticationFailureHandler myAuthenticationFailureHandler;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        if (StringUtils.equals("/login", request.getRequestURI())
                && StringUtils.equalsIgnoreCase(request.getMethod(), "post")) {
            // 1. 进行验证码的校验
            try {
                String requestCaptcha = request.getParameter("verifyCode");
                if (requestCaptcha == null) {
                    throw new ValidateCodeException("验证码不存在");
                }
                String code = (String) request.getSession().getAttribute("yanzhengma");
                if (StringUtils.isBlank(code)) {
                    throw new ValidateCodeException("验证码过期！");
                }
                code = code.equals("0.0") ? "0" : code;
                logger.info("开始校验验证码，生成的验证码为：" + code + " ，输入的验证码为：" + requestCaptcha);
                if (!StringUtils.equals(code, requestCaptcha)) {
                    throw new ValidateCodeException("验证码不匹配");
                }
            } catch (AuthenticationException e) {
                // 2. 捕获步骤1中校验出现异常，交给失败处理类进行进行处理
                myAuthenticationFailureHandler.onAuthenticationFailure(request, response, e);
            } finally {
                filterChain.doFilter(request, response);
            }
        } else {
            filterChain.doFilter(request, response);
        }
    }

}