package com.yr.www.mapper;

import com.yr.www.entity.ManOrg;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.yr.www.entity.dto.ManOrgDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author yr123
 * @since 2018-05-23
 */
public interface ManOrgMapper extends BaseMapper<ManOrg> {

    List<ManOrgDto> selectOrgDtoList();

    List<ManOrgDto> selectOrgDtoListByIds(@Param("orgIds") List<Integer> orgIds);
}
