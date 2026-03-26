<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">${empty user ? 'Add New User' : 'Edit User'}</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/user/${empty user ? 'create' : 'edit'}"
                            method="post">
                            <c:if test="${not empty user}">
                                <input type="hidden" name="id" value="${user.id}">
                            </c:if>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Username</label>
                                    <input type="text" class="form-control" name="username" value="${user.username}"
                                        required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" class="form-control" name="fullname" value="${user.fullname}"
                                        required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" value="${user.email}"
                                        required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Phone</label>
                                    <input type="text" class="form-control" name="phone" value="${user.phone}">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Role</label>
                                    <select class="form-select" name="role">
                                        <option value="USER" ${user.role=='USER' ? 'selected' : '' }>User</option>
                                        <option value="ADMIN" ${user.role=='ADMIN' ? 'selected' : '' }>Admin</option>
                                        <option value="EMPLOYEE" ${user.role=='EMPLOYEE' ? 'selected' : '' }>Employee
                                        </option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Status</label>
                                    <div class="form-check mt-2">
                                        <input class="form-check-input" type="checkbox" name="active" id="activeCheck"
                                            ${empty user or user.active ? 'checked' : '' }>
                                        <label class="form-check-label" for="activeCheck">Active Account</label>
                                    </div>
                                </div>
                            </div>

                            <c:if test="${empty user}">
                                <div class="mb-4">
                                    <label class="form-label">Password</label>
                                    <input type="password" class="form-control" name="password" required>
                                </div>
                            </c:if>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
                                <a href="${pageContext.request.contextPath}/admin/user"
                                    class="btn btn-secondary">Cancel</a>
                                <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Save</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>