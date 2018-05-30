package com.yr.www.mapper;

import com.yr.www.entity.ManNotice;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.yr.www.entity.dto.ManNoticeDto;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author yr123
 * @since 2018-05-30
 */
public interface ManNoticeMapper extends BaseMapper<ManNotice> {

    List<ManNoticeDto> selectDtoList(ManNotice manNotice);
}
