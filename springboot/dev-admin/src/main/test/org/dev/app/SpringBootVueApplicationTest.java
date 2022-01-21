package org.dev.app;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.dev.util.service.SysLogService;
import org.dev.util.entity.SysLog;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;


@ExtendWith(SpringExtension.class)
@SpringBootTest
public class SpringBootVueApplicationTest {
    @Autowired
    SysLogService sysLogService;

    @Test
    public void test() {
        List<SysLog> sysLogs = sysLogService.list();
    }
}