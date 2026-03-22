package com.polycoffee.dao;

import com.polycoffee.entity.Payment;
import java.util.List;

public interface PaymentDAO {
    void insert(Payment entity);
    void update(Payment entity);
    void delete(Long id);
    Payment findById(Long id);
    List<Payment> findAll();
}
