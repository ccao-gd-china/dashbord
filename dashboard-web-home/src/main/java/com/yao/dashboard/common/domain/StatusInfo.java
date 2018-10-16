package com.yao.dashboard.common.domain;

import java.io.Serializable;

public class StatusInfo implements Serializable{
    private static final long serialVersionUID = 1L;
    // 成功状态
    public final static Integer SuccessCode = 0;
    public final static String Success = "Success";
    // 系统错误
    public final static Integer SystemErrorCode = 1;
    public final static String SystemError = "SystemError";
    // 数据错误 -- 验证数据
    public final static Integer DataErrorCode = 2;
    public final static String DataError = "DataError";
    // sql错误
    public final static Integer SqlErrorCode = 3;
    public final static String SqlError = "SqlError";
}
