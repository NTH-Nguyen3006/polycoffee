package com.polycoffee.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import com.polycoffee.entity.CartItems;
import com.polycoffee.utils.XJPA;

public class ICartItemsDAO implements CRUD<Integer, CartItems> {

    @Override
    public List<CartItems> findAll() {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT c FROM CartItems c";
            TypedQuery<CartItems> query = em.createQuery(jpql, CartItems.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public CartItems findById(Integer id) {
        EntityManager em = XJPA.createEntityManager();
        try {
            return em.find(CartItems.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void create(CartItems entity) {
        EntityManager em = XJPA.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw new RuntimeException(e);
        } finally {
            em.close();
        }
    }

    @Override
    public void update(CartItems entity) {
        EntityManager em = XJPA.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw new RuntimeException(e);
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Integer id) {
        EntityManager em = XJPA.createEntityManager();
        try {
            em.getTransaction().begin();
            CartItems entity = em.find(CartItems.class, id);
            if (entity != null) {
                em.remove(entity);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw new RuntimeException(e);
        } finally {
            em.close();
        }
    }

    public List<CartItems> findByCartId(int cartId) {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT c FROM CartItems c WHERE c.cartId = :cartId";
            TypedQuery<CartItems> query = em.createQuery(jpql, CartItems.class);
            query.setParameter("cartId", cartId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public CartItems findByCartIdAndProductId(int cartId, int productId) {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT c FROM CartItems c WHERE c.cartId = :cartId AND c.productId = :productId";
            TypedQuery<CartItems> query = em.createQuery(jpql, CartItems.class);
            query.setParameter("cartId", cartId);
            query.setParameter("productId", productId);
            List<CartItems> result = query.getResultList();
            return result.isEmpty() ? null : result.get(0);
        } finally {
            em.close();
        }
    }

    public void deleteByCartId(int cartId) {
        EntityManager em = XJPA.createEntityManager();
        try {
            em.getTransaction().begin();
            String jpql = "DELETE FROM CartItems c WHERE c.cartId = :cartId";
            em.createQuery(jpql).setParameter("cartId", cartId).executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw new RuntimeException(e);
        } finally {
            em.close();
        }
    }
}