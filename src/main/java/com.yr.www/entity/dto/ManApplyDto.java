package com.yr.www.entity.dto;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author yr123
 * @since 2018-05-29
 */
public class ManApplyDto{


    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 社团id
     */
    @TableField("o_id")
    private Integer oId;
    /**
     * 用户id
     */
    @TableField("u_id")
    private Integer uId;
    /**
     * 申请理由
     */
    @TableField("apply_reason")
    private String applyReason;
    /**
     * 审核状态1未处理2审核通过3审核不通过
     */
    @TableField("audit_status")
    private Integer auditStatus;
    /**
     * 审核意见
     */
    @TableField("audit_content")
    private String auditContent;
    @TableField("gmt_create")
    private Date gmtCreate;


    private String orgName;
    private String userName;


    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getoId() {
        return oId;
    }

    public void setoId(Integer oId) {
        this.oId = oId;
    }

    public Integer getuId() {
        return uId;
    }

    public void setuId(Integer uId) {
        this.uId = uId;
    }

    public String getApplyReason() {
        return applyReason;
    }

    public void setApplyReason(String applyReason) {
        this.applyReason = applyReason;
    }

    public Integer getAuditStatus() {
        return auditStatus;
    }

    public void setAuditStatus(Integer auditStatus) {
        this.auditStatus = auditStatus;
    }

    public String getAuditContent() {
        return auditContent;
    }

    public void setAuditContent(String auditContent) {
        this.auditContent = auditContent;
    }

    public Date getGmtCreate() {
        return gmtCreate;
    }

    public void setGmtCreate(Date gmtCreate) {
        this.gmtCreate = gmtCreate;
    }

    @Override
    public String toString() {
        return "ManApply{" +
        "id=" + id +
        ", oId=" + oId +
        ", uId=" + uId +
        ", applyReason=" + applyReason +
        ", auditStatus=" + auditStatus +
        ", auditContent=" + auditContent +
        ", gmtCreate=" + gmtCreate +
        "}";
    }
}
