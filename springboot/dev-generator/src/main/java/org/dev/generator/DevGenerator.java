package org.dev.generator;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import org.dev.common.core.entity.TenantEntity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * <p>
 * 自动生成代码
 * </p>
 */
public class DevGenerator {

    public static void main(String[] args) {
        generateCode();
    }

    public static void generateCode() {
        String packageName = "org.dev.basic";
        boolean serviceNameStartWithI = false;//user -> UserService, 设置成true: user -> IUserService
        generateByTables(serviceNameStartWithI, packageName, "sys_email");
    }

    private static void generateByTables(boolean serviceNameStartWithI, String packageName, String... tableNames) {
        GlobalConfig config = new GlobalConfig();
        String dbUrl = "jdbc:mysql://127.0.0.1:3306/springboot_vue?autoReconnect=true&useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&zeroDateTimeBehavior=convertToNull&useSSL=false&nullCatalogMeansCurrent=true";
        DataSourceConfig dataSourceConfig = new DataSourceConfig();
        dataSourceConfig.setDbType(DbType.MYSQL)
                .setUrl(dbUrl)
                .setUsername("root")
                .setPassword("root")
                .setDriverName("com.mysql.cj.jdbc.Driver");
        StrategyConfig strategyConfig = new StrategyConfig();
        strategyConfig
                .setSuperEntityClass(TenantEntity.class)//自定义实体父类
                .setSuperEntityColumns("tenant_id", "is_del", "create_time", "create_by", "update_time", "update_by", "memo")
                .setLogicDeleteFieldName("is_del")
                .setCapitalMode(true)
                .setEntityLombokModel(true) // 【实体】是否为lombok模型（默认 false)
                //.setDbColumnUnderline(true)
                .setNaming(NamingStrategy.underline_to_camel)
                .setRestControllerStyle(true)//设置RestController
                .setInclude(tableNames);//修改替换成你需要的表名，多个表名传数组
        config.setActiveRecord(false)
                .setAuthor("dean.x.liu")
                .setOutputDir("F://MpGenerator")
                .setFileOverride(true);
        if (!serviceNameStartWithI) {
            config.setServiceName("%sService");
        }
        //注入自定义配置，可以在 VM 中使用 cfg.abc 【可无】
        InjectionConfig cfg = new InjectionConfig() {
            @Override
            public void initMap() {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("abc", this.getConfig().getGlobalConfig().getAuthor() + "-rb");
                this.setMap(map);
            }
        };
        List<FileOutConfig> focList = new ArrayList<FileOutConfig>();

        // 调整 controller 生成目录演示
        focList.add(new FileOutConfig("/templates/controller.java.vm") {
            @Override
            public String outputFile(TableInfo tableInfo) {
                //输出的位置
                String path = packageName.replace(".", "/");
                return config.getOutputDir() + "/" + path +"/controller/"+ tableInfo.getEntityName() + "Controller.java";
            }
        });
        cfg.setFileOutConfigList(focList);
        new AutoGenerator().setGlobalConfig(config)
                .setCfg(cfg)
                .setDataSource(dataSourceConfig)
                .setStrategy(strategyConfig)
                .setPackageInfo(
                        new PackageConfig()
                                .setParent(packageName)
                                .setController("controller")
                                .setEntity("entity")
                ).execute();
    }

    private void generateByTables(String packageName, String... tableNames) {
        generateByTables(true, packageName, tableNames);
    }
}