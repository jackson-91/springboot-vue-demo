package org.dev.common.security.handler;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.dev.common.core.entity.CurrentUser;
import org.dev.common.core.result.ResponseResult;
import org.dev.common.security.jwt.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/***
 * 认证成功处理类
 */
@Component
@Slf4j
public class MyAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
    @Autowired
    JwtTokenUtil jwtTokenUtils;

    @Autowired
    RedisTemplate<String, String> redisTemplate;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest httpServletRequest,
                                        HttpServletResponse httpServletResponse,
                                        Authentication authentication)
            throws IOException, ServletException {
        // 所以就是JwtUser啦
        CurrentUser jwtUser = (CurrentUser) authentication.getPrincipal();
        log.info("jwtUser:" + jwtUser.toString());
        //生成token
        String token = jwtTokenUtils.generateToken(jwtUser);
        //token 放入redis中
        redisTemplate.opsForHash().put(token, jwtUser.getLoginName(), token);
        //设置响应的数据类型
        httpServletResponse.setContentType("application/json;charset=utf-8");
        //拿到witer
        PrintWriter out = httpServletResponse.getWriter();
        ResponseResult<String> responseResult = ResponseResult.success(token);
        out.write(new ObjectMapper().writeValueAsString(responseResult));
        out.flush();
        out.close();
    }
}
