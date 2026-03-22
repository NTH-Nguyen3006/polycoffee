package com.polycoffee.dao;

import java.util.List;

public interface CRUD<K, E> {

    List<E> findAll();

    E findById(K id);

    void create(E entity);

    void update(E entity);

    void delete(K id);
}
