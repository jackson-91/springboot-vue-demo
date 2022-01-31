package org.dev.workflow.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.extern.slf4j.Slf4j;
import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.*;
import org.activiti.bpmn.model.Process;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.image.ProcessDiagramGenerator;
import org.activiti.image.impl.DefaultProcessDiagramGenerator;
import org.dev.basic.util.WlfowUser;
import org.dev.common.core.page.PaginAtion;
import org.dev.common.core.result.ResponseResult;
import org.dev.common.exception.CustomException;
import org.dev.common.security.jwt.JwtUtil;
import org.dev.util.util.SequenceUtil;
import org.dev.workflow.entity.*;
import org.dev.workflow.util.AssigneeType;
import org.dev.workflow.util.AttributeName;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.parameters.P;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamReader;
import java.io.*;
import java.util.*;


@RestController
@RequestMapping("wflowDefine")
@Slf4j
public class WflowDefineController {
    @Value("${springbootvue.upload.local-upload-path}")
    private String upload_path;

    @Autowired
    SequenceUtil sequenceUtil;


    @Autowired
    WlfowUser wlfowUser;

    /**
     * 流程定义查询
     *
     * @param wflowDefine
     * @param pagination
     * @return
     */
    @GetMapping("/list")
    public ResponseResult<IPage<ProcessDefinition>> list(WflowDefine wflowDefine, PaginAtion pagination) {
        IPage page = pagination.getPage();
        int firstResult = (pagination.getCurrent() - 1) * pagination.getSize();
        int maxResults = pagination.getCurrent() * pagination.getSize();
        //查询集合
        List<ProcessDefinition> list = ProcessEngines.getDefaultProcessEngine().getRepositoryService()//与流程定义和部署对象相关的Service
                .createProcessDefinitionQuery()//创建一个流程定义查询
                /*指定查询条件,where条件*/
                //.deploymentId(deploymentId)//使用部署对象ID查询
                //.processDefinitionId(processDefinitionId)//使用流程定义ID查询
                //.processDefinitionName("请假流程")//使用流程定义的KEY查询
                //.processDefinitionNameLike(processDefinitionNameLike)//使用流程定义的名称模糊查询
                /*排序*/
                .orderByProcessDefinitionVersion().asc()//按照版本的升序排列
                //.orderByProcessDefinitionName().desc()//按照流程定义的名称降序排列
                //.list();//返回一个集合列表，封装流程定义
                //.singleResult();//返回唯一结果集
                //.count();//返回结果集数量
                .latestVersion()//最新版本
                .listPage(firstResult, maxResults);//分页查询
        Long count = ProcessEngines.getDefaultProcessEngine().getRepositoryService()//与流程定义和部署对象相关的Service
                .createProcessDefinitionQuery().latestVersion()//创建一个流程定义查询
                /*指定查询条件,where条件*/
                //.deploymentId(deploymentId)//使用部署对象ID查询
                //.processDefinitionId(processDefinitionId)//使用流程定义ID查询
                //.processDefinitionKey(processDefinitionKey)//使用流程定义的KEY查询
                //.processDefinitionNameLike(processDefinitionNameLike)//使用流程定义的名称模糊查询
                .count();//返回结果集数量
        List<WflowDefine> wflowDefines = new ArrayList<>();
        if (list != null && list.size() > 0) {
            for (ProcessDefinition processDefinition1 : list) {
                wflowDefine = new WflowDefine();
                BeanUtils.copyProperties(processDefinition1, wflowDefine);
                wflowDefines.add(wflowDefine);
            }
        }
        page.setRecords(wflowDefines);
        page.setTotal(count);
        return ResponseResult.success(page);
    }

