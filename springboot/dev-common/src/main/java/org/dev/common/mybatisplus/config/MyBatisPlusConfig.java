package org.dev.common.mybatisplus.config;


import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.core.parser.ISqlParser;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.TenantLineInnerInterceptor;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.LongValue;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.util.ArrayList;
import java.util.List;

/**
 * @Auther: IT贱男
 * @Date: 2019/6/12 15:06
 * @Description: MybatisPlus分页配置类
 */
@EnableTransactionManagement
@Configuration
public class MyBatisPlusConfig {

    /**
     * 分页插件
     *
     * @return
     */
    //@Bean
    //public PaginationInterceptor paginationInterceptor() {
    //    PaginationInterceptor paginationInterceptor = new PaginationInterceptor();
    //    // 设置请求的页面大于最大页后操作， true调回到首页，false 继续请求  默认false
    //    // paginationInterceptor.setOverflow(false);
    //    // 设置最大单页限制数量，默认 500 条，-1 不受限制
    //    // paginationInterceptor.setLimit(500);
    //    return paginationInterceptor;
    //}

    // 最新版
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        //多租户插件
        //interceptor.addInnerInterceptor(new TenantLineInnerInterceptor(new TenantLineHandler() {
        //    @Override
        //    public Expression getTenantId() {
        //        return new LongValue(1L);
        //    }
        //}));
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL));

        return interceptor;
    }


}