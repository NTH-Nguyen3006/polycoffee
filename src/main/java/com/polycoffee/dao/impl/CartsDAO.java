package com.polycoffee.dao.impl;

import java.util.List;
import java.util.UUID;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import com.polycoffee.dao.ICartsDAO;
import com.polycoffee.entity.Carts;
import com.polycoffee.utils.XJPA;

public class CartsDAO implements ICartsDAO {

    @Override
    public List<Carts> findAll() {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT c FROM Carts c";
            TypedQuery<Carts> query = em.createQuery(jpql, Carts.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Carts findById(UUID id) {
        EntityManager em = XJPA.createEntityManager();
        try {
            return em.find(Carts.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void create(Carts entity) {
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
    public void update(Carts entity) {
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
    public void delete(UUID id) {
        EntityManager em = XJPA.createEntityManager();
        try {
            em.getTransaction().begin();
            Carts entity = em.find(Carts.class, id);
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
    public List<Carts> findByUserId(UUID userId) {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT c FROM Carts c WHERE c.user.id = :userId";
            TypedQuery<Carts> query = em.createQuery(jpql, Carts.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}

