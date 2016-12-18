package com.casic.datadriver.controller;

/**
 * Created by Administrator on 2016/11/28.
 */


        import java.text.SimpleDateFormat;
        import java.util.Date;

        import javax.annotation.Resource;
        import javax.servlet.http.HttpServletRequest;
        import javax.servlet.http.HttpServletResponse;

        import com.casic.datadriver.model.task.TaskInfo;
        import com.casic.datadriver.model.task.ProTaskDependance;
        import com.casic.datadriver.service.task.ProTaskDependanceService;
        import com.casic.datadriver.service.task.TaskInfoService;


public class testdatabase {
    public static void main() {



        ProTaskDependance proTaskDependance = new ProTaskDependance();
        proTaskDependance.setDdDepenganceId(34L);
        proTaskDependance.setDdProjectId(123L);
        proTaskDependance.setDdTaskId(1L);
        //  proTaskDependance.setDdPrepositionTaskId();
        //proTaskDependance.setDdDepenganceId(1);

    }
}
