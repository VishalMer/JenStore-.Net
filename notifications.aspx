<%@ Page Title="" Language="C#" MasterPageFile="~/notifications.Master" AutoEventWireup="true" CodeBehind="notifications.aspx.cs" Inherits="JenStore.notifications1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Notifications - JenStore</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="icon" href="img/favicon.png" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="css/style-contact.css">
        <link rel="stylesheet" type="text/css" href="css/style-res-contact.css">
        <link rel="stylesheet" type="text/css" href="css/style-fix-nav.css">
        <link rel="stylesheet" type="text/css" href="css/style-form-search-mobile.css">

        <!-- GG FONT -->
        <link href="https://fonts.googleapis.com/css?family=Abril+Fatface" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: #f8f9fa;
            }

            .banner{
                padding-bottom: 15px;
            }
            .notification-container {
                padding: 20px 0;
                min-height: 70vh;
            }

            .notification-header {
                background: #f8f9fa;
                color: #333;
                padding: 30px 0 10px 0;
                margin-bottom: 0px;
                border-bottom: 1px solid #e9ecef;
            }

                .notification-header h1 {
                    color: #333;
                    font-weight: 600;
                }

                .notification-header p {
                    color: #666;
                    margin: 0;
                }

            .notification-tabs {
                background: white;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
                overflow: hidden;
            }

            .tab-buttons {
                display: flex;
                border-bottom: 2px solid #e9ecef;
                background: #f8f9fa;
                padding: 0;
            }

            .tab-button {
                flex: 1;
                padding: 20px 24px;
                background: transparent;
                border: none;
                font-size: 15px;
                font-weight: 500;
                color: #6c757d;
                cursor: pointer;
                transition: all 0.3s ease;
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
                border-radius: 0;
            }

                .tab-button:hover:not(.active) {
                    color: #495057;
                    background: rgba(255, 255, 255, 0.7);
                }

                .tab-button i {
                    font-size: 17px;
                    transition: transform 0.3s ease;
                }

                .tab-button:hover:not(.active) i {
                    transform: scale(1.1);
                }

                .tab-button.active {
                    color: #6c757d;
                    background: white;
                    font-weight: 600;
                    box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
                    z-index: 1;
                }

                    .tab-button.active::before {
                        content: '';
                        position: absolute;
                        bottom: -2px;
                        left: 0;
                        right: 0;
                        height: 3px;
                        background: linear-gradient(90deg, #6c757d 0%, #5a6268 100%);
                        box-shadow: 0 2px 8px rgba(108, 117, 125, 0.4);
                    }

                    .tab-button.active::after {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: -2px;
                        background: white;
                        z-index: -1;
                        border-radius: 10px 10px 0 0;
                    }

                    .tab-button.active i {
                        color: #6c757d;
                    }

                    .tab-button.active .notification-badge {
                        background: #6c757d;
                        color: #fff;
                        font-weight: 600;
                        box-shadow: 0 2px 4px rgba(108, 117, 125, 0.3);
                    }

                .tab-button .notification-badge {
                    background: #dc3545;
                    color: white;
                    border-radius: 12px;
                    padding: 4px 9px;
                    font-size: 11px;
                    font-weight: 600;
                    min-width: 22px;
                    text-align: center;
                    line-height: 1.4;
                    margin-left: 0;
                    transition: all 0.3s ease;
                }

                .tab-button:hover:not(.active) .notification-badge {
                    transform: scale(1.05);
                }

            .tab-content {
                display: none;
                padding: 30px;
                background: white;
            }

                .tab-content.active {
                    display: block;
                    background: white;
                }

            .notification-item {
                background: white;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 15px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                border-left: 4px solid #ddd;
            }

                .notification-item:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 20px rgba(0,0,0,0.15);
                }

                .notification-item.unread {
                    border-left-color: #6c757d;
                    background: #f8f9fa;
                }

                .notification-item.order-update {
                    border-left-color: #28a745;
                }

                .notification-item.feedback-reply {
                    border-left-color: #ffc107;
                }

                .notification-item.admin-message {
                    border-left-color: #dc3545;
                }

            .notification-header-content {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 10px;
            }

            .notification-title {
                font-weight: 600;
                color: #333;
                margin-bottom: 5px;
            }

            .notification-time {
                color: #999;
                font-size: 12px;
            }

            .notification-message {
                color: #666;
                line-height: 1.6;
                margin-bottom: 15px;
            }

            .notification-actions {
                display: flex;
                gap: 10px;
            }

            .btn-notification {
                padding: 8px 16px;
                border: none;
                border-radius: 5px;
                font-size: 12px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-mark-read {
                background: #6c757d;
                color: white;
            }

                .btn-mark-read:hover {
                    background: #5a6268;
                }

            .btn-view-order {
                background: #007bff;
                color: white;
            }

                .btn-view-order:hover {
                    background: #0056b3;
                }

            .btn-delete {
                background: #dc3545;
                color: white;
            }

                .btn-delete:hover {
                    background: #c82333;
                }

            .notification-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 15px;
                font-size: 18px;
                color: white;
            }

                .notification-icon.order {
                    background: #28a745;
                }

                .notification-icon.feedback {
                    background: #ffc107;
                }

                .notification-icon.admin {
                    background: #dc3545;
                }

                .notification-icon.general {
                    background: #6c757d;
                }

            .notification-content {
                flex: 1;
            }

            .notification-meta {
                display: flex;
                align-items: center;
            }

            .empty-state {
                text-align: center;
                padding: 60px 20px;
                color: #666;
            }

                .empty-state i {
                    font-size: 64px;
                    color: #ddd;
                    margin-bottom: 20px;
                }

            .filter-section {
                background: white;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 30px;
                margin-top: 0;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .filter-group {
                display: flex;
                gap: 15px;
                align-items: center;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            .read-all-btn {
                margin-left: auto;
            }

            .filter-select {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
            }

            .mark-all-read {
                background: #6c757d;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 14px;
            }

                .mark-all-read:hover {
                    background: #5a6268;
                    transform: translateY(-1px);
                }

            .btn-go-back {
                background: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 14px;
                margin-right: 10px;
            }

                .btn-go-back:hover {
                    background: #0056b3;
                    transform: translateY(-1px);
                }

            .notification-badge {
                background: #dc3545;
                color: white;
                border-radius: 50%;
                padding: 2px 6px;
                font-size: 10px;
                margin-left: 5px;
            }

            .icon-menu li .fa-heart {
                font-size: 22px;
                top: 1px;
                color: black;
                padding-right: 5px !important;
            }

            .icon-menu li .fa-bell {
                font-size: 22px;
                top: 1px;
                color: black !important;
                padding-right: 5px !important;
            }

            .icon-menu li img#img-cart {
                padding-right: 5px;
            }

            .icon-menu li .fa-user {
                padding-right: 15px !important;
            }
        </style>
    </head>
    <body>
        <header class="container" id="header-v3">
            <div class="row">
                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-3 logo">
                    <a href="#">
                        <img src="img/icons/logo.png" alt="img-holiwood"></a>
                </div>
                <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12 menu-mobile">
                    <div class=" collapse navbar-collapse" id="myNavbar">
                        <%--<form class="hidden-lg hidden-md form-group form-search-mobile">
                            <input type="text" name="search" placeholder="Search here..." class="form-control">
                            <button type="submit">
                                <img src="img/Search.png" alt="search" class="img-responsive">
                            </button>
                        </form>--%>
                        <ul class="nav navbar-nav menu-main">
                            <li class="menu-home"><a href="home.aspx">Home</a><figure id="home-1">
                            </figure>
                            </li>
                            <li class="blog-menu"><a href="shopping.aspx">Shopping</a><figure id="blog-1" class="hidden-sm hidden-xs">
                            </figure>
                            </li>
                            <li class="blog-menu"><a href="order-history.aspx">orders</a><figure id="blog-1" class="hidden-sm hidden-xs">
                            </figure>
                            </li>
                            <li class="blog-menu"><a href="aboutus.aspx">About Us</a><figure id="blog-1" class="hidden-sm hidden-xs">
                            </figure>
                            </li>
                            <li class="contact-menu"><a href="contact.aspx">Contact</a><figure id="contact-1" class="hidden-sm hidden-xs">
                            </figure>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-10 col-xs-9">
                    <ul class="nav navbar-nav navbar-right icon-menu">
                        <li class="icon-notification hidden-sm hidden-xs">
                            <a href="notifications.aspx"><i class="fas fa-bell" style="color: #e74c3c !important"></i></a>
                        </li>
                        <li class="icon-wishlist hidden-sm hidden-xs"><a href="wishlist.aspx"><i class="far fa-heart"></i></a></li>
                        <li class="cart-menu">
                            <a href="shopping-cart.aspx">
                                <img src="img/icons/cart.png" id="img-cart" alt="img-holiwood"></a>
                        </li>
                        <li class="icon-user hidden-sm hidden-xs"><a href="user-dashboard.aspx"><i class="far fa-user"></i></a></li>
                    </ul>
                </div>
                <div class="navbar-header mobile-menu">
                    <button type="button" class="navbar-toggle btn-menu-mobile" data-toggle="collapse" data-target="#myNavbar">
                        <i class="fas fa-bars"></i>
                    </button>
                </div>
            </div>
        </header>
        <main>
            <div class="content-search">
                <div class="container container-100">
                    <i class="far fa-times-circle" id="close-search"></i>
                    <h3 class="text-center">what are your looking for ?</h3>
                    <form method="get" action="/search" role="search" style="position: relative;">
                        <input type="text" class="form-control control-search" value="" autocomplete="off" placeholder="Enter Search ..." aria-label="SEARCH" name="q">
                        <button class="button_search" type="submit">
                            search
                        </button>
                    </form>
                </div>
            </div>
            <div class="banner">
                <div class="container">
                    <figure id="banner-about">
                        <a href="#">
                            <img src="img/backgounds/1350x500.png" class="img-responsive" alt="img-holiwood"></a>
                    </figure>
                    <div class="title-banner">
                        <h1>Notifications</h1>
                        <p>
                            Stay updated with your orders, messages, and important updates from JenStore
                        </p>
                    </div>
                </div>
            </div>
            <div class="notification-container">
                <div class="container">

                    <!-- Filter Section -->
                    <div class="filter-section">
                        <div class="filter-group">
                            <select class="filter-select" id="statusFilter">
                                <option value="all">All Notifications</option>
                                <option value="unread">Unread Only</option>
                                <option value="read">Read Only</option>
                            </select>
                            <select class="filter-select" id="typeFilter">
                                <option value="all">All Types</option>
                                <option value="order">Order Updates</option>
                                <option value="feedback">Feedback Replies</option>
                                <option value="admin">Admin Messages</option>
                                <option value="general">General</option>
                            </select>
                            <select class="filter-select" id="timeFilter">
                                <option value="all">All Time</option>
                                <option value="today">Today</option>
                                <option value="week">This Week</option>
                                <option value="month">This Month</option>
                            </select>
                            <div class="read-all-btn">
                                <button class="mark-all-read" onclick="markAllAsRead()">
                                    <i class="fas fa-check-double"></i>Mark All as Read
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Notification Tabs -->
                    <div class="notification-tabs">
                        <div class="tab-buttons">
                            <button class="tab-button active" onclick="switchTab('orders')">
                                <i class="fas fa-shopping-cart"></i>Order Updates <span class="notification-badge" id="orderBadge">3</span>
                            </button>
                            <button class="tab-button" onclick="switchTab('general')">
                                <i class="fas fa-bell"></i>General Notifications <span class="notification-badge" id="generalBadge">5</span>
                            </button>
                        </div>

                        <!-- Order Notifications Tab -->
                        <div class="tab-content active" id="ordersTab">
                            <!-- Order Notification 1 -->
                            <div class="notification-item unread order-update">
                                <div class="notification-meta">
                                    <div class="notification-icon order">
                                        <i class="fas fa-truck"></i>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header-content">
                                            <div>
                                                <div class="notification-title">
                                                    Order #ORD-001 Shipped
                                                </div>
                                                <div class="notification-time">
                                                    2 hours ago
                                                </div>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            Your order #ORD-001 has been shipped and is on its way! Track your package with tracking number: TRK123456789. Expected delivery: Tomorrow by 6 PM.
                                        </div>
                                        <div class="notification-actions">
                                            <button class="btn-notification btn-view-order" onclick="viewOrder('ORD-001')">
                                                <i class="fas fa-eye"></i>View Order
                                            </button>
                                            <button class="btn-notification btn-mark-read" onclick="markAsRead(this)">
                                                <i class="fas fa-check"></i>Mark as Read
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Order Notification 2 -->
                            <div class="notification-item order-update">
                                <div class="notification-meta">
                                    <div class="notification-icon order">
                                        <i class="fas fa-check-circle"></i>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header-content">
                                            <div>
                                                <div class="notification-title">
                                                    Order #ORD-002 Delivered
                                                </div>
                                                <div class="notification-time">
                                                    1 day ago
                                                </div>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            Great news! Your order #ORD-002 has been successfully delivered. We hope you love your purchase! Please rate your experience.
                                        </div>
                                        <div class="notification-actions">
                                            <button class="btn-notification btn-view-order" onclick="viewOrder('ORD-002')">
                                                <i class="fas fa-eye"></i>View Order
                                            </button>
                                            <button class="btn-notification btn-mark-read" onclick="markAsRead(this)">
                                                <i class="fas fa-check"></i>Mark as Read
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Order Notification 3 -->
                            <div class="notification-item unread order-update">
                                <div class="notification-meta">
                                    <div class="notification-icon order">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header-content">
                                            <div>
                                                <div class="notification-title">
                                                    Order #ORD-003 Processing
                                                </div>
                                                <div class="notification-time">
                                                    3 days ago
                                                </div>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            Your order #ORD-003 is being prepared for shipment. We'll notify you once it's on its way!
                                        </div>
                                        <div class="notification-actions">
                                            <button class="btn-notification btn-view-order" onclick="viewOrder('ORD-003')">
                                                <i class="fas fa-eye"></i>View Order
                                            </button>
                                            <button class="btn-notification btn-mark-read" onclick="markAsRead(this)">
                                                <i class="fas fa-check"></i>Mark as Read
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- General Notifications Tab -->
                        <div class="tab-content" id="generalTab">
                            <!-- Feedback Reply Notification -->
                            <div class="notification-item unread feedback-reply">
                                <div class="notification-meta">
                                    <div class="notification-icon feedback">
                                        <i class="fas fa-reply"></i>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header-content">
                                            <div>
                                                <div class="notification-title">
                                                    Reply to Your Feedback
                                                </div>
                                                <div class="notification-time">
                                                    4 hours ago
                                                </div>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            Thank you for your feedback about our delivery service. We've taken your suggestions seriously and are working on improving our delivery time estimates. We appreciate your patience and continued support!
                                        </div>
                                        <div class="notification-actions">
                                            <button class="btn-notification btn-mark-read" onclick="markAsRead(this)">
                                                <i class="fas fa-check"></i>Mark as Read
                                            </button>
                                            <button class="btn-notification btn-delete" onclick="deleteNotification(this)">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Admin Message Notification -->
                            <div class="notification-item unread admin-message">
                                <div class="notification-meta">
                                    <div class="notification-icon admin">
                                        <i class="fas fa-bullhorn"></i>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header-content">
                                            <div>
                                                <div class="notification-title">
                                                    New Spring Collection Available!
                                                </div>
                                                <div class="notification-time">
                                                    1 day ago
                                                </div>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            🌸 Spring is here! Check out our beautiful new spring flower collection with fresh seasonal blooms. Get 15% off your first order with code SPRING15. Valid until March 31st.
                                        </div>
                                        <div class="notification-actions">
                                            <button class="btn-notification btn-mark-read" onclick="markAsRead(this)">
                                                <i class="fas fa-check"></i>Mark as Read
                                            </button>
                                            <button class="btn-notification btn-delete" onclick="deleteNotification(this)">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- General Notification -->
                            <div class="notification-item general">
                                <div class="notification-meta">
                                    <div class="notification-icon general">
                                        <i class="fas fa-info-circle"></i>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header-content">
                                            <div>
                                                <div class="notification-title">
                                                    Website Maintenance Scheduled
                                                </div>
                                                <div class="notification-time">
                                                    2 days ago
                                                </div>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            We'll be performing scheduled maintenance on our website on Sunday, March 15th from 2:00 AM to 4:00 AM EST. During this time, some features may be temporarily unavailable.
                                        </div>
                                        <div class="notification-actions">
                                            <button class="btn-notification btn-mark-read" onclick="markAsRead(this)">
                                                <i class="fas fa-check"></i>Mark as Read
                                            </button>
                                            <button class="btn-notification btn-delete" onclick="deleteNotification(this)">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Feedback Reply Notification 2 -->
                            <div class="notification-item unread feedback-reply">
                                <div class="notification-meta">
                                    <div class="notification-icon feedback">
                                        <i class="fas fa-reply"></i>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header-content">
                                            <div>
                                                <div class="notification-title">
                                                    Wedding Package Inquiry Response
                                                </div>
                                                <div class="notification-time">
                                                    3 days ago
                                                </div>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            Thank you for your interest in our wedding flower packages! I've sent you a detailed proposal with pricing and options. Please let me know if you have any questions or would like to schedule a consultation.
                                        </div>
                                        <div class="notification-actions">
                                            <button class="btn-notification btn-mark-read" onclick="markAsRead(this)">
                                                <i class="fas fa-check"></i>Mark as Read
                                            </button>
                                            <button class="btn-notification btn-delete" onclick="deleteNotification(this)">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Admin Message Notification 2 -->
                            <div class="notification-item admin-message">
                                <div class="notification-meta">
                                    <div class="notification-icon admin">
                                        <i class="fas fa-gift"></i>
                                    </div>
                                    <div class="notification-content">
                                        <div class="notification-header-content">
                                            <div>
                                                <div class="notification-title">
                                                    Special Offer for You!
                                                </div>
                                                <div class="notification-time">
                                                    1 week ago
                                                </div>
                                            </div>
                                        </div>
                                        <div class="notification-message">
                                            As a valued customer, we're offering you an exclusive 20% discount on your next order. Use code VIP20 at checkout. This offer expires in 7 days!
                                        </div>
                                        <div class="notification-actions">
                                            <button class="btn-notification btn-mark-read" onclick="markAsRead(this)">
                                                <i class="fas fa-check"></i>Mark as Read
                                            </button>
                                            <button class="btn-notification btn-delete" onclick="deleteNotification(this)">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <footer>
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 logo-footer">
                        <a href="#" class="logo-bot"></a>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 copy">
                        <span>Copyright</span><i class="far fa-copyright"></i><span class="engo">2018 by EngoTheme</span>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 gmail-footer">
                        <span id="gmail-footer"><a href="#">E: Jenstore@gmail.com</a></span>
                    </div>
                </div>
            </div>
            <div class="hidden-lg hidden-md back-to-top fade">
                <i class="fas fa-caret-up"></i>
            </div>
            <div class="BG-menu">
            </div>
        </footer>

        <!-- boostrap & jquery -->
        <script src="js/jquery.min_af.js"></script>
        <script src="js/bootstrap.min_0028.js"></script>

        <!-- js file -->
        <script src="js/function-back-top.js"></script>
        <script src="js/function-sidebar.js"></script>
        <script src="js/funtion-header-v3.js"></script>
        <script src="js/function-search-v2.js"></script>

        <script>
            // Tab switching functionality
            function switchTab(tabName) {
                // Remove active class from all tabs and buttons
                document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active'));
                document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));

                // Add active class to selected tab
                document.querySelector(`[onclick="switchTab('${tabName}')"]`).classList.add('active');
                document.getElementById(tabName + 'Tab').classList.add('active');
            }

            // Mark notification as read
            function markAsRead(button) {
                const notification = button.closest('.notification-item');
                notification.classList.remove('unread');
                button.style.display = 'none';
                updateBadgeCount();
            }

            // Go back function
            function goBack() {
                // Go back to the previous page or home page
                if (document.referrer && document.referrer !== window.location.href) {
                    window.history.back();
                } else {
                    window.location.href = 'home.html';
                }
            }

            // Mark all notifications as read
            function markAllAsRead() {
                document.querySelectorAll('.notification-item.unread').forEach(item => {
                    item.classList.remove('unread');
                });
                document.querySelectorAll('.btn-mark-read').forEach(btn => {
                    btn.style.display = 'none';
                });
                updateBadgeCount();
            }

            // Delete notification
            function deleteNotification(button) {
                if (confirm('Are you sure you want to delete this notification?')) {
                    const notification = button.closest('.notification-item');
                    notification.style.transition = 'all 0.3s ease';
                    notification.style.transform = 'translateX(-100%)';
                    notification.style.opacity = '0';
                    setTimeout(() => {
                        notification.remove();
                        updateBadgeCount();
                    }, 300);
                }
            }

            // View order details
            function viewOrder(orderId) {
                alert(`Redirecting to order details for ${orderId}`);
                // In a real application, this would redirect to the order details page
                // window.location.href = `order-details.html?id=${orderId}`;
            }

            // Update badge counts
            function updateBadgeCount() {
                const orderUnread = document.querySelectorAll('#ordersTab .notification-item.unread').length;
                const generalUnread = document.querySelectorAll('#generalTab .notification-item.unread').length;

                document.getElementById('orderBadge').textContent = orderUnread;
                document.getElementById('generalBadge').textContent = generalUnread;

                // Hide badges if count is 0
                document.getElementById('orderBadge').style.display = orderUnread > 0 ? 'inline' : 'none';
                document.getElementById('generalBadge').style.display = generalUnread > 0 ? 'inline' : 'none';
            }

            // Filter functionality
            document.getElementById('statusFilter').addEventListener('change', filterNotifications);
            document.getElementById('typeFilter').addEventListener('change', filterNotifications);
            document.getElementById('timeFilter').addEventListener('change', filterNotifications);

            function filterNotifications() {
                const statusFilter = document.getElementById('statusFilter').value;
                const typeFilter = document.getElementById('typeFilter').value;
                const timeFilter = document.getElementById('timeFilter').value;

                const notifications = document.querySelectorAll('.notification-item');

                notifications.forEach(notification => {
                    let show = true;

                    // Status filter
                    if (statusFilter === 'unread' && !notification.classList.contains('unread')) {
                        show = false;
                    } else if (statusFilter === 'read' && notification.classList.contains('unread')) {
                        show = false;
                    }

                    // Type filter
                    if (typeFilter !== 'all') {
                        if (typeFilter === 'order' && !notification.classList.contains('order-update')) {
                            show = false;
                        } else if (typeFilter === 'feedback' && !notification.classList.contains('feedback-reply')) {
                            show = false;
                        } else if (typeFilter === 'admin' && !notification.classList.contains('admin-message')) {
                            show = false;
                        } else if (typeFilter === 'general' && !notification.classList.contains('general')) {
                            show = false;
                        }
                    }

                    // Time filter (simplified - in real app would check actual dates)
                    if (timeFilter === 'today') {
                        // Show only today's notifications
                        const timeText = notification.querySelector('.notification-time').textContent;
                        if (!timeText.includes('hour') && !timeText.includes('minute')) {
                            show = false;
                        }
                    }

                    notification.style.display = show ? 'block' : 'none';
                });
            }

            // Initialize badge counts on page load
            document.addEventListener('DOMContentLoaded', function () {
                updateBadgeCount();
            });
        </script>
    </body>
    </html>
</asp:Content>
