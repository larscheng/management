package com.yr.www.mapper;

import com.yr.www.entity.ManUserOrg;
import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author yr123
 * @since 2018-05-28
 */
public interface ManUserOrgMapper extends BaseMapper<ManUserOrg> {

    List<ManUserOrg> selectListByOid(Integer id);

    List<ManUserOrg> selectListByUid(Integer id);
}
