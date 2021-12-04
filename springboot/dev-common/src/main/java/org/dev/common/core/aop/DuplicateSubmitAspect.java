package org.dev.common.core.aop;

import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.dev.common.core.result.ResponseResult;
import org.dev.common.exception.DuplicateSubmitException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * 重复请求检测切面类
 */
@Slf4j
@Component
@Aspect
public class DuplicateSubmitAspect {
    @Autowired
    RedisTemplate<String, String> redisTemplate;

    @Around("execution(public * org.dev..*.controller..*(..)) && @annotation(nrs)")
    public Object arround(ProceedingJoinPoint pjp, DuplicateSubmit nrs) {
        ValueOperations<String, String> opsForValue = redisTemplate.opsForValue();
        try {
            ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            String sessionId = RequestContextHolder.getRequestAttributes().getSessionId();
            HttpServletRequest request = attributes.getRequest();
            String token = request.getHeader("Authorization");
            sessionId = StringUtils.isNotEmpty(token) ? token : sessionId;
            Map<String, String> parmsMap = this.getAllRequestParam(request);
            String parms = JSON.toJSONString(parmsMap);
            String key = sessionId + "-" + request.getServletPath() + parms;
            String url = request.getServletPath();
            if (opsForValue.get(key) == null) {// 如果缓存中有这个url和请求参数
                Object o = pjp.proceed();
                //保存五秒钟
                opsForValue.set(key, "0", 5, TimeUnit.SECONDS);
                return o;
            } else {
                log.error("重复提交");
                ResponseResult<String> responseResult = ResponseResult.error("请勿重复提交");
                responseResult = ResponseResult.error("操作过于频繁");
                return responseResult;
            }
        } catch (Throwable e) {
            e.printStackTrace();
            log.error("验证重复提交时出现未知异常!");
            ResponseResult<String> responseResult = ResponseResult.error("验证重复提交时出现未知异常");
            return responseResult;
        }
    }

    /**
     * 获取HTTP请求中所有的参数信息
     *
     * @param request
     * @return
     */
    private Map<String, String> getAllRequestParam(final HttpServletRequest request) {
        Map<String, String> res = new HashMap<String, String>();
        Enumeration<?> temp = request.getParameterNames();
        if (null != temp) {
            while (temp.hasMoreElements()) {
                String en = (String) temp.nextElement();
                String value = request.getParameter(en);
                res.put(en, value);
                //如果字段的值为空，判断若值为空，则删除这个字段>
                if (null == res.get(en) || "".equals(res.get(en))) {
                    res.remove(en);
                }
            }
        }
        return res;
    }

}
