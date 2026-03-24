<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h5 class="mb-0">User Management</h5>
                <a href="${pageContext.request.contextPath}/admin/user/create" class="btn btn-light btn-sm"><i
                        class="bi bi-plus-circle"></i> Add New User</a>
            </div>
            <div class="card-body p-0 table-responsive">
                <table class="table table-hover table-bordered mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Username</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th class="text-center" style="width: 15%;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${users}">
                            <tr>
                                <td>${item.username()}</td>
                                <td>${item.fullname()}</td>
                                <td>${item.email()}</td>
                                <td>${item.phone()}</td>
                                <td>
                                    <span class="badge bg-secondary">${item.role()}</span>
                                </td>
                                <td>
                                    <c:if test="${item.active()}"><span class="badge bg-success">Active</span></c:if>
                                    <c:if test="${not item.active()}"><span class="badge bg-danger">Inactive</span>
                                    </c:if>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/admin/user/edit?id=${item.id()}"
                                        class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                    <a href="${pageContext.request.contextPath}/admin/user/delete?id=${item.id()}"
                                        class="btn btn-sm btn-outline-danger"
                                        onclick="return confirm('Are you sure you want to delete this user?');"><i
                                            class="bi bi-trash"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty users}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">No users found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>