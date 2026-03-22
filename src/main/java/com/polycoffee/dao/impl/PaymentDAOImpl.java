package com.polycoffee.dao.impl;

import com.polycoffee.dao.IPaymentDAO;
import com.polycoffee.entity.Payment;
import com.polycoffee.utils.XJPA;
import javax.persistence.EntityManager;
import java.util.List;

public class PaymentDAOImpl implements IPaymentDAO {

    public void create(Payment entity) {
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
    public void update(Payment entity) {
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
            Payment entity = em.find(Payment.class, id);
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
    public Payment findById(Long id) {
        EntityManager em = XJPA.createEntityManager();
        try {
            return em.find(Payment.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Payment> findAll() {
        EntityManager em = XJPA.createEntityManager();
        try {
            return em.createQuery("SELECT p FROM Payment p", Payment.class).getResultList();
        } finally {
            em.close();
        }
    }
}
