<%@ Page Title="" Language="C#" MasterPageFile="~/admin-panel/customers.Master" AutoEventWireup="true" CodeBehind="customers.aspx.cs" Inherits="JenStore.admin_panel.customers1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Customer Management - JenStore Admin</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="icon" href="../img/favicon.png" type="image/x-icon" />
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
        <link rel="stylesheet" href="../css/admin.css">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: #f8f9fa;
            }

            .admin-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 20px 0;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .admin-nav {
                background: white;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 15px 0;
            }

                .admin-nav .nav-link {
                    color: #333;
                    font-weight: 500;
                    padding: 10px 20px;
                    margin: 0 5px;
                    border-radius: 5px;
                    transition: all 0.3s ease;
                }

                    .admin-nav .nav-link:hover, .admin-nav .nav-link.active {
                        background: #667eea;
                        color: white;
                        text-decoration: none;
                    }
            /* Header Action Buttons */
            .btn-store {
                background: linear-gradient(135deg, #00c6ff 0%, #0072ff 100%);
                color: #fff !important;
                border: 0;
                border-radius: 30px;
                padding: 8px 16px;
                box-shadow: 0 6px 18px rgba(0,114,255,.35);
                transition: transform .2s ease, box-shadow .2s ease, opacity .2s ease;
            }

                .btn-store:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 24px rgba(0,114,255,.45);
                    text-decoration: none;
                    opacity: .95;
                }

            .btn-logout {
                background: linear-gradient(135deg, #ff5858 0%, #f857a6 100%);
                color: #fff !important;
                border: 0;
                border-radius: 30px;
                padding: 8px 16px;
                box-shadow: 0 6px 18px rgba(248,87,166,.35);
                transition: transform .2s ease, box-shadow .2s ease, opacity .2s ease;
            }

                .btn-logout:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 24px rgba(248,87,166,.45);
                    text-decoration: none;
                    opacity: .95;
                }

            .content-container {
                padding: 0px 0 40px 0 !important;
            }

            .page-header {
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .users-table {
                background: white;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .table-header {
                background: #f8f9fa;
                padding: 20px;
                border-bottom: 1px solid #dee2e6;
            }

            .user-avatar {
                width: 48px;
                height: 48px;
                border-radius: 50%;
                object-fit: cover;
            }

            .action-buttons {
                display: flex;
                gap: 8px;
            }

            .btn-edit {
                background: #007bff;
                border: none;
                color: white;
                padding: 6px 12px;
                border-radius: 4px;
                font-size: 12px;
            }

            .btn-delete {
                background: #dc3545;
                border: none;
                color: white;
                padding: 6px 12px;
                border-radius: 4px;
                font-size: 12px;
            }

            .btn-edit:hover {
                background: #0056b3;
            }

            .btn-delete:hover {
                background: #c82333;
            }

            .status-badge {
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 11px;
                font-weight: 600;
            }

            .status-active {
                background: #d4edda;
                color: #155724;
            }

            .status-banned {
                background: #f8d7da;
                color: #721c24;
            }

            .status-pending {
                background: #fff3cd;
                color: #856404;
            }

            .search-box {
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 8px 15px;
                width: 300px;
            }

            .role-badge {
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 11px;
                font-weight: 600;
                background: #e2e3f3;
                color: #4338ca;
            }
        </style>
        <link rel="stylesheet" href="../css/admin.css">
    </head>
    <body>
        <!-- Admin Header -->
        <header class="admin-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h1><i class="fas fa-users"></i>Customer Management</h1>
                        <p class="mb-0">
                            View, edit, and manage customer accounts
                        </p>
                    </div>
                    <div class="col-md-6 text-right">
                        <a href="../home.aspx" class="btn btn-store btn-sm ml-2"><i class="fas fa-home"></i>Back to Store </a><a href="../login_register.aspx" class="btn btn-logout btn-sm ml-2"><i class="fas fa-sign-out-alt"></i>Logout </a>
                    </div>
                </div>
            </div>
        </header>

        <!-- Admin Navigation -->
        <nav class="admin-nav">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <a href="index.aspx" class="nav-link"><i class="fas fa-tachometer-alt"></i>Dashboard </a>
                        <a href="products.aspx" class="nav-link"><i class="fas fa-box"></i>Products </a>
                        <a href="categories.aspx" class="nav-link"><i class="fas fa-tags"></i>Categories </a>
                        <a href="orders.aspx" class="nav-link"><i class="fas fa-shopping-cart"></i>Orders </a>
                        <a href="customers.aspx" class="nav-link active"><i class="fas fa-users"></i>Customers </a>
                        <a href="feedback.aspx" class="nav-link"><i class="fas fa-comments"></i>Feedback</a>
                        <a href="notifications.aspx" class="nav-link"><i class="fas fa-bullhorn"></i>Notifications</a>
                        <a href="analytics.aspx" class="nav-link"><i class="fas fa-chart-bar"></i>Analytics </a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="content-container">
            <div class="container">
                <!-- Page Header -->
                <div class="page-header">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h2><i class="fas fa-users"></i>Customers</h2>
                            <p class="mb-0">
                                Manage your user database
                            </p>
                        </div>
                        <div class="col-md-6 text-right">
                            <input type="text" class="search-box" placeholder="Search customers by name, email...">
                        </div>
                    </div>
                </div>

                <!-- Users Table -->
                <div class="users-table">
                    <div class="table-header">
                        <h4 class="mb-0">Customer List</h4>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>User</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Joined</th>
                                    <th>Orders</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <img src="../img/115x115.jpg" alt="Avatar" class="user-avatar">
                                        <strong>John Doe</strong><br>
                                        <small class="text-muted">User ID: U-1001</small> </td>
                                    <td>john.doe@email.com</td>
                                    <td><span class="role-badge">Customer</span></td>
                                    <td>Dec 01, 2024</td>
                                    <td>5</td>
                                    <td><span class="status-badge status-active">Active</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-edit" onclick="editUser('U-1001')">
                                                <i class="fas fa-edit"></i>Edit
                                            </button>
                                            <button class="btn-delete" onclick="deleteUser('U-1001')">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="../img/115x115.png" alt="Avatar" class="user-avatar">
                                        <strong>Jane Smith</strong><br>
                                        <small class="text-muted">User ID: U-1002</small> </td>
                                    <td>jane.smith@email.com</td>
                                    <td><span class="role-badge">Customer</span></td>
                                    <td>Nov 20, 2024</td>
                                    <td>3</td>
                                    <td><span class="status-badge status-pending">Pending</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-edit" onclick="editUser('U-1002')">
                                                <i class="fas fa-edit"></i>Edit
                                            </button>
                                            <button class="btn-delete" onclick="deleteUser('U-1002')">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="../img/115x115.png" alt="Avatar" class="user-avatar">
                                        <strong>Mike Johnson</strong><br>
                                        <small class="text-muted">User ID: U-1003</small> </td>
                                    <td>mike.j@email.com</td>
                                    <td><span class="role-badge">Customer</span></td>
                                    <td>Nov 12, 2024</td>
                                    <td>7</td>
                                    <td><span class="status-badge status-active">Active</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-edit" onclick="editUser('U-1003')">
                                                <i class="fas fa-edit"></i>Edit
                                            </button>
                                            <button class="btn-delete" onclick="deleteUser('U-1003')">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="../img/115x115.png" alt="Avatar" class="user-avatar">
                                        <strong>Sarah Wilson</strong><br>
                                        <small class="text-muted">User ID: U-1004</small> </td>
                                    <td>sarah.w@email.com</td>
                                    <td><span class="role-badge">Customer</span></td>
                                    <td>Oct 30, 2024</td>
                                    <td>2</td>
                                    <td><span class="status-badge status-banned">Banned</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-edit" onclick="editUser('U-1004')">
                                                <i class="fas fa-edit"></i>Edit
                                            </button>
                                            <button class="btn-delete" onclick="deleteUser('U-1004')">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Pagination -->
                <div class="text-center mt-4" style="margin-top: 20px;">
                    <nav>
                        <ul class="pagination">
                            <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">Previous</a> </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item"><a class="page-link" href="#">Next</a> </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <!-- Edit User Modal -->
        <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="fas fa-edit"></i>Edit User</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form id="editUserForm">
                        <input type="hidden" id="editUserId" name="id">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="editUserName">
                                    Full Name *</label>
                                <input type="text" class="form-control" id="editUserName" name="name" required>
                            </div>
                            <div class="form-group">
                                <label for="editUserEmail">
                                    Email *</label>
                                <input type="email" class="form-control" id="editUserEmail" name="email" required>
                            </div>
                            <div class="form-group">
                                <label for="editUserRole">
                                    Role</label>
                                <select class="form-control" id="editUserRole" name="role">
                                    <option>Customer</option>
                                    <option>Admin</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="editUserStatus">
                                    Status</label>
                                <select class="form-control" id="editUserStatus" name="status">
                                    <option>Active</option>
                                    <option>Pending</option>
                                    <option>Banned</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                Cancel
                            </button>
                            <button type="submit" class="btn btn-primary">
                                Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            function editUser(userId) {
                // Simulate fetching user data; populate modal fields
                document.getElementById('editUserId').value = userId;
                document.getElementById('editUserName').value = 'Sample Name';
                document.getElementById('editUserEmail').value = 'sample@email.com';
                document.getElementById('editUserRole').value = 'Customer';
                const statusEl = document.getElementById('editUserStatus');
                if (statusEl) statusEl.value = 'Active';
                $('#editUserModal').modal('show');
            }

            function deleteUser(userId) {
                if (confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
                    console.log('Deleting user with ID:', userId);
                    alert('User deleted successfully!');
                    // Remove row or refresh
                }
            }

            document.getElementById('editUserForm').addEventListener('submit', function (e) {
                e.preventDefault();
                const formData = new FormData(this);
                const userData = Object.fromEntries(formData);
                console.log('Updating user:', userData);
                alert('User updated successfully!');
                $('#editUserModal').modal('hide');
                location.reload();
            });
        </script>
    </body>
    </html>
</asp:Content>
