package com.polycoffee.dao.impl;

import java.lang.module.ModuleDescriptor.Builder;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import com.polycoffee.dao.ICategoryDAO;
import com.polycoffee.entity.Categories;
import com.polycoffee.utils.XJPA;

public class CategoryDAO implements ICategoryDAO {

    @Override
    public List<Categories> findAll() {
        EntityManager em = XJPA.createEntityManager();
        try {
            TypedQuery<Categories> query = em.createQuery("SELECT c FROM Categories c", Categories.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Categories findById(Long id) {
        EntityManager em = XJPA.createEntityManager();
        try {
            return em.find(Categories.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void create(Categories entity) {
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
    public void update(Categories entity) {
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
            Categories entity = em.find(Categories.class, id);
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

    public static void main(String[] args) {
        var c = Categories.builder()
                .name("Đồ uống").description("Thư mục đồ uống")
                .build();

        // new CategoryDAO().create(c);

        System.out.println(new CategoryDAO().findAll());

    }

}
