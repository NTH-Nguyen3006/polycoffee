package com.polycoffee.dao.impl;

import java.time.LocalDateTime;
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
            String jpql = "SELECT o FROM Orders o ORDER BY o.createdAt DESC";
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
            String jpql = "SELECT o FROM Orders o WHERE o.user.id = :userId ORDER BY o.createdAt DESC";
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

    // ===================== BÀI 1: Phân trang đơn hàng =====================

    @Override
    public List<Orders> findAllPaginated(String status, int page, int pageSize) {
        EntityManager em = XJPA.createEntityManager();
        try {
            StringBuilder jpql = new StringBuilder(
                "SELECT o FROM Orders o LEFT JOIN FETCH o.user WHERE 1=1");
            if (status != null && !status.isEmpty()) {
                jpql.append(" AND o.status = :status");
            }
            jpql.append(" ORDER BY o.createdAt DESC");

            TypedQuery<Orders> query = em.createQuery(jpql.toString(), Orders.class);
            if (status != null && !status.isEmpty()) {
                query.setParameter("status", status);
            }
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countAll(String status) {
        EntityManager em = XJPA.createEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT COUNT(o) FROM Orders o WHERE 1=1");
            if (status != null && !status.isEmpty()) {
                jpql.append(" AND o.status = :status");
            }
            TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
            if (status != null && !status.isEmpty()) {
                query.setParameter("status", status);
            }
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    // ===================== BÀI 2: Top 5 sản phẩm bán chạy =====================

    @Override
    public List<Object[]> findTop5BestSelling(LocalDateTime from, LocalDateTime to) {
        EntityManager em = XJPA.createEntityManager();
        try {
            StringBuilder jpql = new StringBuilder(
                "SELECT oi.productName, SUM(oi.quantity) as totalQty, SUM(oi.price * oi.quantity) as totalRevenue " +
                "FROM OrderItem oi JOIN oi.order o " +
                "WHERE o.status <> 'CANCELLED'");
            if (from != null) {
                jpql.append(" AND o.createdAt >= :from");
            }
            if (to != null) {
                jpql.append(" AND o.createdAt <= :to");
            }
            jpql.append(" GROUP BY oi.productName ORDER BY totalQty DESC");

            TypedQuery<Object[]> query = em.createQuery(jpql.toString(), Object[].class);
            if (from != null) {
                query.setParameter("from", from);
            }
            if (to != null) {
                query.setParameter("to", to);
            }
            query.setMaxResults(5);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // ===================== BÀI 3: Thống kê doanh thu =====================

    @Override
    public List<Object[]> getRevenueByDay(LocalDateTime from, LocalDateTime to) {
        EntityManager em = XJPA.createEntityManager();
        try {
            // Returns: [date, total_amount, order_count]
            String jpql =
                "SELECT CAST(o.createdAt AS date), " +
                "SUM(o.totalAmount), COUNT(o) " +
                "FROM Orders o " +
                "WHERE o.status <> 'CANCELLED' " +
                "AND o.createdAt >= :from AND o.createdAt <= :to " +
                "GROUP BY CAST(o.createdAt AS date) " +
                "ORDER BY CAST(o.createdAt AS date)";

            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
            query.setParameter("from", from);
            query.setParameter("to", to);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Object[]> getRevenueByMonth(LocalDateTime from, LocalDateTime to) {
        EntityManager em = XJPA.createEntityManager();
        try {
            // Returns: [year, month, total_amount, order_count]
            String jpql =
                "SELECT YEAR(o.createdAt), MONTH(o.createdAt), " +
                "SUM(o.totalAmount), COUNT(o) " +
                "FROM Orders o " +
                "WHERE o.status <> 'CANCELLED' " +
                "AND o.createdAt >= :from AND o.createdAt <= :to " +
                "GROUP BY YEAR(o.createdAt), MONTH(o.createdAt) " +
                "ORDER BY YEAR(o.createdAt), MONTH(o.createdAt)";

            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
            query.setParameter("from", from);
            query.setParameter("to", to);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Object[]> getRevenueSummary(LocalDateTime from, LocalDateTime to) {
        EntityManager em = XJPA.createEntityManager();
        try {
            // Returns: [total_revenue, total_orders, avg_order_value]
            String jpql =
                "SELECT SUM(o.totalAmount), COUNT(o), AVG(o.totalAmount) " +
                "FROM Orders o " +
                "WHERE o.status <> 'CANCELLED' " +
                "AND o.createdAt >= :from AND o.createdAt <= :to";

            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
            query.setParameter("from", from);
            query.setParameter("to", to);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Object[]> findRevenueByCategory(LocalDateTime from, LocalDateTime to) {
        EntityManager em = XJPA.createEntityManager();
        try {
            String jpql = "SELECT oi.product.category.name, SUM(oi.price * oi.quantity) " +
                          "FROM OrderItem oi JOIN oi.order o " +
                          "WHERE o.status <> 'CANCELLED' " +
                          "AND o.createdAt >= :from AND o.createdAt <= :to " +
                          "GROUP BY oi.product.category.name";
            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
            query.setParameter("from", from);
            query.setParameter("to", to);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
