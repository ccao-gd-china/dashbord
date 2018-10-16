package com.yao.dashboard.common.domain;

import org.jsoup.nodes.Element;

import java.io.Serializable;

public class HttpClientResponseInfo implements Serializable {
    private static final long serialVersionUID = 1L;
    private Integer code;
    private Element body;
    private String message;

    public Element getBody() {
        return body;
    }

    public void setBody(Element body) {
        this.body = body;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }



    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
