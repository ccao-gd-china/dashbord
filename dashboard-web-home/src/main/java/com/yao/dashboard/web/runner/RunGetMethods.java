package com.yao.dashboard.web.runner;

import com.yao.dashboard.biz.service.data.MethodsService;
import com.yao.dashboard.common.domain.MethodsInfo;
import com.yao.dashboard.common.utils.MethodsFactory;
import com.yao.dashboard.common.utils.ResponseFactory;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;

import java.util.List;

import static com.yao.dashboard.common.utils.MethodsFactory.getSsoApiData;

public class RunGetMethods implements Runnable {
    MethodsInfo info;
    Logger logger;
    String env;
    String authorizationValue;
    List<MethodsInfo> responseMethodsInfoList;
    MethodsService methodsService;


    public RunGetMethods(String env, MethodsInfo info, String authorizationValue, List<MethodsInfo> responseMethodsInfoList, MethodsService methodsService, Logger logger) {
        this.info = info;
        this.logger = logger;
        this.env = env;
        this.authorizationValue = authorizationValue;
        this.responseMethodsInfoList = responseMethodsInfoList;
        this.methodsService = methodsService;
    }

    @Override
    public void run() {
        String methodsBody = MethodsFactory.getMethodsBody(this.env, this.info.getCountry(), this.info.getCurrency(), this.authorizationValue, this.logger);
        if (StringUtils.isNotBlank(methodsBody)) {
            String checks[] = this.info.getChecks().split(",");
            String id[] = this.info.getIds().split(",");
            for (int i = 0; i < checks.length; i++) {
                MethodsInfo responseMethodsInfo = new MethodsInfo();
                responseMethodsInfo.setFlag(MethodsFactory.checkMethodsBody(methodsBody, checks[i], this.logger));
                responseMethodsInfo.setCountry(this.info.getCountry());
                responseMethodsInfo.setCurrency(this.info.getCurrency());
                responseMethodsInfo.setChecks(checks[i]);
                responseMethodsInfo.setId(Integer.valueOf(id[i]));
                responseMethodsInfoList.add(responseMethodsInfo);
            }
        }
    }
}
