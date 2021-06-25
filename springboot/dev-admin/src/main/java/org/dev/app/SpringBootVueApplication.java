package org.dev.app;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
//import serilogj.Log;
//import serilogj.LoggerConfiguration;
//
//import static serilogj.sinks.coloredconsole.ColoredConsoleSinkConfigurator.*;
//import static serilogj.sinks.rollingfile.RollingFileSinkConfigurator.*;
//import static serilogj.sinks.seq.SeqSinkConfigurator.*;

@SpringBootApplication

@MapperScan("org.dev.**.mapper.**")
@EnableAspectJAutoProxy(proxyTargetClass = true)
@EnableAutoConfiguration
@ComponentScan(basePackages = "org.dev.**")
public class SpringBootVueApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringBootVueApplication.class, args);
        //Log.setLogger(new LoggerConfiguration()
        //        .writeTo(seq("http://114.67.109.212:5341"))
        //        .createLogger());
        //for (int i = 0; i < 10; i++) {
        //    Log.information("Hello from {lang}!index={index}", "Java", i);
        //    Log.debug("Hello from {lang}!index={index}", "Java", i);
        //    Log.warning("Hello from {lang}!index={index}", "Java", i);
        //    Log.error("Hello from {lang}!index={index}", "Java", i);
        //    Log.debug("Hello from {lang}!index={index}", "Java", i);
        //}
    }
}