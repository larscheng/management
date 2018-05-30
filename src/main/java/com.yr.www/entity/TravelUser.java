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
 * @since 2018-04-13
 */
@TableName("travel_user")
public class TravelUser implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 用户姓名
     */
    @TableField("user_name")
    private String userName;
    /**
     * 用户账号
     */
    @TableField("user_code")
    private String userCode;
    /**
     * 用户密码
     */
    @TableField("user_password")
    private String userPassword;
    /**
     * 联系电话
     */
    @TableField("user_phone")
    private String userPhone;
    /**
     * 邮箱
     */
    @TableField("user_mail")
    private String userMail;
    /**
     * 用户状态，1启用 0禁用  默认启用
     */
    @TableField("user_status")
    private Integer userStatus;
    /**
     * 用户类型  1管理员  2普通用户
     */
    @TableField("user_type")
    private Integer userType;
    /**
     * 创建时间
     */
    @TableField("gmt_create")
    private Date gmtCreate;
    /**
     * 修改时间
     */
    @TableField("gmt_modify")
    private Date gmtModify;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserCode() {
        return userCode;
    }

    public TravelUser setUserCode(String userCode) {
        this.userCode = userCode;
        return this;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserMail() {
        return userMail;
    }

    public void setUserMail(String userMail) {
        this.userMail = userMail;
    }

    public Integer getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(Integer userStatus) {
        this.userStatus = userStatus;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
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

    @Override
    public String toString() {
        return "TravelUser{" +
        "id=" + id +
        ", userName=" + userName +
        ", userCode=" + userCode +
        ", userPassword=" + userPassword +
        ", userPhone=" + userPhone +
        ", userMail=" + userMail +
        ", userStatus=" + userStatus +
        ", userType=" + userType +
        ", gmtCreate=" + gmtCreate +
        ", gmtModify=" + gmtModify +
        "}";
    }
}
