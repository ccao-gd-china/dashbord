package com.yao.dashboard.common.utils;

import com.yao.dashboard.common.domain.Global;
import com.yao.dashboard.common.domain.HttpClientResponseInfo;
import org.jsoup.HttpStatusException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

public class HttpClientFactory {
    private HttpClientResponseInfo httpClientResponseInfo = new HttpClientResponseInfo();

    public HttpClientResponseInfo ClientGetMethods(String url, String authorizationValue, boolean b) {
        try {
            Document doc;
            if (!b) {
                doc = Jsoup.connect(url).maxBodySize(0).ignoreContentType(true).timeout(30000)
                        .header("Authorization", authorizationValue)
                        .get();
            }else {
                doc = Jsoup.connect(url).maxBodySize(0).ignoreContentType(true).timeout(30000)
                        .header("Authorization", authorizationValue)
                        .header("user-agent","Automation Client TestNG")
                        .get();
            }
            httpClientResponseInfo.setCode(200);
            httpClientResponseInfo.setBody(doc.body());
            return httpClientResponseInfo;
        } catch (HttpStatusException e) {
            httpClientResponseInfo.setCode(e.getStatusCode());
            httpClientResponseInfo.setMessage(e.getMessage());
            return httpClientResponseInfo;
        } catch (Exception e) {
            httpClientResponseInfo.setCode(0);
            httpClientResponseInfo.setMessage(e.getMessage());
            return httpClientResponseInfo;
        }
    }

    public HttpClientResponseInfo ClientSsoApi(String url) {
        try {
            Document doc = Jsoup.connect(url).maxBodySize(0).ignoreContentType(true).timeout(30000)
                    .data("username", Global.USERNAME)
                    .data("password", Global.PASSWORD)
                    .data("realm", Global.REALM)
                    .post();
            httpClientResponseInfo.setCode(201);
            httpClientResponseInfo.setBody(doc.body());
            return httpClientResponseInfo;
        } catch (HttpStatusException e) {
            httpClientResponseInfo.setCode(e.getStatusCode());
            httpClientResponseInfo.setMessage(e.getMessage());
            return httpClientResponseInfo;
        } catch (Exception e) {
            httpClientResponseInfo.setCode(0);
            httpClientResponseInfo.setMessage(e.getMessage());
            return httpClientResponseInfo;
        }
    }
}