package com.polycoffee.dao.impl;

import com.polycoffee.dao.IOrderItemDAO;
import com.polycoffee.entity.OrderItem;
import com.polycoffee.utils.XJPA;
import jakarta.persistence.EntityManager;
import java.util.List;

public class OrderItemDAOImpl implements IOrderItemDAO {

    public void create(OrderItem entity) {
        EntityManager em = XJPA.getEntityManager();
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
    public void update(OrderItem entity) {
        EntityManager em = XJPA.getEntityManager();
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
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            OrderItem entity = em.find(OrderItem.class, id);
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
    public OrderItem findById(Long id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(OrderItem.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<OrderItem> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery("SELECT o FROM OrderItem o", OrderItem.class).getResultList();
        } finally {
            em.close();
        }
    }
}
