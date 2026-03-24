package com.polycoffee.dao.impl;

import java.util.List;
import java.util.UUID;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import com.polycoffee.dao.IOrdersDAO;
import com.polycoffee.entity.Orders;
import com.polycoffee.utils.XJPA;

public class OrdersDAO implements IOrdersDAO {

    @Override
    public List<Orders> findAll() {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT o FROM Orders o";
            TypedQuery<Orders> query = em.createQuery(jpql, Orders.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Orders findById(Long id) {
        EntityManager em = XJPA.createEntityManager();
        try {
            return em.find(Orders.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void create(Orders entity) {
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
    public void update(Orders entity) {
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
            Orders entity = em.find(Orders.class, id);
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
    public Orders findByCode(String code) {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT o FROM Orders o WHERE o.orderCode = :code";
            TypedQuery<Orders> query = em.createQuery(jpql, Orders.class);
            query.setParameter("code", code);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Orders> findByUserId(UUID userId) {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT o FROM Orders o WHERE o.user.id = :userId";
            TypedQuery<Orders> query = em.createQuery(jpql, Orders.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void updateStatus(Long id, String newStatus) {
        EntityManager em = XJPA.createEntityManager();
        try {
            em.getTransaction().begin();
            Orders order = em.find(Orders.class, id);
            if (order != null) {
                order.setStatus(newStatus);
                em.merge(order);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw new RuntimeException(e);
        } finally {
            em.close();
        }
    }
}

