package com.team5.secondhand.temp.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class PostResponse {
    private String testTextResult;
    private String testNumberResult;

    public static PostResponse from(PostRequest postRequest) {
        return new PostResponse("RESULT = { "+postRequest.getTestText() + " }",
                "RESUT NUMBER = { " + postRequest.getTestNumber() + " }");
    }
}
