package com.yao.dashboard.common.domain;

import java.io.Serializable;

public class PerformanceMethodsInfo implements Serializable {
    private static final long serialVersionUID = 1L;
    private String env;
    private Integer threadNumber;

    public String getEnv() {
        return env;
    }

    public void setEnv(String env) {
        this.env = env;
    }

    public Integer getThreadNumber() {
        return threadNumber;
    }

    public void setThreadNumber(Integer threadNumber) {
        this.threadNumber = threadNumber;
    }
}
