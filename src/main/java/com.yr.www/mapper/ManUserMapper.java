package com.yr.www.mapper;

import com.yr.www.entity.ManUser;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.yr.www.entity.dto.ManUserDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author yr123
 * @since 2018-05-22
 */
public interface ManUserMapper extends BaseMapper<ManUser> {

    List<ManUserDto> selectUserDtoList();

    List<ManUser> selectListByIds(@Param("userIds")List<Integer> userIds);
}
