package org.dev.common.core.aop;

import com.alibaba.druid.util.StringUtils;
import io.swagger.models.HttpMethod;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.dev.common.exception.PreviewException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;


/**
 * 演示环境拦截器
 */
@Slf4j
@Aspect
@Component
public class PreviewAspect {

    @Value("${springboot_vue.isPreview}")
    private boolean isPreview = false;

    /**
     * 对controller中返回结果未ResponseResult的方法进行拦截，如果方法是POST PUT DELETE请求类型
     * 并且配置环境是演示环境，则不允许进行操作
     *
     * @param point
     * @return
     * @throws Throwable
     */
    @Around(
            "execution(static org.dev.common.core.result.ResponseResult *(..)) || " +
                    "(@within(org.springframework.stereotype.Controller) || " +
                    "@within(org.springframework.web.bind.annotation.RestController))"
    )
    public Object aroundApi(ProceedingJoinPoint point) throws Throwable {
        //　获取request
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        log.error("进入演示环境拦截器－－－－－－－－－－－－－－－");
        if ((StringUtils.equalsIgnoreCase(request.getMethod(), HttpMethod.POST.name()) ||
                StringUtils.equalsIgnoreCase(request.getMethod(), HttpMethod.DELETE.name())
                || StringUtils.equalsIgnoreCase(request.getMethod(), HttpMethod.PUT.name())) && isPreview) {
            log.error("演示环境不能操作！");
            throw new PreviewException("演示环境不能操作！");
        }
        return point.proceed();
    }
}