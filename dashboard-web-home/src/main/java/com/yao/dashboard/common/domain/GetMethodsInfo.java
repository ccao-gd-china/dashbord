package com.yao.dashboard.common.domain;

import java.io.Serializable;

public class GetMethodsInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private String env;
    private String country;
    private String currency;

    public String getEnv() {
        return env;
    }

    public void setEnv(String env) {
        this.env = env;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }
}
