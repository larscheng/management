package com.yr.www.entity;

import com.baomidou.mybatisplus.enums.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author yr123
 * @since 2018-05-23
 */
@TableName("man_org")
public class ManOrg implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 社团名称
     */
    @TableField("org_name")
    private String orgName;
    /**
     * 社团创始人
     */
    @TableField("org_founder")
    private Integer orgFounder;
    /**
     * 社团类型
     */
    @TableField("org_type")
    private Integer orgType;
    /**
     * 社团人数
     */
    @TableField("org_num")
    private Integer orgNum;
    /**
     * 社团介绍
     */
    @TableField("org_info")
    private String orgInfo;
    /**
     * 社团状态 1启用0禁用
     */
    @TableField("org_status")
    private Integer orgStatus;
    /**
     * 审核意见
     */
    @TableField("audit_content")
    private String auditContent;
    /**
     * 审核状态 1未处理2审核通过3审核不通过
     */
    @TableField("audit_status")
    private Integer auditStatus;
    /**
     * 审核人
     */
    @TableField("operator_id")
    private Integer operatorId;
    /**
     * 创建时间
     */
    @TableField("gmt_create")
    private Date gmtCreate;
    @TableField("gmt_modify")
    private Date gmtModify;


    public Integer getId() {
        return id;
    }

    public ManOrg setId(Integer id) {
        this.id = id;
        return this;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public Integer getOrgFounder() {
        return orgFounder;
    }

    public void setOrgFounder(Integer orgFounder) {
        this.orgFounder = orgFounder;
    }

    public Integer getOrgType() {
        return orgType;
    }

    public void setOrgType(Integer orgType) {
        this.orgType = orgType;
    }

    public String getOrgInfo() {
        return orgInfo;
    }

    public void setOrgInfo(String orgInfo) {
        this.orgInfo = orgInfo;
    }

    public Integer getOrgStatus() {
        return orgStatus;
    }

    public void setOrgStatus(Integer orgStatus) {
        this.orgStatus = orgStatus;
    }

    public String getAuditContent() {
        return auditContent;
    }

    public void setAuditContent(String auditContent) {
        this.auditContent = auditContent;
    }

    public Integer getAuditStatus() {
        return auditStatus;
    }

    public void setAuditStatus(Integer auditStatus) {
        this.auditStatus = auditStatus;
    }

    public Integer getOperatorId() {
        return operatorId;
    }

    public void setOperatorId(Integer operatorId) {
        this.operatorId = operatorId;
    }

    public Date getGmtCreate() {
        return gmtCreate;
    }

    public void setGmtCreate(Date gmtCreate) {
        this.gmtCreate = gmtCreate;
    }

    public Date getGmtModify() {
        return gmtModify;
    }

    public void setGmtModify(Date gmtModify) {
        this.gmtModify = gmtModify;
    }

    public Integer getOrgNum() {
        return orgNum;
    }

    public void setOrgNum(Integer orgNum) {
        this.orgNum = orgNum;
    }
}
