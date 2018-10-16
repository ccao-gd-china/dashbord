package com.yao.dashboard.web.controller;


import com.yao.dashboard.biz.service.data.MethodsService;
import com.yao.dashboard.common.domain.*;
import com.yao.dashboard.common.utils.ResponseFactory;
import com.yao.dashboard.web.runner.RunGetMethods;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import static com.yao.dashboard.common.utils.MethodsFactory.getMethodsBody;
import static com.yao.dashboard.common.utils.MethodsFactory.getSsoApiData;

@Controller
public class MethodsController {
    private static final Logger logger = LoggerFactory.getLogger(MethodsController.class);

    @Autowired
    private MethodsService methodsService;

    @RequestMapping(value = "/getMethods", method = RequestMethod.POST)
    @ResponseBody
    public ResponseInfo getMethods(@ModelAttribute("getMethodsInfo") GetMethodsInfo getMethodsInfo) {
        try {
            //request sso api and get token(authorizationValue)
            String authorizationValue = getSsoApiData(getMethodsInfo.getEnv(), logger);
            if (null == authorizationValue) {
                return new ResponseFactory().getSystemErrorResponse("Get Sso Api error");
            }
            //request getMethods and get body
            String methodsBody = getMethodsBody(getMethodsInfo.getEnv(), getMethodsInfo.getCountry(), getMethodsInfo.getCurrency(), authorizationValue, logger);
            if (null == methodsBody) {
                return new ResponseFactory().getSystemErrorResponse("Get MethodsBody error");
            }
            return new ResponseFactory().getSuccessResponse(methodsBody);
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
            return new ResponseFactory().getSystemErrorResponse(StatusInfo.SystemError);
        }
    }

    @RequestMapping(value = "/getPerformanceMethods", method = RequestMethod.POST)
    @ResponseBody
    public ResponseInfo getPerformanceMethods(@ModelAttribute("performanceMethodsInfo") PerformanceMethodsInfo pInfo, HttpServletRequest request) {
        try {
//            String resultMessage = checkParam(pInfo);
//            if (StringUtils.isNotBlank(resultMessage)) {
//                return new ResponseFactory().getSystemErrorResponse(resultMessage);
//            }

            //request sso api and get token(authorizationValue)
            String authorizationValue = getSsoApiData(pInfo.getEnv(), logger);
            if (null == authorizationValue) {
                return new ResponseFactory().getSystemErrorResponse("Get Sso Api error");
            }

            List<MethodsInfo> methodsInfoList = this.methodsService.getMethodsListByGroup();
            List<MethodsInfo> responseMethodsInfoList = new Vector<>();
            multiThreadedRequest(pInfo, authorizationValue, methodsInfoList, responseMethodsInfoList);

            PerformanceMethodsResponseInfo perMethodsResponseInfo = new PerformanceMethodsResponseInfo();
            List<Integer> errorIdList = new ArrayList<>();
            sortingData(responseMethodsInfoList, perMethodsResponseInfo, errorIdList);

            HttpSession session = request.getSession();
            session.setAttribute("ErrorList", errorIdList);

            return new ResponseFactory().getSuccessResponse(perMethodsResponseInfo);
        } catch (Exception e) {
            return new ResponseFactory().getSystemErrorResponse(StatusInfo.SystemError);
        }
    }

    @RequestMapping(value = "/ignoreChecks", method = RequestMethod.POST)
    @ResponseBody
    public ResponseInfo ignoreChecks(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession();
            List<Integer> errorList = (List<Integer>) session.getAttribute("ErrorList");
            if (errorList.size() == 0) {
                return new ResponseFactory().getSystemErrorResponse("parameter error");
            }
            for (Integer id : errorList) {
                this.methodsService.deleteIgnoreChecks(id);
            }
            return new ResponseFactory().getSuccessResponse("Success");
        } catch (Exception e) {
            return new ResponseFactory().getSystemErrorResponse(StatusInfo.SystemError);
        }
    }

    private void sortingData(List<MethodsInfo> methodsInfoList, PerformanceMethodsResponseInfo perMethodsResponseInfo, List<Integer> errorIdList) {
        for (MethodsInfo info : methodsInfoList) {
            if (info.isFlag()) {
                perMethodsResponseInfo.getSuccessList().add(info);
            } else {
                perMethodsResponseInfo.getErrorList().add(info);
                errorIdList.add(info.getId());
            }
        }
        methodsInfoList.clear();
    }

    //Multi-threaded request
    private void multiThreadedRequest(PerformanceMethodsInfo pInfo, String authorizationValue, List<MethodsInfo> methodsInfoList, List<MethodsInfo> responseMethodsInfoList) {
        int threadNumber;
        if (pInfo.equals("product")) {
            threadNumber = 50;
        } else {
            threadNumber = 5;
        }
        ExecutorService p = Executors.newFixedThreadPool(threadNumber);
        int count = 0;
        for (MethodsInfo info : methodsInfoList) {
            p.execute(new RunGetMethods(pInfo.getEnv(), info, authorizationValue, responseMethodsInfoList,this.methodsService, logger));
            count++;
            if (count == 150) {
//                Thread.sleep(90000);
                count = 0;
            }
        }
        while (p.isTerminated() == false) {
            p.shutdown();
        }
    }

//    private String checkParam(PerformanceMethodsInfo pInfo) {
//        if (pInfo.getThreadNumber() <= 0) {
//            return "Thread Number is not good";
//        } else if (pInfo.getThreadNumber() > 500) {
//            return "Thread Number is too large";
//        } else {
//            return null;
//        }
//    }

}
