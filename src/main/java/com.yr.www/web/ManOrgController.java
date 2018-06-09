package com.yr.www.web;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.yr.www.common.ManMapStructMapper;
import com.yr.www.entity.*;
import com.yr.www.entity.dto.ManNoticeDto;
import com.yr.www.entity.dto.ManOrgDto;
import com.yr.www.enums.EnumOrgType;
import com.yr.www.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.stream.Collector;
import java.util.stream.Collectors;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yr123
 * @since 2018-05-23
 */
@Controller
//@RequestMapping("/manOrg")
public class ManOrgController {

    @Autowired
    private ManOrgMapper manOrgMapper;
    @Autowired
    private ManUserMapper manUserMapper;
    @Autowired
    private ManUserOrgMapper manUserOrgMapper;
    @Autowired
    private ManApplyMapper manApplyMapper;
    @Autowired
    private ManNoticeMapper manNoticeMapper;


    /***
     * 查看社团列表
     * @param org
     * @return
     */
    @RequestMapping(value = {"/orgList"})
    @ResponseBody
    public Object userList(ManOrg org){
        List<ManOrgDto> orgs = manOrgMapper.selectOrgDtoList();
        orgs.forEach(dto->dto.setOrgTypeName(EnumOrgType.toMap().get(dto.getOrgType())));
        if (!ObjectUtils.isEmpty(org.getAuditStatus())){
            orgs=orgs.stream().filter(dto -> dto.getAuditStatus().equals(org.getAuditStatus())).collect(Collectors.toList());
        }
        if (!ObjectUtils.isEmpty(org.getOrgFounder())){
            orgs=orgs.stream().filter(dto -> dto.getOrgFounder().equals(org.getOrgFounder())).collect(Collectors.toList());
        }
        orgs.forEach(dto -> dto.setNowNum(manUserOrgMapper.selectCount(new EntityWrapper<>(new ManUserOrg().setoId(dto.getId())))));
        return JSONObject.toJSON(orgs);
    }


    /***
     * 查看社团列表
     * @param org
     * @return
     */
    @RequestMapping(value = {"/newOrgList"})
    @ResponseBody
    public Object newOrgList(ManOrg org){
        List<ManOrgDto> orgs = manOrgMapper.selectNewOrgDtoList();
        orgs.forEach(dto->dto.setOrgTypeName(EnumOrgType.toMap().get(dto.getOrgType())));
        if (!ObjectUtils.isEmpty(org.getAuditStatus())){
            orgs=orgs.stream().filter(dto -> dto.getAuditStatus().equals(org.getAuditStatus())).collect(Collectors.toList());
        }
        if (!ObjectUtils.isEmpty(org.getOrgFounder())){
            orgs=orgs.stream().filter(dto -> dto.getOrgFounder().equals(org.getOrgFounder())).collect(Collectors.toList());
        }
        orgs.forEach(dto -> dto.setNowNum(manUserOrgMapper.selectCount(new EntityWrapper<>(new ManUserOrg().setoId(dto.getId())))));
        return JSONObject.toJSON(orgs);
    }

    /**
     * 跳转到社团成员页
     * @param modelAndView
     * @param id
     * @return
     */
    @RequestMapping(value = {"/orgUserPage"})
    public ModelAndView orgUserPage(ModelAndView modelAndView, Integer id){

        modelAndView.addObject("id",id);
        modelAndView.setViewName("user/orgUserList");
        return modelAndView;
    }



    /**
     * 社长跳转到社团成员页
     * @param modelAndView
     * @param id
     * @return
     */
    @RequestMapping(value = {"/orgUserPage2"})
    public ModelAndView orgUserPage2(ModelAndView modelAndView, Integer id){

        modelAndView.addObject("id",id);
        modelAndView.setViewName("org/orgPersonList");
        return modelAndView;
    }


    /***
     * 获取社团成员列表
     * @param id
     * @return
     */
    @RequestMapping(value = {"/changeUserInit"})
    public ModelAndView changeUserInit(ModelAndView modelAndView,Integer id){
        List<ManUserOrg> manUserOrgs = manUserOrgMapper.selectListByOid(id);
        List<Integer> Ids = new ArrayList<>();
        if (!ObjectUtils.isEmpty(manUserOrgs)){
            manUserOrgs.forEach(manUserOrg -> Ids.add(manUserOrg.getuId()));
        }
        List<ManUser> manUsers = manUserMapper.selectListByIds(Ids);
        modelAndView.addObject("manUsers",manUsers);
        modelAndView.addObject("orgId",id);
        modelAndView.setViewName("user/changeUser");
        return modelAndView;
    }


