package com.polycoffee.utils;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class XJPA {
    public static EntityManagerFactory factory;
    static {
        factory = Persistence.createEntityManagerFactory("Java201");
    }

    public static EntityManager createEntityManager() {
        return factory.createEntityManager();
    }
}
