package com.team5.secondhand.application.item.controller.v2.dto;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.io.Serializable;

@Getter
@RequiredArgsConstructor
public class ItemsRequest implements Serializable {
    private final Long last;
    private final Long sellerId;
    private final Long regionId;
    private final Boolean isSales;
    private final Long categoryId;
}
