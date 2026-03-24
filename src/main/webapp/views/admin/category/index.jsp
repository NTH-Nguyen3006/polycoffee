<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Category Management</h5>
                <a href="${pageContext.request.contextPath}/admin/category/create" class="btn btn-light btn-sm"><i
                        class="bi bi-plus-circle"></i> Add New Category</a>
            </div>
            <div class="card-body p-0">
                <table class="table table-hover table-bordered mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th class="text-center" style="width: 15%;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${categories}">
                            <tr>
                                <td>${item.id}</td>
                                <td>${item.name}</td>
                                <td>${item.description}</td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/admin/category/edit?id=${item.id}"
                                        class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                    <a href="${pageContext.request.contextPath}/admin/category/delete?id=${item.id}"
                                        class="btn btn-sm btn-outline-danger"
                                        onclick="return confirm('Are you sure you want to delete this category?');"><i
                                            class="bi bi-trash"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty categories}">
                            <tr>
                                <td colspan="4" class="text-center text-muted py-4">No categories found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>