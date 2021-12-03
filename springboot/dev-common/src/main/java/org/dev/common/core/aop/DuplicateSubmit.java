package org.dev.common.core.aop;

import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@Documented
public @interface DuplicateSubmit {
    /**
     * 锁过期的时间
     */
    int seconds() default 5;

    /**
     * 锁的位置
     */
    String location() default "DuplicateSubmit";

    /**
     * 要扫描的参数位置
     */
    int argIndex() default 0;

    /**
     * 参数名称
     */
    String name() default "";

    //保存重复提交标记 默认为需要保存
    boolean save() default true;
}
