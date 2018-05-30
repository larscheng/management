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
 * @since 2018-05-22
 */
public class ManUserDto {

    private Integer id;
    /**
     * 真实姓名
     */

    private String userName;
    /**
     * 性别 1男2女
     */

    private Integer userSex;
    /**
     * 账号
     */

    private String userCode;
    /**
     * 密码
     */

    private String userPassword;
    /**
     * 邮箱
     */

    private String userMail;
    /**
     * 电话
     */

    private String userPhone;
    /**
     * 生日
     */

    private String userBirthday;
    /**
     * 家庭地址
     */

    private String userAddress;
    /**
     * 兴趣爱好
     */
    private String userHobby;
    /**
     * 自我评价
     */
    private String userEvaluate;
    /**
     * 用户类型，1超管2社长3社团管理4社员
     */
    private Integer userType;
    /**
     * 1启用0禁用
     */
    private Integer userStatus;
    /**
     * 所属社团id
     */
    private Integer userOrg;
    private String orgName;
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

    public Integer getUserSex() {
        return userSex;
    }

    public void setUserSex(Integer userSex) {
        this.userSex = userSex;
    }

    public String getUserCode() {
        return userCode;
    }

    public ManUserDto setUserCode(String userCode) {
        this.userCode = userCode;return this;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserMail() {
        return userMail;
    }

    public void setUserMail(String userMail) {
        this.userMail = userMail;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserBirthday() {
        return userBirthday;
    }

    public void setUserBirthday(String userBirthday) {
        this.userBirthday = userBirthday;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getUserHobby() {
        return userHobby;
    }

    public void setUserHobby(String userHobby) {
        this.userHobby = userHobby;
    }

    public String getUserEvaluate() {
        return userEvaluate;
    }

    public void setUserEvaluate(String userEvaluate) {
        this.userEvaluate = userEvaluate;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public Integer getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(Integer userStatus) {
        this.userStatus = userStatus;
    }

    public Integer getUserOrg() {
        return userOrg;
    }

    public void setUserOrg(Integer userOrg) {
        this.userOrg = userOrg;
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
        return "ManUser{" +
        "id=" + id +
        ", userName=" + userName +
        ", userSex=" + userSex +
        ", userCode=" + userCode +
        ", userPassword=" + userPassword +
        ", userMail=" + userMail +
        ", userPhone=" + userPhone +
        ", userBirthday=" + userBirthday +
        ", userAddress=" + userAddress +
        ", userHobby=" + userHobby +
        ", userEvaluate=" + userEvaluate +
        ", userType=" + userType +
        ", userStatus=" + userStatus +
        ", userOrg=" + userOrg +
        ", gmtCreate=" + gmtCreate +
        ", gmtModify=" + gmtModify +
        "}";
    }
}
