package com.polycoffee.dao.impl;

import java.util.List;
import java.util.UUID;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import com.polycoffee.dao.IProductOptionsDAO;
import com.polycoffee.entity.ProductOptions;
import com.polycoffee.utils.XJPA;

public class ProductOptionsDAOImpl implements IProductOptionsDAO {

    @Override
    public void create(ProductOptions entity) {
        EntityManager em = XJPA.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(ProductOptions entity) {
        EntityManager em = XJPA.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Long id) {
        EntityManager em = XJPA.createEntityManager();
        try {
            em.getTransaction().begin();
            ProductOptions entity = em.find(ProductOptions.class, id);
            if (entity != null)
                em.remove(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public ProductOptions findById(Long id) {
        EntityManager em = XJPA.createEntityManager();
        try {
            return em.find(ProductOptions.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<ProductOptions> findByProductId(UUID productId) {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT o FROM ProductOptions o WHERE o.productId = :pid";
            TypedQuery<ProductOptions> query = em.createQuery(jpql, ProductOptions.class);
            query.setParameter("pid", productId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}