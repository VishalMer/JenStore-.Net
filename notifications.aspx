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

            .banner {
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
                    <a href="home.aspx">
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
                                <asp:LinkButton ID="btnMarkAllRead" runat="server" CssClass="mark-all-read" OnClick="btnMarkAllRead_Click">
                                    <i class="fas fa-check-double"></i> Mark All as Read
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>

                    <!-- Notification Tabs -->
                    <div class="notification-tabs">
                        <div class="tab-buttons">
                            <asp:LinkButton ID="tabOrders" runat="server" CssClass="tab-button active" OnClick="tab_Click" CommandName="Orders">
                                <i class="fas fa-shopping-cart"></i>Order Updates 
                       
                                <asp:Label ID="lblOrderBadge" runat="server" CssClass="notification-badge" Visible="false"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="tabGeneral" runat="server" CssClass="tab-button" OnClick="tab_Click" CommandName="General">
                                <i class="fas fa-bell"></i>General Notifications 
                       
                                <asp:Label ID="lblGeneralBadge" runat="server" CssClass="notification-badge" Visible="false"></asp:Label>
                            </asp:LinkButton>
                        </div>

                        <asp:Panel ID="pnlOrders" runat="server" CssClass="tab-content active">
                            <asp:DataList ID="dlOrderUpdates" runat="server" Width="100%" RepeatLayout="Flow" OnItemCommand="dlNotifications_ItemCommand">
                                <ItemTemplate>
                                    <div class='notification-item <%# GetUnreadClass(Eval("is_read")) %> order-update'>
                                        <div class="notification-meta">
                                            <div class="notification-icon order">
                                                <i class='<%# GetIconForType(Eval("message")) %>'></i>
                                            </div>
                                            <div class="notification-content">
                                                <div class="notification-header-content">
                                                    <div>
                                                        <div class="notification-title"><%# GetTitleForOrder(Eval("message")) %></div>
                                                        <div class="notification-time"><%# Eval("created_date", "{0:MMM dd, yyyy h:mm tt}") %></div>
                                                    </div>
                                                </div>
                                                <div class="notification-message"><%# Eval("message") %></div>
                                                <div class="notification-actions">
                                                    <asp:HyperLink ID="hlViewOrder" runat="server" CssClass="btn-notification btn-view-order"
                                                        Visible='<%# Eval("link_url") != DBNull.Value %>'
                                                        NavigateUrl='<%# Eval("link_url") %>'>
                                                <i class="fas fa-eye"></i> View Order
                                            </asp:HyperLink>
                                                    <asp:Button ID="btnMarkRead" runat="server" Text="Mark as Read" CssClass="btn-notification btn-mark-read"
                                                        CommandName="MarkRead" CommandArgument='<%# Eval("notification_id") %>'
                                                        Visible='<%# !(bool)Eval("is_read") %>' />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                            <asp:Panel ID="pnlNoOrders" runat="server" CssClass="empty-state" Visible="false">
                                <i class="fas fa-shopping-cart"></i>
                                <h3>No Order Updates</h3>
                                <p>All your order notifications will appear here.</p>
                            </asp:Panel>
                        </asp:Panel>

                        <asp:Panel ID="pnlGeneral" runat="server" CssClass="tab-content">
                            <asp:DataList ID="dlGeneralNotifications" runat="server" Width="100%" RepeatLayout="Flow" OnItemCommand="dlNotifications_ItemCommand">
                                <ItemTemplate>
                                    <div class='notification-item <%# GetUnreadClass(Eval("is_read")) %> <%# GetTypeClass(Eval("notification_type")) %>'>
                                        <div class="notification-meta">
                                            <div class='notification-icon <%# GetTypeClass(Eval("notification_type")) %>'>
                                                <i class='<%# GetIconForType(Eval("notification_type")) %>'></i>
                                            </div>
                                            <div class="notification-content">
                                                <div class="notification-header-content">
                                                    <div>
                                                        <div class="notification-title"><%# GetTitleForType(Eval("notification_type")) %></div>
                                                        <div class="notification-time"><%# Eval("created_date", "{0:MMM dd, yyyy h:mm tt}") %></div>
                                                    </div>
                                                </div>
                                                <div class="notification-message"><%# Eval("message") %></div>
                                                <div class="notification-actions">
                                                    <asp:Button ID="btnMarkRead" runat="server" Text="Mark as Read" CssClass="btn-notification btn-mark-read"
                                                        CommandName="MarkRead" CommandArgument='<%# Eval("notification_id") %>'
                                                        Visible='<%# !(bool)Eval("is_read") %>' />
                                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn-notification btn-delete"
                                                        CommandName="Delete" CommandArgument='<%# Eval("notification_id") %>'
                                                        OnClientClick="return confirm('are you sure you want to delete this notification?');" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                            <asp:Panel ID="pnlNoGeneral" runat="server" CssClass="empty-state" Visible="false">
                                <i class="fas fa-bell"></i>
                                <h3>No General Notifications</h3>
                                <p>Replies from our team and other messages will appear here.</p>
                            </asp:Panel>
                        </asp:Panel>
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

        
    </body>
    </html>
</asp:Content>
