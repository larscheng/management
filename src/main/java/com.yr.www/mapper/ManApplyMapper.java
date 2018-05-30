package com.yr.www.mapper;

import com.yr.www.entity.ManApply;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.yr.www.entity.dto.ManApplyDto;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author yr123
 * @since 2018-05-29
 */
public interface ManApplyMapper extends BaseMapper<ManApply> {

    List<ManApplyDto> selectApplyDtoList(ManApply apply);
}
