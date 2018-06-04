

package com.yr.www.common;



import com.yr.www.entity.ManNotice;
import com.yr.www.entity.ManOrg;
import com.yr.www.entity.dto.ManNoticeDto;
import com.yr.www.entity.dto.ManOrgDto;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
@SuppressWarnings("all")
public interface ManMapStructMapper {

    ManMapStructMapper INSTANCE = Mappers.getMapper(ManMapStructMapper.class);


    ManOrgDto ManOrgPo2Dto(ManOrg manOrg);

    ManNoticeDto ManOrgDto2Po(ManNotice notice);
}


	