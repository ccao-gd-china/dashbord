package com.yao.dashboard.common.dao;

import com.yao.dashboard.common.domain.MethodsInfo;

import java.util.List;

public interface MethodsMapper {
    List<MethodsInfo> getMethodsList();

    void deleteIgnoreChecks(Integer id);

    List<MethodsInfo> getMethodsListByGroup();

    Integer getIdByInfo(String country, String currency, String checks);
}
