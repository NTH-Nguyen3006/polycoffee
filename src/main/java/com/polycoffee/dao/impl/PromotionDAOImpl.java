package com.polycoffee.dao.impl;

import com.polycoffee.dao.IPromotionDAO;
import com.polycoffee.entity.Promotion;
import com.polycoffee.utils.XJPA;
import jakarta.persistence.EntityManager;
import java.util.List;

public class PromotionDAOImpl implements IPromotionDAO {

    public void create(Promotion entity) {
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
    public void update(Promotion entity) {
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
            Promotion entity = em.find(Promotion.class, id);
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
    public Promotion findById(Long id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(Promotion.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Promotion> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Promotion p", Promotion.class).getResultList();
        } finally {
            em.close();
        }
    }
}
