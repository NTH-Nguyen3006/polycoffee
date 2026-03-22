package com.poly.utils;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class XJPA {
    public static EntityManagerFactory factory;
    static {
        factory = Persistence.createEntityManagerFactory("PolyCoffee");
    }

    public static EntityManager createEntityManager() {
        return factory.createEntityManager();
    }
}