    /***
     *
     * 转让社团
     * @param org
     * @return
     */
    @RequestMapping(value = {"/orgChangeUser"})
    @ResponseBody
    public Object orgChangeUser(ManOrg org){
        if (ObjectUtils.isEmpty(org.getOrgFounder())||ObjectUtils.isEmpty(org.getId())){
            return JSONObject.toJSON("输入错误！");
        }
        ManOrg manOrg = manOrgMapper.selectById(org.getId());
        if (!ObjectUtils.isEmpty(manOrg)&&org.getOrgFounder().equals(manOrg.getOrgFounder())){
            return JSONObject.toJSON("不可以将社团转让给自己");
        }
        manOrgMapper.updateById(org);
        return JSONObject.toJSON("OK");
    }

    /***
     * 获取社团成员列表
     * @param id
     * @return
     */
    @RequestMapping(value = {"/orgUser"})
    @ResponseBody
    public Object orgUser(Integer id){
        List<ManUserOrg> manUserOrgs = manUserOrgMapper.selectListByOid(id);
        List<Integer> userIds = new ArrayList<>();
        if (!ObjectUtils.isEmpty(manUserOrgs)){
            manUserOrgs.forEach(manUserOrg -> userIds.add(manUserOrg.getuId()));
        }
//        List<ManUser> users = manUserMapper.selectList(new EntityWrapper<ManUser>().in("id",userIds));

        List<ManUser> users = manUserMapper.selectListByIds(userIds);
        return JSONObject.toJSON(users);
    }

    /**
     * 退出社团
     * @param oId
     * @param uId
     * @return
     */
    @RequestMapping(value = {"/orgQuit"})
    @ResponseBody
    @Transactional
    public Object orgQuit(Integer oId,Integer uId){
        ManOrg manOrg = manOrgMapper.selectById(oId);
        if (!ObjectUtils.isEmpty(manOrg)&&manOrg.getOrgFounder().equals(uId)){
            return JSONObject.toJSON("您是社团管理员，不可以退出社团！！！");
        }
        ManUserOrg manUserOrg = new ManUserOrg();
        manUserOrg.setoId(oId);
        manUserOrg.setuId(uId);
        ManUserOrg userOrg = manUserOrgMapper.selectOne(manUserOrg);
        if (ObjectUtils.isEmpty(userOrg)){
            return JSONObject.toJSON("不存在该成员！！！");
        }else {
            manUserOrgMapper.deleteById(userOrg.getId());
            //删除申请记录
            ManApply manApply = new ManApply();
            manApply.setoId(oId);
            manApply.setuId(uId);
            ManApply apply = manApplyMapper.selectOne(manApply);
            manApplyMapper.deleteById(apply.getId());
        }
        return JSONObject.toJSON("OK");
    }


    /***
     * 社团添加
     * @param org
     * @return
     */
    @RequestMapping(value = {"/orgAdd"})
    @ResponseBody
    public Object orgAdd(ManOrg org){
        org.setGmtCreate(new Date());
        manOrgMapper.insert(org);
        return JSONObject.toJSON("OK");
    }


    /**
     * 社团启用禁用+编辑
     * @param org
     * @return
     */
    @RequestMapping(value = {"/orgAble"})
    @ResponseBody
    public Object orgAble(ManOrg org){
        Integer nowNum = manUserOrgMapper.selectCount(new EntityWrapper<>(new ManUserOrg().setoId(org.getId())));
//        Integer orgNum = manOrgMapper.selectCount(new EntityWrapper<>(new ManOrg().setId(org.getId())));
        if (nowNum>org.getOrgNum()){
            return JSONObject.toJSON("社团当前成员："+nowNum+"人，请修改合理人数上限");
        }
        manOrgMapper.updateById(org);
        return JSONObject.toJSON("OK");
    }

    /***
     * 删除社团
     * @param id
     * @return
     */
    @RequestMapping(value = {"/orgDel"})
    @ResponseBody
    @Transactional
    public Object orgDel(Integer id){
        //删除成员关系
        ManUserOrg manUserOrg = new ManUserOrg();
        manUserOrg.setoId(id);
        List<ManUserOrg> manUserOrgs = manUserOrgMapper.selectList(new EntityWrapper<>(manUserOrg));
        List<Integer> ids = new ArrayList<>();
        manUserOrgs.forEach(manUserOrg1 -> ids.add(manUserOrg1.getId()));
        if (!CollectionUtils.isEmpty(ids)){
            manUserOrgMapper.deleteBatchIds(ids);
        }

        //删除社团
        manOrgMapper.deleteById(id);

        return JSONObject.toJSON("OK");
    }

    /***
     * 社团批量删除
     * @param delIds
     * @return
     */
    @RequestMapping(value = {"/orgDelAll"})
    @ResponseBody
    @Transactional
    public Object orgDelAll(Integer[] delIds){
        for (Integer id:delIds
             ) {
            //删除成员关系
            ManUserOrg manUserOrg = new ManUserOrg();
            manUserOrg.setoId(id);
            List<ManUserOrg> manUserOrgs = manUserOrgMapper.selectList(new EntityWrapper<>(manUserOrg));
            List<Integer> ids = new ArrayList<>();
            manUserOrgs.forEach(manUserOrg1 -> ids.add(manUserOrg1.getId()));
            if (!CollectionUtils.isEmpty(ids)){
                manUserOrgMapper.deleteBatchIds(ids);
            }
        }
        manOrgMapper.deleteBatchIds(Arrays.asList(delIds));
        return JSONObject.toJSON("OK");
    }

