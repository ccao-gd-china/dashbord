package com.yao.dashboard.common.utils;

import com.yao.dashboard.common.domain.ResponseInfo;
import com.yao.dashboard.common.domain.StatusInfo;

public class ResponseFactory {
    private ResponseInfo responseInfo = new ResponseInfo();

    public ResponseInfo getSystemErrorResponse(String message){
        responseInfo.setCode(StatusInfo.SystemErrorCode);
        responseInfo.setData(message);
        responseInfo.setMessage(StatusInfo.SystemError);
        responseInfo.setStatus(false);
        return responseInfo;
    }

    public ResponseInfo getSuccessResponse(Object body){
        responseInfo.setCode(StatusInfo.SuccessCode);
        responseInfo.setData(body);
        responseInfo.setMessage(StatusInfo.Success);
        responseInfo.setStatus(true);
        return responseInfo;
    }
}
