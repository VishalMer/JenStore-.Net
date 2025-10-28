<%@ Page Title="" Language="C#" MasterPageFile="~/admin-panel/orders.Master" AutoEventWireup="true" CodeBehind="orders.aspx.cs" Inherits="JenStore.admin_panel.orders1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Order Management - JenStore Admin</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="icon" href="../img/favicon.png" type="image/x-icon" />
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
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

                    .admin-nav .nav-link:hover,
                    .admin-nav .nav-link.active {
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
                padding: 40px 0;
            }

            .page-header {
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .orders-table {
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

            .order-status {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
            }

            .status-pending {
                background: #fff3cd;
                color: #856404;
            }

            .status-processing {
                background: #d1ecf1;
                color: #0c5460;
            }

            .status-shipped {
                background: #d4edda;
                color: #155724;
            }

            .status-delivered {
                background: #c3e6cb;
                color: #155724;
            }

            .status-cancelled {
                background: #f8d7da;
                color: #721c24;
            }

            .action-buttons {
                display: flex;
                gap: 8px;
            }

            .btn-view {
                background: #17a2b8;
                border: none;
                color: white;
                padding: 6px 12px;
                border-radius: 4px;
                font-size: 12px;
            }

            .btn-update {
                background: #28a745;
                border: none;
                color: white;
                padding: 6px 12px;
                border-radius: 4px;
                font-size: 12px;
            }

            .btn-view:hover {
                background: #138496;
            }

            .btn-update:hover {
                background: #218838;
            }

            .search-filters {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .filter-group {
                margin-bottom: 15px;
            }

                .filter-group:last-child {
                    margin-bottom: 0;
                }

            .filter-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 8px;
            }

            .search-box {
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 8px 15px;
                width: 100%;
            }

            .status-filter {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }

                .status-filter .btn {
                    padding: 6px 12px;
                    font-size: 12px;
                    border-radius: 20px;
                }

                    .status-filter .btn.active {
                        background: #667eea;
                        border-color: #667eea;
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
                        <h1><i class="fas fa-shopping-cart"></i>Order Management</h1>
                        <p class="mb-0">
                            Track and manage customer orders
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
                        <a href="orders.aspx" class="nav-link active"><i class="fas fa-shopping-cart"></i>Orders </a>
                        <a href="customers.aspx" class="nav-link"><i class="fas fa-users"></i>Customers </a>
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
                            <h2><i class="fas fa-shopping-cart"></i>Orders</h2>
                            <p class="mb-0">
                                Manage and track customer orders
                            </p>
                        </div>
                        <div class="col-md-6 text-right">
                            <div class="btn-group">
                                <button class="btn btn-outline-primary btn-sm">
                                    <i class="fas fa-download"></i>Export Orders
                                </button>
                                <button class="btn btn-outline-success btn-sm">
                                    <i class="fas fa-print"></i>Print Report
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Search and Filters -->
                <div class="search-filters">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="filter-group">
                                <div class="filter-label">
                                    Search Orders
                                </div>
                                <input type="text" class="search-box" placeholder="Order ID, Customer Name...">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="filter-group">
                                <div class="filter-label">
                                    Date Range
                                </div>
                                <select class="form-control">
                                    <option>All Time</option>
                                    <option>Today</option>
                                    <option>Last 7 Days</option>
                                    <option>Last 30 Days</option>
                                    <option>This Month</option>
                                    <option>Last Month</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="filter-group">
                                <div class="filter-label">
                                    Status Filter
                                </div>
                                <div class="status-filter">
                                    <button class="btn btn-outline-secondary active">
                                        All
                                    </button>
                                    <button class="btn btn-outline-warning">
                                        Pending
                                    </button>
                                    <button class="btn btn-outline-info">
                                        Processing
                                    </button>
                                    <button class="btn btn-outline-primary">
                                        Shipped
                                    </button>
                                    <button class="btn btn-outline-success">
                                        Delivered
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="filter-group">
                                <div class="filter-label">
                                    Sort By
                                </div>
                                <select class="form-control">
                                    <option>Order Date (Newest)</option>
                                    <option>Order Date (Oldest)</option>
                                    <option>Total Amount (High to Low)</option>
                                    <option>Total Amount (Low to High)</option>
                                    <option>Customer Name (A-Z)</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Orders Table -->
                <div class="orders-table">
                    <div class="table-header">
                        <h4 class="mb-0">Order List</h4>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Customer</th>
                                    <th>Order Date</th>
                                    <th>Products</th>
                                    <th>Total Amount</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>#ORD-001</strong><br>
                                        <small class="text-muted">User ID: 12345</small> </td>
                                    <td><strong>John Doe</strong><br>
                                        <small class="text-muted">john.doe@email.com</small> </td>
                                    <td><strong>Dec 15, 2024</strong><br>
                                        <small class="text-muted">2:30 PM</small> </td>
                                    <td><strong>Rose Bouquet</strong><br>
                                        <small class="text-muted">Qty: 1</small> </td>
                                    <td><strong>$89.99</strong></td>
                                    <td><span class="order-status status-pending">Pending</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-view" onclick="viewOrderDetails('ORD-001')">
                                                <i class="fas fa-eye"></i>View
                                            </button>
                                            <button class="btn-update" onclick="updateOrderStatus('ORD-001')">
                                                <i class="fas fa-edit"></i>Update
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>#ORD-002</strong><br>
                                        <small class="text-muted">User ID: 12346</small> </td>
                                    <td><strong>Jane Smith</strong><br>
                                        <small class="text-muted">jane.smith@email.com</small> </td>
                                    <td><strong>Dec 14, 2024</strong><br>
                                        <small class="text-muted">11:45 AM</small> </td>
                                    <td><strong>Yellow Tulips</strong><br>
                                        <small class="text-muted">Qty: 2</small> </td>
                                    <td><strong>$124.50</strong></td>
                                    <td><span class="order-status status-processing">Processing</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-view" onclick="viewOrderDetails('ORD-002')">
                                                <i class="fas fa-eye"></i>View
                                            </button>
                                            <button class="btn-update" onclick="updateOrderStatus('ORD-002')">
                                                <i class="fas fa-edit"></i>Update
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>#ORD-003</strong><br>
                                        <small class="text-muted">User ID: 12347</small> </td>
                                    <td><strong>Mike Johnson</strong><br>
                                        <small class="text-muted">mike.j@email.com</small> </td>
                                    <td><strong>Dec 13, 2024</strong><br>
                                        <small class="text-muted">4:20 PM</small> </td>
                                    <td><strong>Cottage Garden Mix</strong><br>
                                        <small class="text-muted">Qty: 1</small> </td>
                                    <td><strong>$67.25</strong></td>
                                    <td><span class="order-status status-shipped">Shipped</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-view" onclick="viewOrderDetails('ORD-003')">
                                                <i class="fas fa-eye"></i>View
                                            </button>
                                            <button class="btn-update" onclick="updateOrderStatus('ORD-003')">
                                                <i class="fas fa-edit"></i>Update
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>#ORD-004</strong><br>
                                        <small class="text-muted">User ID: 12348</small> </td>
                                    <td><strong>Sarah Wilson</strong><br>
                                        <small class="text-muted">sarah.w@email.com</small> </td>
                                    <td><strong>Dec 12, 2024</strong><br>
                                        <small class="text-muted">9:15 AM</small> </td>
                                    <td><strong>Winter White Bouquet</strong><br>
                                        <small class="text-muted">Qty: 1</small> </td>
                                    <td><strong>$156.75</strong></td>
                                    <td><span class="order-status status-delivered">Delivered</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-view" onclick="viewOrderDetails('ORD-004')">
                                                <i class="fas fa-eye"></i>View
                                            </button>
                                            <button class="btn-update" onclick="updateOrderStatus('ORD-004')">
                                                <i class="fas fa-edit"></i>Update
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>#ORD-005</strong><br>
                                        <small class="text-muted">User ID: 12349</small> </td>
                                    <td><strong>David Brown</strong><br>
                                        <small class="text-muted">david.b@email.com</small> </td>
                                    <td><strong>Dec 11, 2024</strong><br>
                                        <small class="text-muted">3:45 PM</small> </td>
                                    <td><strong>Queen Rose Collection</strong><br>
                                        <small class="text-muted">Qty: 1</small> </td>
                                    <td><strong>$125.00</strong></td>
                                    <td><span class="order-status status-cancelled">Cancelled</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-view" onclick="viewOrderDetails('ORD-005')">
                                                <i class="fas fa-eye"></i>View
                                            </button>
                                            <button class="btn-update" onclick="updateOrderStatus('ORD-005')">
                                                <i class="fas fa-edit"></i>Update
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Pagination -->
                <div class="text-center mt-4">
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

        <!-- Update Order Status Modal -->
        <div class="modal fade" id="updateStatusModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="fas fa-edit"></i>Update Order Status</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form id="updateStatusForm">
                        <input type="hidden" id="orderId" name="orderId">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="currentStatus">
                                    Current Status</label>
                                <input type="text" class="form-control" id="currentStatus" readonly>
                            </div>
                            <div class="form-group">
                                <label for="newStatus">
                                    New Status *</label>
                                <select class="form-control" id="newStatus" name="status" required>
                                    <option value="pending">Pending</option>
                                    <option value="processing">Processing</option>
                                    <option value="shipped">Shipped</option>
                                    <option value="delivered">Delivered</option>
                                    <option value="cancelled">Cancelled</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                Cancel
                            </button>
                            <button type="submit" class="btn btn-primary">
                                Update Status
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            function viewOrderDetails(orderId) {
                // Navigate to order details page
                window.location.href = `order-details.aspx?id=${orderId}`;
            }

            function updateOrderStatus(orderId) {
                // Get current status from the table row
                const row = event.target.closest('tr');
                const currentStatus = row.querySelector('.order-status').textContent;

                // Populate modal
                document.getElementById('orderId').value = orderId;
                document.getElementById('currentStatus').value = currentStatus;

                // Show modal
                $('#updateStatusModal').modal('show');
            }

            // Handle status update form submission
            document.getElementById('updateStatusForm').addEventListener('submit', function (e) {
                e.preventDefault();

                const formData = new FormData(this);
                const updateData = Object.fromEntries(formData);

                // Here you would typically make an API call to update the order status
                console.log('Updating order status:', updateData);

                alert('Order status updated successfully!');

                // Close modal and refresh page
                $('#updateStatusModal').modal('hide');
                location.reload();
            });

            // Status filter buttons
            document.querySelectorAll('.status-filter .btn').forEach(button => {
                button.addEventListener('click', function () {
                    // Remove active class from all buttons
                    document.querySelectorAll('.status-filter .btn').forEach(btn => btn.classList.remove('active'));
                    // Add active class to clicked button
                    this.classList.add('active');

                    // Here you would filter the orders based on selected status
                    const status = this.textContent.toLowerCase();
                    console.log('Filtering by status:', status);
                });
            });
        </script>
    </body>
    </html>
</asp:Content>
