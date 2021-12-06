package org.dev.common.exception;

import org.springframework.security.core.AuthenticationException;

/**
 * 验证码验证失败错误
 */
public class ValidateCodeException extends AuthenticationException {

    public ValidateCodeException(String msg) {
        super(msg);
    }
}