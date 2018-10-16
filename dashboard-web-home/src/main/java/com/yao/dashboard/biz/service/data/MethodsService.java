package com.yao.dashboard.biz.service.data;

import com.yao.dashboard.common.dao.MethodsMapper;
import com.yao.dashboard.common.domain.MethodsInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional("dashboardTransactionManager")
public class MethodsService {
    private static final Logger logger = LoggerFactory.getLogger(MethodsService.class);

    @Autowired
    private MethodsMapper methodsMapper;

    public List<MethodsInfo> getMethodsList() {
        return this.methodsMapper.getMethodsList();
    }

    public void deleteIgnoreChecks(Integer id) {
        this.methodsMapper.deleteIgnoreChecks(id);
    }

    public List<MethodsInfo> getMethodsListByGroup() {
        return this.methodsMapper.getMethodsListByGroup();
    }

    public Integer getIdByInfo(String country, String currency, String checks) {
        return this.methodsMapper.getIdByInfo(country,currency,checks);
    }
}
