package com.polycoffee.service;

import java.util.List;
import java.util.stream.Collectors;

import com.polycoffee.dao.ICategoryDAO;
import com.polycoffee.dao.impl.CategoryDAO;
import com.polycoffee.dto.CategoryDTO;
import com.polycoffee.entity.Categories;

public class CategoryService {

    private final ICategoryDAO categoryDAO = new CategoryDAO();

    public List<CategoryDTO> findAll() {
        return categoryDAO.findAll().stream()
                .map(c -> new CategoryDTO(c.getId(), c.getName(), c.getDescription()))
                .collect(Collectors.toList());
    }

    public CategoryDTO findById(Long id) {
        Categories c = categoryDAO.findById(id);
        if (c == null) return null;
        return new CategoryDTO(c.getId(), c.getName(), c.getDescription());
    }

    public void create(CategoryDTO dto) {
        Categories c = Categories.builder()
                .name(dto.name())
                .description(dto.description())
                .build();
        categoryDAO.create(c);
    }

    public void update(CategoryDTO dto) {
        Categories existing = categoryDAO.findById(dto.id());
        if (existing != null) {
            existing.setName(dto.name());
            existing.setDescription(dto.description());
            categoryDAO.update(existing);
        }
    }

    public void delete(Long id) {
        categoryDAO.delete(id);
    }
}
