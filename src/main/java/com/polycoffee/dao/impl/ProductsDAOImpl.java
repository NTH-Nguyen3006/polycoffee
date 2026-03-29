package com.polycoffee.dao.impl;

import java.util.List;
import java.util.UUID;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import com.polycoffee.dao.IProductsDao;
import com.polycoffee.entity.Products;
import com.polycoffee.utils.XJPA;

public class ProductsDAOImpl implements IProductsDao {

    @Override
    public List<Products> findAll() {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT p FROM Products p";
            TypedQuery<Products> query = em.createQuery(jpql, Products.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Products findById(UUID id) {
        EntityManager em = XJPA.createEntityManager();
        try {
            return em.find(Products.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void create(Products entity) {
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
    public void update(Products entity) {
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
    public void delete(UUID id) {
        EntityManager em = XJPA.createEntityManager();
        try {
            em.getTransaction().begin();
            Products entity = em.find(Products.class, id);
            if (entity != null) {
                em.remove(entity);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Products> findByCategoryId(Long categoryId) {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT p FROM Products p WHERE p.category.id = :categoryId";
            TypedQuery<Products> query = em.createQuery(jpql, Products.class);
            query.setParameter("categoryId", categoryId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Products> findByName(String name) {
    EntityManager em = XJPA.createEntityManager();
    try {
        String jpql = "SELECT p FROM Products p WHERE p.name LIKE :name";
        TypedQuery<Products> query = em.createQuery(jpql, Products.class);
        query.setParameter("name", "%" + name + "%");
        return query.getResultList();
    } finally {
        em.close();
    }
}
    @Override
    public List<Products> searchAndPaginate(String name, Long categoryId, Boolean available, int page, int pageSize) {
        EntityManager em = XJPA.createEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT p FROM Products p WHERE 1=1");
            if (name != null && !name.isEmpty()) {
                jpql.append(" AND p.name LIKE :name");
            }
            if (categoryId != null) {
                jpql.append(" AND p.category.id = :categoryId");
            }
            if (available != null) {
                jpql.append(" AND p.available = :available");
            }

            TypedQuery<Products> query = em.createQuery(jpql.toString(), Products.class);
            if (name != null && !name.isEmpty()) {
                query.setParameter("name", "%" + name + "%");
            }
            if (categoryId != null) {
                query.setParameter("categoryId", categoryId);
            }
            if (available != null) {
                query.setParameter("available", available);
            }

            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);

            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countSearch(String name, Long categoryId, Boolean available) {
        EntityManager em = XJPA.createEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT COUNT(p) FROM Products p WHERE 1=1");
            if (name != null && !name.isEmpty()) {
                jpql.append(" AND p.name LIKE :name");
            }
            if (categoryId != null) {
                jpql.append(" AND p.category.id = :categoryId");
            }
            if (available != null) {
                jpql.append(" AND p.available = :available");
            }

            TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
            if (name != null && !name.isEmpty()) {
                query.setParameter("name", "%" + name + "%");
            }
            if (categoryId != null) {
                query.setParameter("categoryId", categoryId);
            }
            if (available != null) {
                query.setParameter("available", available);
            }

            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}