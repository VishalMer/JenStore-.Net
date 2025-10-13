<%@ Page Title="" Language="C#" MasterPageFile="~/admin-panel/analytics.Master" AutoEventWireup="true" CodeBehind="analytics.aspx.cs" Inherits="JenStore.admin_panel.analytics1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Analytics - JenStore Admin</title>
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
                padding: 40px 0;
            }

            .page-header {
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .metric-card {
                background: white;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

                .metric-card .label {
                    color: #666;
                    text-transform: uppercase;
                    font-size: 12px;
                    letter-spacing: 0.5px;
                }

                .metric-card .value {
                    font-size: 28px;
                    font-weight: 700;
                }

                .metric-card .trend {
                    font-size: 12px;
                }

            .trend-up {
                color: #28a745;
            }

            .trend-down {
                color: #dc3545;
            }

            .chart-container {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .chart-placeholder {
                height: 300px;
                background: repeating-linear-gradient(45deg,#f0f0f0,#f0f0f0 10px,#ffffff 10px,#ffffff 20px);
                display: flex;
                align-items: center;
                justify-content: center;
                color: #666;
                font-size: 18px;
            }

            .kpi-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }

                .kpi-list li {
                    display: flex;
                    justify-content: space-between;
                    padding: 12px 0;
                    border-bottom: 1px solid #f0f0f0;
                }

                    .kpi-list li:last-child {
                        border-bottom: none;
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
                        <h1><i class="fas fa-chart-bar"></i>Analytics</h1>
                        <p class="mb-0">
                            Performance overview and insights
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
                        <a href="index.aspx" class="nav-link"><i class="fas fa-tachometer-alt"></i>Dashboard </a><a href="products.aspx" class="nav-link"><i class="fas fa-box"></i>Products </a><a href="categories.aspx" class="nav-link"><i class="fas fa-tags"></i>Categories </a><a href="orders.aspx" class="nav-link"><i class="fas fa-shopping-cart"></i>Orders </a><a href="customers.aspx" class="nav-link"><i class="fas fa-users"></i>Customers </a><a href="analytics.aspx" class="nav-link active"><i class="fas fa-chart-bar"></i>Analytics </a>
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
                            <h2><i class="fas fa-chart-line"></i>Analytics Overview</h2>
                            <p class="mb-0">
                                Showing analytics for last 30 days
                            </p>
                        </div>
                        <div class="col-md-6 text-right">
                            <!-- Removed separate last-30-days note; now shown in subtitle -->
                        </div>
                    </div>
                </div>

                <!-- KPI Cards -->
                <div class="row">
                    <div class="col-md-3 col-sm-6">
                        <div class="metric-card">
                            <div class="label">
                                Revenue
                            </div>
                            <div class="value">
                                $24,560
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="metric-card">
                            <div class="label">
                                Orders
                            </div>
                            <div class="value">
                                342
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="metric-card">
                            <div class="label">
                                Customers
                            </div>
                            <div class="value">
                                1,245
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="metric-card">
                            <div class="label">
                                Average Order
                            </div>
                            <div class="value">
                                $71.82
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts -->
                <div class="row">
                    <div class="col-md-8">
                        <div class="chart-container">
                            <h4><i class="fas fa-chart-area"></i>Revenue Trend</h4>
                            <div class="chart-placeholder">
                                Revenue Chart Placeholder
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="chart-container">
                            <h4><i class="fas fa-percentage"></i>Conversion Funnel</h4>
                            <ul class="kpi-list">
                                <li><span>Product Views</span><strong>8,120</strong></li>
                                <li><span>Add to Cart</span><strong>2,980</strong></li>
                                <li><span>Wishlist</span><strong>1,420</strong></li>
                                <li><span>Purchases</span><strong>342</strong></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Category/Products Performance -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="chart-container">
                            <h4><i class="fas fa-tags"></i>Top Categories</h4>
                            <div class="chart-placeholder">
                                Top Categories Chart Placeholder
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="chart-container">
                            <h4><i class="fas fa-box"></i>Best Selling Products</h4>
                            <div class="chart-placeholder">
                                Best Sellers Chart Placeholder
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

