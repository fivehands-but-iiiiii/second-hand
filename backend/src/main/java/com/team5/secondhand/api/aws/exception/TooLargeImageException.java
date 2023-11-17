package com.team5.secondhand.api.aws.exception;

public class TooLargeImageException extends ImageHostException {
    public TooLargeImageException(String message) {
        super(message);
    }
}
