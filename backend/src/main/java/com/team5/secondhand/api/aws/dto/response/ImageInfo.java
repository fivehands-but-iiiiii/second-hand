package com.team5.secondhand.api.aws.dto.response;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class ImageInfo {
    private final String imageUrl;

    public static ImageInfo create(String url) {
        return new ImageInfo(url);
    }
}
