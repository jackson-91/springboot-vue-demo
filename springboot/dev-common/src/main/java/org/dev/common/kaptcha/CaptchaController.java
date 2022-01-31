package org.dev.common.kaptcha;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.dev.common.core.result.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;

@Controller
@Api(value = "验证码")
@RequestMapping("/captcha")
@Slf4j
public class CaptchaController {

    @Autowired
    private Producer captchaProducer;

    @Autowired
    private Producer captchaProducerMath;

    @Value("${springbootvue.verifyCode}")
    private boolean verifyFlag = true;

    /**
     * 验证码生成
     *
     * @param request
     * @param response
     * @return
     */
    @GetMapping(value = "/verifyCode")
    public ModelAndView verifyCode(HttpServletRequest request, HttpServletResponse response) {
        ServletOutputStream out = null;
        try {
            HttpSession session = request.getSession();
            response.setDateHeader("Expires", 0);
            response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
            response.addHeader("Cache-Control", "post-check=0, pre-check=0");
            response.setHeader("Pragma", "no-cache");
            response.setContentType("image/jpeg");

            String type = request.getParameter("type");
            String capStr = null;
            String code = null;
            BufferedImage bi = null;
            if ("math".equals(type)) {//验证码为算数 8*9 类型
                String capText = captchaProducerMath.createText();
                capStr = capText.substring(0, capText.lastIndexOf("@"));
                code = capText.substring(capText.lastIndexOf("@") + 1);
                bi = captchaProducerMath.createImage(capStr);
            } else if ("char".equals(type)) {//验证码为 abcd类型
                capStr = code = captchaProducer.createText();
                bi = captchaProducer.createImage(capStr);
            }
            session.setAttribute(Constants.KAPTCHA_SESSION_KEY, code);
            request.getServletContext().setAttribute(Constants.KAPTCHA_SESSION_KEY, code);
            log.info("----SESSIONID" + session.getId());
            out = response.getOutputStream();
            ImageIO.write(bi, "jpg", out);
            System.out.println("bi = " + bi);
            System.out.println("out =" + out);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    /**
     * 获取是否开启验证码
     *
     * @return
     */
    @GetMapping(value = "/verifyCodeFlag")
    @ResponseBody
    public ResponseResult<Boolean> verifyCodeFlag() {
        return ResponseResult.success(verifyFlag);
    }
}