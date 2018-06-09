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
 * @since 2018-05-22
 */
@TableName("man_user")
public class ManUser implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 真实姓名
     */
    @TableField("user_name")
    private String userName;
    /**
     * 性别 1男2女
     */
    @TableField("user_sex")
    private Integer userSex;
    /**
     * 账号
     */
    @TableField("user_code")
    private String userCode;
    /**
     * 密码
     */
    @TableField("user_password")
    private String userPassword;
    /**
     * 邮箱
     */
    @TableField("user_mail")
    private String userMail;
    /**
     * 电话
     */
    @TableField("user_phone")
    private String userPhone;
    /**
     * 生日
     */
    @TableField("user_birthday")
    private String userBirthday;
    /**
     * 家庭地址
     */
//    @TableField("user_address")
//    private String userAddress;
    /**
     * 兴趣爱好
     */
//    @TableField("user_hobby")
//    private String userHobby;
    /**
     * 自我评价
     */
    @TableField("user_evaluate")
    private String userEvaluate;
    /**
     * 用户类型，1超管2社长3社团管理4社员
     */
    @TableField("user_type")
    private Integer userType;
    /**
     * 1启用0禁用
     */
    @TableField("user_status")
    private Integer userStatus;
    /**
     * 所属社团id
     */
//    @TableField("user_org")
//    private Integer userOrg;
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

    public ManUser setId(Integer id) {
        this.id = id;
        return this;
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

    public ManUser setUserCode(String userCode) {
        this.userCode = userCode;return this;
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
//
//    public String getUserAddress() {
//        return userAddress;
//    }
//
//    public void setUserAddress(String userAddress) {
//        this.userAddress = userAddress;
//    }
//
//    public String getUserHobby() {
//        return userHobby;
//    }
//
//    public void setUserHobby(String userHobby) {
//        this.userHobby = userHobby;
//    }

    public String getUserEvaluate() {
        return userEvaluate;
    }

    public void setUserEvaluate(String userEvaluate) {
        this.userEvaluate = userEvaluate;
    }

    public Integer getUserType() {
        return userType;
    }

    public ManUser setUserType(Integer userType) {
        this.userType = userType;
        return this;
    }

    public Integer getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(Integer userStatus) {
        this.userStatus = userStatus;
    }

//    public Integer getUserOrg() {
//        return userOrg;
//    }
//
//    public void setUserOrg(Integer userOrg) {
//        this.userOrg = userOrg;
//    }

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


}
