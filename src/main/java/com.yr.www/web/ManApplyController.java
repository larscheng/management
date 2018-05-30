package com.yr.www.web;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.yr.www.entity.ManApply;
import com.yr.www.entity.ManOrg;
import com.yr.www.entity.ManUser;
import com.yr.www.entity.ManUserOrg;
import com.yr.www.entity.dto.ManApplyDto;
import com.yr.www.entity.dto.ManOrgDto;
import com.yr.www.enums.EnumOrgType;
import com.yr.www.mapper.ManApplyMapper;
import com.yr.www.mapper.ManOrgMapper;
import com.yr.www.mapper.ManUserMapper;
import com.yr.www.mapper.ManUserOrgMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yr123
 * @since 2018-05-29
 */
@Controller
public class ManApplyController {

    @Autowired
    private ManOrgMapper manOrgMapper;
    @Autowired
    private ManUserMapper manUserMapper;
    @Autowired
    private ManUserOrgMapper manUserOrgMapper;
    @Autowired
    private ManApplyMapper manApplyMapper;

    /**
     * 入团申请列表
     * @param apply
     * @return
     */
    @RequestMapping(value = {"/applyList"})
    @ResponseBody
    public Object applyList(ManApply apply){
        List<ManApplyDto> orgDtos = manApplyMapper.selectApplyDtoList(apply);
        return JSONObject.toJSON(orgDtos);
    }


    /**
     * 社长审核列表
     * @param apply
     * @param session
     * @return
     */
    @RequestMapping(value = {"/apply2List"})
    @ResponseBody
    public Object apply2List(ManApply apply,HttpSession session){
        ManUser manUser = (ManUser) session.getAttribute("sessionUser");
        List<ManOrg> manOrgs = new ArrayList<>();
        if (!ObjectUtils.isEmpty(manUser)){
            manOrgs= manOrgMapper.selectList(new EntityWrapper<ManOrg>()
                    .and("org_founder={0}",manUser.getId())
                    .and("audit_status={0}",2)
            );
        }
        List<ManApplyDto> orgDtos = new ArrayList<>();
        if (!CollectionUtils.isEmpty(manOrgs)){
            for (ManOrg org: manOrgs
                 ) {
                apply.setoId(org.getId());
                orgDtos.addAll(manApplyMapper.selectApplyDtoList(apply));
            }
        }


        return JSONObject.toJSON(orgDtos);
    }

    @RequestMapping(value = {"/applyAudit"})
    @ResponseBody
    @Transactional
    public Object applyAudit(ManApply apply){
        ManApply manApply = manApplyMapper.selectById(apply.getId());
        if (apply.getAuditStatus()==2){
            //加入社团
            //建立对应关系
            ManUserOrg manUserOrg = new ManUserOrg();
            manUserOrg.setuId(manApply.getuId());
            manUserOrg.setoId(manApply.getoId());
            manUserOrg.setGmtCreate(new Date());
            manUserOrgMapper.insert(manUserOrg);
        }
        //更新状态
        manApplyMapper.updateById(apply);
        return JSONObject.toJSON("OK");
    }


}

