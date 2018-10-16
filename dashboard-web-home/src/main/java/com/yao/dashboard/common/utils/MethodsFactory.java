package com.yao.dashboard.common.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yao.dashboard.common.domain.Global;
import com.yao.dashboard.common.domain.HttpClientResponseInfo;

import org.slf4j.Logger;

public class MethodsFactory {
    public static String getMethodsBody(String env, String country, String currency, String authorizationValue, Logger logger) {
        String url;
        switch (env) {
            case "dev":
                url = Global.DevGetMethodsUri;
                break;
            case "test":
                url = Global.TestGetMethodsUri;
                break;
            case "product":
                url = Global.ProGetMethodsUri;
                break;
            default:
                return null;
        }
        url = url + "?includeProfiles=true&country=" + country + "&currency=" + currency;
        HttpClientResponseInfo info;
        if (!env.equals("product")) {
            info = new HttpClientFactory().ClientGetMethods(url, authorizationValue, false);
        } else {
            info = new HttpClientFactory().ClientGetMethods(url, authorizationValue, true);
        }
        if (info.getCode() == 200) {
            return info.getBody().text();
        } else {
            logger.error(url + "\t" + info.getCode() + "\t" + info.getMessage());
            return null;
        }
    }

    public static String getSsoApiData(String env, Logger logger) {
        String url;
        switch (env) {
            case "dev":
                url = Global.DevGetTokenUri;
                break;
            case "test":
                url = Global.TestGetTokenUri;
                break;
            case "product":
                url = Global.ProGetTokenUri;
                break;
            default:
                return null;
        }

        HttpClientResponseInfo info = new HttpClientFactory().ClientSsoApi(url);
        if (info.getCode() == 201) {
            JSONObject jsonObject = JSON.parseObject(info.getBody().text());
            return "sso-jwt " + jsonObject.getString("data");
        } else {
            logger.error(url + "\t" + info.getCode() + "\t" + info.getMessage());
            return null;
        }
    }

    public static boolean checkMethodsBody(String methodsBody, String checks, Logger logger) {
        try {
            String key = checks.split("/")[0].trim();
            String value = checks.split("/")[1].trim();
            JSONObject jsonObject = JSON.parseObject(methodsBody);
            JSONArray newMethods = jsonObject.getJSONArray("newMethods");
            for (int i = 0; i < newMethods.size(); i++) {
                JSONObject jObject = newMethods.getJSONObject(i);
                if (jObject.getString("category").equals(key)) {
                    JSONArray subCategory = newMethods.getJSONObject(i).getJSONArray("subCategory");
                    for (int j = 0; j < subCategory.size(); j++) {
                        if (subCategory.get(j).equals(value)) {
                            return true;
                        }
                    }
                }
            }
            return false;
        } catch (Exception e) {
            logger.error(methodsBody + "\n" + checks + "\n" + e.getLocalizedMessage());
            return false;
        }
    }
}
