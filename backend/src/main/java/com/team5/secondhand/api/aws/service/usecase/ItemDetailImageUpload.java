package com.team5.secondhand.api.aws.service.usecase;

import com.team5.secondhand.api.aws.exception.ImageHostException;
import com.team5.secondhand.application.item.domain.ItemDetailImage;
import com.team5.secondhand.api.aws.dto.response.ImageInfo;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ItemDetailImageUpload {
    List<ItemDetailImage> uploadItemDetailImages(List<MultipartFile> request) throws ImageHostException;

    ImageInfo uploadItemDetailImage(MultipartFile itemImages) throws ImageHostException;
}
