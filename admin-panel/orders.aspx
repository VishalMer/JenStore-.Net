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
                padding: 0px 0 40px 0 !important;
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

            /* Delivered  -> Green */
            .status-delivered {
                background: #d4edda;
                color: #155724;
            }

            /* Shipped -> Blue */
            .status-shipped {
                background: #cce5ff;
                color: #004085;
            }

            /* Processing -> Yellow */
            .status-processing {
                background: #fff3cd !important;
                color: #856404 !important;
            }

            /* Cancelled -> Red */
            .status-cancelled {
                background: #f8d7da !important;
                color: #721c24 !important;
            }

            /* Pending -> Grey/Teal */
            .status-pending {
                background: #e2e3e5 !important; /* You can also use #d1ecf1 if you prefer the teal */
                color: #383d41 !important;
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
                        <h4 class="mb-0">order list</h4>
                    </div>
                    <div class="table-responsive">

                        <asp:GridView ID="gvOrders" runat="server"
                            AutoGenerateColumns="false"
                            CssClass="table table-hover mb-0"
                            GridLines="None"
                            OnRowCommand="gvOrders_RowCommand">
                            <HeaderStyle ForeColor="#6b7280" />
                            <Columns>
                                <asp:TemplateField HeaderText="order id">
                                    <ItemTemplate>
                                        <strong>#ord-<%# Eval("order_id") %></strong><br>
                                        <small class="text-muted">user id: <%# Eval("user_id") %></small>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="customer">
                                    <ItemTemplate>
                                        <strong><%# Eval("uname") %></strong><br>
                                        <small class="text-muted"><%# Eval("email") %></small>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="order date">
                                    <ItemTemplate>
                                        <strong><%# Eval("order_date", "{0:MMM dd, yyyy}") %></strong><br>
                                        <small class="text-muted"><%# Eval("order_date", "{0:h:mm tt}") %></small>
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="products">
                                    <ItemTemplate>
                                        <strong><%# Eval("product_count") %> <%# (int)Eval("product_count") > 1 ? "products" : "product" %></strong><br>
                                        <small class="text-muted">total qty: <%# Eval("total_quantity") %></small>
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="total amount">
                                    <ItemTemplate>
                                        <strong><%# Eval("total_amount", "{0:C}") %></strong>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="status">
                                    <ItemTemplate>
                                        <span class='order-status <%# GetStatusClass(Eval("order_status")) %>'>
                                            <%# Eval("order_status") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="actions">
                                    <ItemTemplate>
                                        <div class="action-buttons">
                                            <asp:LinkButton ID="btnView" runat="server" CssClass="btn-view"
                                                CommandName="ViewOrder" CommandArgument='<%# Eval("order_id") %>'>
                                <i class="fas fa-eye"></i> view
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn-update"
                                                CommandName="OpenUpdateModal"
                                                CommandArgument='<%# Eval("order_id") + "," + Eval("order_status") %>'>
                                            <i class="fas fa-edit"></i> update
                                        </asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

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

        <!-- Order Status Modal -->
        <div class="modal fade" id="updateStatusModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="fas fa-edit"></i>Update Order Status</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="hdnOrderId" runat="server" />

                        <div class="form-group">
                            <label>Current Status</label>
                            <asp:TextBox ID="txtCurrentStatus" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>New Status *</label>
                            <asp:DropDownList ID="ddlNewStatus" runat="server" CssClass="form-control" required="true">
                                <asp:ListItem Value="pending">Pending</asp:ListItem>
                                <asp:ListItem Value="processing">Processing</asp:ListItem>
                                <asp:ListItem Value="shipped">Shipped</asp:ListItem>
                                <asp:ListItem Value="delivered">Delivered</asp:ListItem>
                                <asp:ListItem Value="cancelled">Cancelled</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <asp:Button ID="btnSaveStatus" runat="server" Text="Update Status" CssClass="btn btn-primary" OnClick="btnSaveStatus_Click" />
                    </div>

                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <%-- <script>
            function viewOrderDetails(orderId) {
                // Navigate to order details page
                window.location.href = `order-details.aspx?id=$orderId}`;
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
        </script>--%>
    </body>
    </html>
</asp:Content>
