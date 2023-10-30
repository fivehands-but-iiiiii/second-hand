package com.team5.secondhand.api.aws.service.usecase;

import com.team5.secondhand.api.aws.exception.ImageHostException;
import com.team5.secondhand.api.aws.dto.response.ProfileImageInfo;
import org.springframework.web.multipart.MultipartFile;

public interface ProfileUpload {
    ProfileImageInfo uploadMemberProfileImage(MultipartFile request) throws ImageHostException;
}