    /**
     * 删除流程定义
     *
     * @param deploymentIds
     * @return
     */
    @PostMapping("delete")
    @Transactional
    public ResponseResult delete(@RequestBody List<String> deploymentIds) {
        try {
            RepositoryService repositoryService = ProcessEngines.getDefaultProcessEngine().getRepositoryService();
            for (String deploymentId : deploymentIds) {
                repositoryService.deleteDeployment(deploymentId, true);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.error();
        }
        return ResponseResult.success();
    }

    /**
     * 导出流程
     *
     * @param processInstanceId
     * @return
     */
    @GetMapping("export")
    public void export(@RequestParam("definitionId") String processInstanceId, HttpServletResponse response) {
        BufferedOutputStream bos = null;
        try {

            try {
                RepositoryService repositoryService = ProcessEngines.getDefaultProcessEngine().getRepositoryService();
                //
                ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(processInstanceId).singleResult();
                InputStream inputStream = repositoryService
                        .getProcessModel(processInstanceId);
                ByteArrayOutputStream swapStream = new ByteArrayOutputStream();
                byte[] bpmnBytes = new byte[1024]; //buff用于存放循环读取的临时数据
                int rc = 0;
                while ((rc = inputStream.read(bpmnBytes, 0, 100)) > 0) {
                    swapStream.write(bpmnBytes, 0, rc);
                }
                byte[] in_b = swapStream.toByteArray(); //in_b为转换之后的结果
                log.info("------" + new String(in_b));
                // 封装输出流
                bos = new BufferedOutputStream(response.getOutputStream());
                bos.write(in_b);// 写入流

                String filename = processDefinition.getName() + ".bpmn";
                response.setContentType("application/x-msdownload;");
                response.setHeader("Content-Disposition",
                        "attachment; filename=" + filename);
                response.flushBuffer();

            } finally {
                bos.flush();
                bos.close();
            }

        } catch (Exception e) {
            System.out.println("导出文件失败");
            e.printStackTrace();
        }
    }

    /**
     * 获取流程定义的xml
     *
     * @param processInstanceId
     * @return
     */
    @GetMapping("bpmnXml")
    public ResponseResult bpmnXml(@RequestParam("definitionId") String processInstanceId) {
        RepositoryService repositoryService = ProcessEngines.getDefaultProcessEngine().getRepositoryService();

        //获取BpmnModel对象
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processInstanceId);
        //创建转换对象

        BpmnXMLConverter converter = new BpmnXMLConverter();
        //把bpmnModel对象转换成字符
        byte[] bytes = converter.convertToXML(bpmnModel);
        String xmlContenxt = new String(bytes);
        log.info(xmlContenxt);
        return ResponseResult.success(xmlContenxt);
    }

    /**
     * 部署流程
     * 根据文件部署
     *
     * @param wflowDefine
     * @return
     */
    @PostMapping("deploy")
    @Transactional
    public ResponseResult deploy(@RequestBody WflowDefine wflowDefine) {
        try {
            //获取文件流
            File fileBpmn = new File(upload_path + wflowDefine.getBpmnfile());
            InputStream BpmnInputStream = null;
            try {
                BpmnInputStream = new FileInputStream(fileBpmn);
            } catch (IOException e) {

            }

            if (StringUtils.isEmpty(wflowDefine.getBpmnfile())) {
                return ResponseResult.error("流程文件不存在,无法部署");
            }
            XMLInputFactory factory = XMLInputFactory.newFactory();
            XMLStreamReader streamReader = factory.createXMLStreamReader(BpmnInputStream);
            BpmnXMLConverter converter = new BpmnXMLConverter();
            BpmnModel bpmnModel = converter.convertToBpmnModel(streamReader);
            List<Process> processes = bpmnModel.getProcesses();
            if (processes != null && processes.size() != 1) {
                return ResponseResult.error("存在多个流程,无法部署");
            }
            Process process = processes.get(0);
            process.setName(wflowDefine.getName());
            process.setId(wflowDefine.getKey());
            process.setDocumentation(wflowDefine.getDescription());
            File fileSvg = new File(upload_path + wflowDefine.getBpmnfile());
            InputStream SvgInputStream = null;
            try {
                SvgInputStream = new FileInputStream(fileSvg);
            } catch (IOException e) {

            }
            //1.创建ProcessEngine对象
            ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();

            //2.得到RepositoryService实例
            RepositoryService repositoryService = processEngine.getRepositoryService();

            String resourceName = System.currentTimeMillis() + ".bpmn";
            //3.进行部署
            Deployment deployment = repositoryService.createDeployment()//创建Deployment对象
                    .name(wflowDefine.getName())
                    .key(wflowDefine.getKey())
                    .category(wflowDefine.getCategory())
                    .tenantId("000000")
                    .addBpmnModel(resourceName, bpmnModel)
                    //.addInputStream(fileBpmn.getName(), BpmnInputStream)//添加bpmn文件
                    //.addInputStream(fileSvg.getName(), SvgInputStream)//添加png文件
                    .deploy();//部署
            log.info("name---" + deployment.getName());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.error(e.getMessage());
        }
        return ResponseResult.success();
    }

