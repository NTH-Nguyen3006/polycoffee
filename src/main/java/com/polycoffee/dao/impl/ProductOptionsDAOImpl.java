package com.polycoffee.dao.impl;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import com.polycoffee.dao.IProductOptionsDAO;
import com.polycoffee.entity.ProductOptions;
import com.polycoffee.utils.XJPA;

public class ProductOptionsDAOImpl implements IProductOptionsDAO {
    private EntityManager em = XJPA.createEntityManager();

    @Override
    public void create(ProductOptions entity) {
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
    public void update(ProductOptions entity) {
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
            ProductOptions entity = em.find(ProductOptions.class, id);
            if (entity != null)
                em.remove(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        }
    }

    @Override
    public ProductOptions findById(int id) {
        return em.find(ProductOptions.class, id);
    }

    @Override
    public List<ProductOptions> findByProductId(int productId) {
        String jpql = "SELECT o FROM ProductOptions o WHERE o.productId = :pid";
        TypedQuery<ProductOptions> query = em.createQuery(jpql, ProductOptions.class);
        query.setParameter("pid", productId);
        return query.getResultList();
    }
}