    /**
     * 社团审核
     * @param org
     * @return
     */
    @RequestMapping(value = {"/orgAudit"})
    @ResponseBody
    @Transactional
    public Object orgAudit(ManOrg org){
        manOrgMapper.updateById(org);
        //创建人加入社团
        if (org.getAuditStatus()==2){
            ManOrg manOrg = manOrgMapper.selectById(org.getId());
            ManUserOrg manUserOrg = new ManUserOrg();
            manUserOrg.setoId(manOrg.getId());
            manUserOrg.setuId(manOrg.getOrgFounder());
            manUserOrg.setGmtCreate(new Date());
            manUserOrgMapper.insert(manUserOrg);
        }

        return JSONObject.toJSON("OK");
    }

    /***
     * 社团修改初始化页面
     * @param modelAndView
     * @param id
     * @return
     */
    @RequestMapping(value = {"/orgInitUpdate"})
    public ModelAndView orgInitUpdate(ModelAndView modelAndView, Integer id){

        ManOrg manOrg = manOrgMapper.selectById(id);
        ManOrgDto orgDto = ManMapStructMapper.INSTANCE.ManOrgPo2Dto(manOrg);
        orgDto.setUserName(manUserMapper.selectById(manOrg.getOrgFounder()).getUserName());
        modelAndView.addObject("org",orgDto);
        modelAndView.setViewName("org/orgInfo");
        return modelAndView;
    }

    /**
     * 社团首页(社团信息+社团公告)
     * @param modelAndView
     * @param id
     * @return
     */
    @RequestMapping(value = {"/orgHome"})
    public ModelAndView orgHome(ModelAndView modelAndView, Integer id){

        ManOrg manOrg = manOrgMapper.selectById(id);
        modelAndView.addObject("org",manOrg);
        ManNotice manNotice = new ManNotice();
        manNotice.setOrgId(id);
        List<ManNoticeDto> notices = manNoticeMapper.selectDtoList(manNotice);
        modelAndView.addObject("notices",notices);
        modelAndView.setViewName("org/orgHome");
        return modelAndView;
    }


    /***
     * 我加入的社团列表
     * @param session
     * @return
     */
    @RequestMapping(value = {"/myOrgList"})
    @ResponseBody
    public Object myOrgList(HttpSession session){
        ManUser manUser = (ManUser) session.getAttribute("sessionUser");
        List<ManOrgDto> manOrgDtos = new ArrayList<>();
        List<Integer> orgIds = new ArrayList<>();
        List<ManUserOrg> manUserOrgs = manUserOrgMapper.selectListByUid(manUser.getId());
        if (!ObjectUtils.isEmpty(manUserOrgs)){
            manUserOrgs.forEach(manUserOrg -> orgIds.add(manUserOrg.getoId()));
            manOrgDtos= manOrgMapper.selectOrgDtoListByIds(orgIds);
            manOrgDtos.forEach(dto->dto.setOrgTypeName(EnumOrgType.toMap().get(dto.getOrgType())));
            manOrgDtos.forEach(dto -> dto.setNowNum(manUserOrgMapper.selectCount(new EntityWrapper<>(new ManUserOrg().setoId(dto.getId())))));
        }
        return JSONObject.toJSON(manOrgDtos);
    }

    /***
     * 申请加入社团
     * @param apply
     * @return
     */
    @RequestMapping(value = {"/orgApply"})
    @ResponseBody
    public Object orgApply(ManApply apply){
        Integer nowNum = manUserOrgMapper.selectCount(new EntityWrapper<>(new ManUserOrg().setoId(apply.getoId())));
        Integer orgNum = manOrgMapper.selectById(apply.getoId()).getOrgNum();
        if (orgNum<=nowNum){
            return JSONObject.toJSON("抱歉！社团成员已满！");
        }
        ManUserOrg manUserOrg = new ManUserOrg();
        manUserOrg.setoId(apply.getoId());
        manUserOrg.setuId(apply.getuId());
        ManUserOrg userOrg = manUserOrgMapper.selectOne(manUserOrg);
        if (!ObjectUtils.isEmpty(userOrg)){
            return JSONObject.toJSON("您已加入该社团，请勿重复申请！");
        }
        ManApply manApply = new ManApply();
        manApply.setoId(apply.getoId());
        manApply.setuId(apply.getuId());
        if (!ObjectUtils.isEmpty(manApplyMapper.selectOne(manApply))){
            return JSONObject.toJSON("您已提交申请，请等待审核！");
        }
        apply.setGmtCreate(new Date());
        manApplyMapper.insert(apply);
        return JSONObject.toJSON("OK");
    }







}

