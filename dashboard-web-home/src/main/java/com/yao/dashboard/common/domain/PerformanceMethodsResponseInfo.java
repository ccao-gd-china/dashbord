package com.yao.dashboard.common.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class PerformanceMethodsResponseInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private List<MethodsInfo> successList = new ArrayList<>();
    private List<MethodsInfo> errorList = new ArrayList<>();

    public List<MethodsInfo> getSuccessList() {
        return successList;
    }

    public void setSuccessList(List<MethodsInfo> successList) {
        this.successList = successList;
    }

    public List<MethodsInfo> getErrorList() {
        return errorList;
    }

    public void setErrorList(List<MethodsInfo> errorList) {
        this.errorList = errorList;
    }
}
