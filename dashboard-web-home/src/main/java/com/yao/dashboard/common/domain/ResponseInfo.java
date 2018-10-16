package com.yao.dashboard.common.domain;

import java.io.Serializable;

public class ResponseInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private boolean status;
    private String message;
    private Integer code;
    private Object data;

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
