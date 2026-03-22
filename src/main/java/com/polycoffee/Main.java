package com.polycoffee;

import com.polycoffee.utils.XJPA;

public class Main {
    public static void main(String[] args) {
        XJPA.createEntityManager();
        System.out.println("Test create database successfull");
    }
}
