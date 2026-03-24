package com.polycoffee.dao.impl;

import java.util.List;
import java.util.UUID;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import com.polycoffee.dao.ICartItemsDAO;
import com.polycoffee.entity.CartItems;
import com.polycoffee.utils.XJPA;

public class CartItemsDAO implements ICartItemsDAO {

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
    public CartItems findById(Long id) {
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
    public void delete(Long id) {
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

    @Override
    public List<CartItems> findByCartId(UUID cartId) {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT c FROM CartItems c WHERE c.cart.id = :cartId";
            TypedQuery<CartItems> query = em.createQuery(jpql, CartItems.class);
            query.setParameter("cartId", cartId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public CartItems findByCartIdAndProductId(UUID cartId, UUID productId) {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT c FROM CartItems c WHERE c.cart.id = :cartId AND c.product.id = :productId";
            TypedQuery<CartItems> query = em.createQuery(jpql, CartItems.class);
            query.setParameter("cartId", cartId);
            query.setParameter("productId", productId);
            List<CartItems> result = query.getResultList();
            return result.isEmpty() ? null : result.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public void deleteByCartId(UUID cartId) {
        EntityManager em = XJPA.createEntityManager();
        try {
            em.getTransaction().begin();
            String jpql = "DELETE FROM CartItems c WHERE c.cart.id = :cartId";
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