    /**
     * 部署流程
     * 根据XML部署
     *
     * @param wflowDefine
     * @return
     */
    @PostMapping("deployByXML")
    @Transactional
    public ResponseResult deployByXML(@RequestBody WflowDefine wflowDefine) {


        try {
            //获取流程XML
            if (StringUtils.isEmpty(wflowDefine.getBpmnXML())) {
                return ResponseResult.error("流程节点为空,无法部署");
            }
            XMLInputFactory factory = XMLInputFactory.newFactory();
            Reader reader = new StringReader(wflowDefine.getBpmnXML());
            XMLStreamReader streamReader = factory.createXMLStreamReader(reader);
            BpmnXMLConverter converter = new BpmnXMLConverter();
            BpmnModel bpmnModel = converter.convertToBpmnModel(streamReader);
            List<Process> processes = bpmnModel.getProcesses();
            if (processes != null && processes.size() != 1) {
                return ResponseResult.error("存在多个流程,无法部署");
            }

            //1.创建ProcessEngine对象
            ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();

            //2.得到RepositoryService实例
            RepositoryService repositoryService = processEngine.getRepositoryService();
            //3.获取原先流程
            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(wflowDefine.getId()).singleResult();
            //
            Process process = processes.get(0);
            process.setName(processDefinition.getName());
            process.setId(processDefinition.getKey());
            process.setDocumentation(processDefinition.getDescription());
            //4.进行部署
            Deployment deployment = repositoryService.createDeployment()//创建Deployment对象
                    .name(wflowDefine.getName())
                    .key(wflowDefine.getKey())
                    .category(wflowDefine.getCategory())
                    .tenantId("000000")
                    .addBpmnModel(processDefinition.getResourceName(), bpmnModel)
                    .deploy();//部署
            log.info("name---" + deployment.getName());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.error(e.getMessage());
        }
        return ResponseResult.success();
    }


    /**
     * 启动流程
     *
     * @return
     */
    @GetMapping("/start-process-test")
    public ResponseResult startProcess(@RequestParam("definitionId") String processInstanceId,
                                       @RequestParam("processKey") String processKey) throws CustomException {
        String FlowNo = "";


        RepositoryService repositoryService = ProcessEngines.getDefaultProcessEngine().getRepositoryService();
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processInstanceId);
        //process中包含所有的节点信息,包括流程线
        Process process = bpmnModel.getProcessById(processKey);
        //获取第一个节点信息
        FlowElement startElement = process.getInitialFlowElement();
        Collection<FlowElement> flowElements = process.getFlowElements();
        //筛选流程中所有的UserTask任务节点
        for (FlowElement flowElement : flowElements) {
            if (flowElement instanceof UserTask) {
                UserTask userTask = ((UserTask) flowElement);
                Map<String, List<ExtensionAttribute>> map = userTask.getAttributes();
                if (map != null && map.size() > 0) {
                    if (map.containsKey(AttributeName.AssigneeType)) {
                        if (AssigneeType.JOB.equals(map.get(AttributeName.AssigneeType).get(0).getValue())) {
                            log.info("职位节点");
                            log.info(userTask.getName() + "---" + userTask.getAssignee());
                            String assignee = userTask.getAssignee();
                            assignee = assignee.replace("${", "").replace("}", "");
                            //
                        }
                    }
                }
            }
        }


        Random random = new Random();
        TaskDemo taskDemo = new TaskDemo();
        taskDemo.setCode("123456789");
        taskDemo.setName("测试");
        taskDemo.setTotal(Math.random() * 200);
        log.info("系统随机数-----------" + taskDemo.getTotal());
        Map map = JSON.parseObject(JSON.toJSONString(taskDemo), Map.class);
        map.put("agent", "1");
        map.put("day", random.nextInt(10));
        Map map1 = wlfowUser.SignedPersonnel();
        map.putAll(map1);
        log.info("系统随机数-----------" + map);
        //得到processEngine对象
        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
        //得到RuntimeService方法
        RuntimeService runtimeService = processEngine.getRuntimeService();
        Authentication.setAuthenticatedUserId(JwtUtil.CurrentUserName());
        ProcessInstance processInstance = runtimeService.startProcessInstanceById(processInstanceId, sequenceUtil.GeneratorCode("FLOW_CODE"), map);
        System.out.println(processInstance.getId());
        System.out.println(processInstance.getDeploymentId());
        System.out.println(processInstance.getActivityId());
        return ResponseResult.success();
    }

    /**
     * 查看流程图
     *
     * @return
     */
    @GetMapping("view")
    public void view(@RequestParam("definitionId") String definitionId, HttpServletResponse response) throws IOException {
        //1.创建ProcessEngine对象
        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
        // 根据流程对象获取流程对象模型
        BpmnModel bpmnModel = processEngine.getRepositoryService().getBpmnModel(definitionId);
        ProcessDiagramGenerator processDiagramGenerator = new DefaultProcessDiagramGenerator();
        InputStream imageStream = null;
        try {
            imageStream = processDiagramGenerator.generateDiagram(bpmnModel, "宋体", "微软雅黑", "黑体");
            response.setContentType("image/svg+xml;charset=UTF-8");
            response.addHeader("Accept-Ranges", "bytes");
            // 输出资源内容到相应对象
            byte[] b = new byte[1024];
            int len;
            while ((len = imageStream.read(b, 0, 1024)) != -1) {
                response.getOutputStream().write(b, 0, len);
            }
            response.getOutputStream().flush();
            imageStream.close();
        } catch (Exception e) {
            log.error("流程图输出异常！", e);
        } finally { // 流关闭
            //IOUtils.closeInputStream(imageStream);

        }
    }


}
