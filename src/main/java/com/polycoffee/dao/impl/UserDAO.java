package com.polycoffee.dao.impl;

import java.util.List;
import java.util.UUID;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import com.polycoffee.dao.IUserDAO;
import com.polycoffee.entity.Users;
import com.polycoffee.utils.XJPA;

public class UserDAO implements IUserDAO {

    @Override
    public Users findByUsername(String username) {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT u FROM Users u WHERE u.username = :uname AND u.active = true";
            TypedQuery<Users> query = em.createQuery(jpql, Users.class);
            query.setParameter("uname", username);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public Users findByEmail(String email) {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT u FROM Users u WHERE u.email = :email AND u.active = true";
            TypedQuery<Users> query = em.createQuery(jpql, Users.class);
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public Users findByResetToken(String token) {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT u FROM Users u WHERE u.resetToken = :token AND u.resetTokenExpiry > :now";
            TypedQuery<Users> query = em.createQuery(jpql, Users.class);
            query.setParameter("token", token);
            query.setParameter("now", java.time.LocalDateTime.now());
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Users> findAll() {
        EntityManager em = XJPA.createEntityManager();
        try {
            TypedQuery<Users> query = em.createQuery("SELECT u FROM Users u", Users.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Users findById(UUID id) {
        EntityManager em = XJPA.createEntityManager();
        try {
            return em.find(Users.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void create(Users entity) {
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
    public void update(Users entity) {
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
            Users entity = em.find(Users.class, id);
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
    public List<Users> searchAndPaginate(String name, String email, Boolean active, int page, int pageSize) {
        EntityManager em = XJPA.createEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT u FROM Users u WHERE 1=1");
            if (name != null && !name.isEmpty()) {
                jpql.append(" AND u.fullname LIKE :name");
            }
            if (email != null && !email.isEmpty()) {
                jpql.append(" AND u.email LIKE :email");
            }
            if (active != null) {
                jpql.append(" AND u.active = :active");
            }

            TypedQuery<Users> query = em.createQuery(jpql.toString(), Users.class);
            if (name != null && !name.isEmpty()) {
                query.setParameter("name", "%" + name + "%");
            }
            if (email != null && !email.isEmpty()) {
                query.setParameter("email", "%" + email + "%");
            }
            if (active != null) {
                query.setParameter("active", active);
            }

            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);

            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countSearch(String name, String email, Boolean active) {
        EntityManager em = XJPA.createEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT COUNT(u) FROM Users u WHERE 1=1");
            if (name != null && !name.isEmpty()) {
                jpql.append(" AND u.fullname LIKE :name");
            }
            if (email != null && !email.isEmpty()) {
                jpql.append(" AND u.email LIKE :email");
            }
            if (active != null) {
                jpql.append(" AND u.active = :active");
            }

            TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
            if (name != null && !name.isEmpty()) {
                query.setParameter("name", "%" + name + "%");
            }
            if (email != null && !email.isEmpty()) {
                query.setParameter("email", "%" + email + "%");
            }
            if (active != null) {
                query.setParameter("active", active);
            }

            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}