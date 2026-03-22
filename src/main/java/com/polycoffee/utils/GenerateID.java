package com.poly.utils;

import com.github.f4b6a3.uuid.UuidCreator;

public class GenerateID {
    public static void main(String[] args) {
        System.out.println(UUIDv7());
    }

    public static String UUIDv7() {
        return UuidCreator.getTimeOrderedEpoch().toString().replace("-", "");
    }
}
