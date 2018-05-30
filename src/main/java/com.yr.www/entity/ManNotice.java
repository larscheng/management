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
 * @since 2018-05-30
 */
@TableName("man_notice")
public class ManNotice implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 公告id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 公告标题
     */
    @TableField("notice_title")
    private String noticeTitle;
    /**
     * 公告作者
     */
    @TableField("notice_auth")
    private Integer noticeAuth;
    /**
     * 社团id
     */
    @TableField("org_id")
    private Integer orgId;
    /**
     * 公告内容
     */
    @TableField("notice_content")
    private String noticeContent;
    /**
     * 发布时间
     */
    @TableField("gmt_create")
    private Date gmtCreate;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNoticeTitle() {
        return noticeTitle;
    }

    public void setNoticeTitle(String noticeTitle) {
        this.noticeTitle = noticeTitle;
    }

    public Integer getNoticeAuth() {
        return noticeAuth;
    }

    public void setNoticeAuth(Integer noticeAuth) {
        this.noticeAuth = noticeAuth;
    }

    public Integer getOrgId() {
        return orgId;
    }

    public void setOrgId(Integer orgId) {
        this.orgId = orgId;
    }

    public String getNoticeContent() {
        return noticeContent;
    }

    public void setNoticeContent(String noticeContent) {
        this.noticeContent = noticeContent;
    }

    public Date getGmtCreate() {
        return gmtCreate;
    }

    public void setGmtCreate(Date gmtCreate) {
        this.gmtCreate = gmtCreate;
    }

    @Override
    public String toString() {
        return "ManNotice{" +
        "id=" + id +
        ", noticeTitle=" + noticeTitle +
        ", noticeAuth=" + noticeAuth +
        ", orgId=" + orgId +
        ", noticeContent=" + noticeContent +
        ", gmtCreate=" + gmtCreate +
        "}";
    }
}
