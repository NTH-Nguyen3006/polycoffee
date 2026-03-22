package com.polycoffee.dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import com.polycoffee.entity.Products;
import com.polycoffee.utils.XJPA;

public class ProductsDAOImpl implements ProductsDao {
    private EntityManager em = XJPA.createEntityManager();

    @Override
    public void create(Products entity) {
        try {
            em.getTransaction().begin();
            em.persist(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        }
    }

    @Override
    public void update(Products entity) {
        try {
            em.getTransaction().begin();
            em.merge(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        }
    }

    @Override
    public void delete(int id) {
        try {
            em.getTransaction().begin();
            Products entity = em.find(Products.class, id);
            if (entity != null)
                em.remove(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        }
    }

    @Override
    public Products findById(int id) {
        return em.find(Products.class, id);
    }

    @Override
    public List<Products> findAll() {
        String jpql = "SELECT p FROM Products p";
        TypedQuery<Products> query = em.createQuery(jpql, Products.class);
        return query.getResultList();
    }

    @Override
    public List<Products> findByCategoryId(int categoryId) {
        String jpql = "SELECT p FROM Products p WHERE p.categoryId = :cid";
        TypedQuery<Products> query = em.createQuery(jpql, Products.class);
        query.setParameter("cid", categoryId);
        return query.getResultList();
    }
}