<%@ Page Title="" Language="C#" MasterPageFile="~/admin-panel/index.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="JenStore.admin_panel.index1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Admin Dashboard - JenStore</title>
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
                box-shadow: 0 6px 18px rgba(0, 114, 255, 0.35);
                transition: transform .2s ease, box-shadow .2s ease, opacity .2s ease;
            }

                .btn-store:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 24px rgba(0, 114, 255, 0.45);
                    text-decoration: none;
                    opacity: .95;
                }

            .btn-logout {
                background: linear-gradient(135deg, #ff5858 0%, #f857a6 100%);
                color: #fff !important;
                border: 0;
                border-radius: 30px;
                padding: 8px 16px;
                box-shadow: 0 6px 18px rgba(248, 87, 166, 0.35);
                transition: transform .2s ease, box-shadow .2s ease, opacity .2s ease;
            }

                .btn-logout:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 24px rgba(248, 87, 166, 0.45);
                    text-decoration: none;
                    opacity: .95;
                }

            .dashboard-container {
                padding: 40px 0;
            }

            .metric-card {
                background: white;
                border-radius: 10px;
                padding: 25px;
                margin-bottom: 30px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                text-align: center;
                transition: transform 0.3s ease;
            }

                .metric-card:hover {
                    transform: translateY(-5px);
                }

            .metric-icon {
                font-size: 40px;
                margin-bottom: 15px;
            }

            .metric-number {
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 10px;
            }

            .metric-label {
                color: #666;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .sales-card {
                border-left: 4px solid #28a745;
            }

            .orders-card {
                border-left: 4px solid #007bff;
            }

            .customers-card {
                border-left: 4px solid #ffc107;
            }

            .revenue-card {
                border-left: 4px solid #dc3545;
            }

            .sales-card .metric-icon {
                color: #28a745;
            }

            .orders-card .metric-icon {
                color: #007bff;
            }

            .customers-card .metric-icon {
                color: #ffc107;
            }

            .revenue-card .metric-icon {
                color: #dc3545;
            }

            .recent-orders {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

                .recent-orders h4 {
                    color: #333;
                    margin-bottom: 20px;
                    padding-bottom: 15px;
                    border-bottom: 2px solid #f0f0f0;
                }

            .order-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 0;
                border-bottom: 1px solid #f0f0f0;
            }

                .order-item:last-child {
                    border-bottom: none;
                }

            .order-status {
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
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

            .chart-container {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-top: 30px;
            }

            .chart-placeholder {
                height: 300px;
                background: linear-gradient(45deg, #f0f0f0 25%, transparent 25%), linear-gradient(-45deg, #f0f0f0 25%, transparent 25%), linear-gradient(45deg, transparent 75%, #f0f0f0 75%), linear-gradient(-45deg, transparent 75%, #f0f0f0 75%);
                background-size: 20px 20px;
                background-position: 0 0, 0 10px, 10px -10px, -10px 0px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #666;
                font-size: 18px;
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
                        <h1><i class="fas fa-tachometer-alt"></i> JenStore Admin Panel</h1>
                        <p class="mb-0">
                            Welcome back, Administrator
                        </p>
                    </div>
                    <div class="col-md-6 text-right">
                        <a href="../home.html" class="btn btn-store btn-sm"><i class="fas fa-home"></i> Back to Store </a> <a href="../login_register.html" class="btn btn-logout btn-sm ml-2"><i class="fas fa-sign-out-alt"></i> Logout </a>
                    </div>
                </div>
            </div>
        </header>

        <!-- Admin Navigation -->
        <nav class="admin-nav">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <a href="index.html" class="nav-link active"><i class="fas fa-tachometer-alt"></i> Dashboard </a><a href="products.html" class="nav-link"><i class="fas fa-box"></i> Products </a><a href="categories.html" class="nav-link"><i class="fas fa-tags"></i> Categories </a><a href="orders.html" class="nav-link"><i class="fas fa-shopping-cart"></i>Orders </a><a href="customers.html" class="nav-link"><i class="fas fa-users"></i>Customers </a><a href="analytics.html" class="nav-link"><i class="fas fa-chart-bar"></i>Analytics </a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="dashboard-container">
            <div class="container">
                <!-- Key Metrics -->
                <div class="row">
                    <div class="col-md-3 col-sm-6">
                        <div class="metric-card sales-card">
                            <div class="metric-icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div class="metric-number">
                                <asp:Label ID="lblTotalSales" runat="server"></asp:Label>
                            </div>
                            <div class="metric-label">
                                Total Sales
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="metric-card orders-card">
                            <div class="metric-icon">
                                <i class="fas fa-shopping-bag"></i>
                            </div>
                            <div class="metric-number">
                                <asp:Label ID="lblTotalOrders" runat="server"></asp:Label>
                            </div>
                            <div class="metric-label">
                                Total Orders
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="metric-card customers-card">
                            <div class="metric-icon">
                                <i class="fas fa-user-plus"></i>
                            </div>
                            <div class="metric-number">
                                <asp:Label ID="lblTotalCustomers" runat="server"></asp:Label>
                            </div>
                            <div class="metric-label">
                                Total Customers
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="metric-card revenue-card">
                            <div class="metric-icon">
                                <i class="fas fa-chart-line"></i>
                            </div>
                            <div class="metric-number">
                                <asp:Label ID="lblMonthlyToatal" runat="server"></asp:Label>
                            </div>
                            <div class="metric-label">
                                This Month
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts and Recent Orders -->
                <div class="row">
                    <div class="col-md-8">
                        <div class="chart-container">
                            <h4><i class="fas fa-chart-bar"></i>Sales Overview (Last 7 Days)</h4>
                            <div class="chart-placeholder">
                                <i class="fas fa-chart-bar fa-3x mb-3"></i>
                                <br>
                                Sales Chart - Last 7 Days<br>
                                <small>Chart visualization would be implemented here</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="recent-orders">
                            <h4><i class="fas fa-clock"></i>Recent Orders</h4>
                            <div class="order-item">
                                <div>
                                    <strong>#ORD-001</strong><br>
                                    <small>John Doe</small>
                                </div>
                                <div class="text-right">
                                    <div class="order-status status-pending">
                                        Pending
                                    </div>
                                    <small>$89.99</small>
                                </div>
                            </div>
                            <div class="order-item">
                                <div>
                                    <strong>#ORD-002</strong><br>
                                    <small>Jane Smith</small>
                                </div>
                                <div class="text-right">
                                    <div class="order-status status-processing">
                                        Processing
                                    </div>
                                    <small>$124.50</small>
                                </div>
                            </div>
                            <div class="order-item">
                                <div>
                                    <strong>#ORD-003</strong><br>
                                    <small>Mike Johnson</small>
                                </div>
                                <div class="text-right">
                                    <div class="order-status status-shipped">
                                        Shipped
                                    </div>
                                    <small>$67.25</small>
                                </div>
                            </div>
                            <div class="order-item">
                                <div>
                                    <strong>#ORD-004</strong><br>
                                    <small>Sarah Wilson</small>
                                </div>
                                <div class="text-right">
                                    <div class="order-status status-delivered">
                                        Delivered
                                    </div>
                                    <small>$156.75</small>
                                </div>
                            </div>
                            <div class="text-center mt-3">
                                <a href="orders.html" class="btn btn-primary btn-sm">View All Orders</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="chart-container">
                            <h4><i class="fas fa-bolt"></i>Quick Actions</h4>
                            <div class="row">
                                <div class="col-md-3 col-sm-6 text-center mb-3">
                                    <a href="add-edit-product.html" class="btn btn-success btn-lg btn-block"><i class="fas fa-plus"></i>
                                        <br>
                                        Add Product </a>
                                </div>
                                <div class="col-md-3 col-sm-6 text-center mb-3">
                                    <a href="categories.html" class="btn btn-info btn-lg btn-block"><i class="fas fa-tag"></i>
                                        <br>
                                        Manage Categories </a>
                                </div>
                                <div class="col-md-3 col-sm-6 text-center mb-3">
                                    <a href="orders.html" class="btn btn-warning btn-lg btn-block"><i class="fas fa-shipping-fast"></i>
                                        <br>
                                        Process Orders </a>
                                </div>
                                <div class="col-md-3 col-sm-6 text-center mb-3">
                                    <a href="customers.html" class="btn btn-primary btn-lg btn-block"><i class="fas fa-users"></i>
                                        <br>
                                        View Customers </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </body>
    </html>
</asp:Content>

