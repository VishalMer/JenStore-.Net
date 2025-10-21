<%@ Page Title="" Language="C#" MasterPageFile="~/user-dashboard.Master" AutoEventWireup="true" CodeBehind="user-dashboard.aspx.cs" Inherits="JenStore.user_dashboard1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>User Dashboard - JenStore</title>
        <meta charset="utf-8">
        <!-- bootstrap vs fontawesome-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="icon" href="img/favicon.png" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="css/style-about.css">
        <link rel="stylesheet" type="text/css" href="css/style-res-about.css">
        <link rel="stylesheet" type="text/css" href="css/style-faq.css">
        <link rel="stylesheet" type="text/css" href="css/style-login.css">
        <link rel="stylesheet" type="text/css" href="css/style-fix-nav.css">
        <link rel="stylesheet" type="text/css" href="css/style-form-search-mobile.css">
        <!-- slick -->

        <!-- GG FONT -->
        <link href="https://fonts.googleapis.com/css?family=Abril+Fatface" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
        <style>
            .dashboard-container {
                padding: 40px 0;
            }

            .user-info-card {
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                padding: 30px;
                margin-bottom: 30px;
            }

            .user-avatar {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
                font-size: 40px;
                color: white;
            }

            .user-details h3 {
                color: #333;
                margin-bottom: 20px;
                text-align: center;
            }

            .user-detail-item {
                display: flex;
                justify-content: space-between;
                padding: 10px 0;
                border-bottom: 1px solid #eee;
            }

                .user-detail-item:last-child {
                    border-bottom: none;
                }

            .detail-label {
                font-weight: 600;
                color: #666;
            }

            .detail-value {
                color: #333;
            }

            .shortcuts-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-top: 30px;
            }

            .shortcut-card {
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                padding: 25px;
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                cursor: pointer;
            }

                .shortcut-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
                }

            .shortcut-icon {
                font-size: 40px;
                margin-bottom: 15px;
                color: #ff6b6b;
            }

            .shortcut-title {
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 10px;
                color: #333;
            }

            .shortcut-desc {
                color: #666;
                font-size: 14px;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
                color: white;
                border-radius: 10px;
                padding: 20px;
                text-align: center;
            }

            .stat-number {
                font-size: 32px;
                font-weight: bold;
                margin-bottom: 5px;
            }

            .stat-label {
                font-size: 14px;
                opacity: 0.9;
            }

            .edit-profile-btn {
                background: #ff6b6b;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                margin-top: 20px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

                .edit-profile-btn:hover {
                    background: #ff5252;
                }

            .icon-menu li .fa-heart {
                padding-right: 5px !important;
            }
        </style>
    </head>
    <body>
        <header class="container" id="header-v3">
            <div class="row">
                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-3 logo">
                    <a href="home.aspx">
                        <img src="img/logo.png" alt="img-holiwood"></a>
                </div>
                <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12 menu-mobile">
                    <div class=" collapse navbar-collapse" id="myNavbar">

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
                        <li class="icon-wishlist hidden-sm hidden-xs"><a href="wishlist.aspx"><i class="far fa-heart"></i></a></li>
                        <li class="cart-menu">
                            <a href="shopping-cart.aspx">
                                <img src="img/cart.png" id="img-cart" alt="img-holiwood"></a>
                        </li>
                        <li class="icon-user hidden-sm hidden-xs"><a href="user-dashboard.aspx"><i class="fas fa-user" style="color: #e74c3c"></i></a></li>
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
                            <img src="img/1350x500.png" class="img-responsive" alt="img-holiwood"></a>
                    </figure>
                    <div class="title-banner">
                        <h1>User Dashboard</h1>
                        <p>
                            <a href="home.aspx" title="Home">Home</a><i class="fa fa-caret-right"></i>User Dashboard
                        </p>
                    </div>
                </div>
            </div>
            <div class="container dashboard-container">
                <div class="row">
                    <div class="col-md-4">
                        <div class="user-info-card">
                            <div class="user-avatar">
                                <i class="far fa-user"></i>
                            </div>
                            <div class="user-details">
                                <h3 id="userNameHeading" runat="server"></h3>
                                <div class="user-detail-item">
                                    <span class="detail-label">Email:</span>
                                    <span class="detail-value" id="emailVal" runat="server"></span>
                                </div>
                                <div class="user-detail-item">
                                    <span class="detail-label">Gender:</span>
                                    <span class="detail-value" id="genderVal" runat="server"></span>
                                </div>
                                <div class="user-detail-item">
                                    <span class="detail-label">Member Since:</span>
                                    <span class="detail-value" id="memberSinceVal" runat="server"></span>
                                </div>
                                <div class="user-detail-item">
                                    <span class="detail-label">Status:</span> <span class="detail-value">Active</span>
                                </div>
                                <%--Edit Profile & Logout Buttons--%>
                                <button class="edit-profile-btn" id="editProfile" style="margin-right: 8em;">
                                    <a href="edit-profile.aspx" style="color: white; text-decoration: none;">Edit Profile</a>
                                </button>
                                <asp:Button ID="Button1" CssClass="edit-profile-btn" runat="server" Style="color: white; text-decoration: none;" Text="Logout" OnClick="btnLogout_Click" />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="stats-grid">
                            <div class="stat-card">
                                <div class="stat-number">
                                    <asp:Label ID="lblTotalOrders" runat="server"></asp:Label>
                                </div>
                                <div class="stat-label">
                                    Total Orders
                                </div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number">
                                    <asp:Label ID="lblWishlistItems" runat="server"></asp:Label>
                                </div>
                                <div class="stat-label">
                                    Wishlist Items
                                </div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number">
                                    <asp:Label ID="lblTotalSpent" runat="server" Text="$0.00"></asp:Label>
                                </div>
                                <div class="stat-label">
                                    Total Spent
                                </div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number">
                                    <asp:Label ID="lblPendingOrders" runat="server" Text="Label"></asp:Label>
                                </div>
                                <div class="stat-label">
                                    Pending Orders
                                </div>
                            </div>
                        </div>

                        <div class="shortcuts-grid">
                            <div class="shortcut-card" onclick="window.location.href='shopping-cart.aspx'">
                                <div class="shortcut-icon">
                                    <i class="fas fa-shopping-cart"></i>
                                </div>
                                <div class="shortcut-title">
                                    Shopping Cart
                                </div>
                                <div class="shortcut-desc">
                                    View and manage your cart items
                                </div>
                            </div>
                            <div class="shortcut-card" onclick="window.location.href='order-history.aspx'">
                                <div class="shortcut-icon">
                                    <i class="fas fa-box"></i>
                                </div>
                                <div class="shortcut-title">
                                    My Orders
                                </div>
                                <div class="shortcut-desc">
                                    Track your order history
                                </div>
                            </div>
                            <div class="shortcut-card" onclick="window.location.href='wishlist.aspx'">
                                <div class="shortcut-icon">
                                    <i class="fas fa-heart"></i>
                                </div>
                                <div class="shortcut-title">
                                    Wishlist
                                </div>
                                <div class="shortcut-desc">
                                    Your saved favorite items
                                </div>
                            </div>
                            <div class="shortcut-card" onclick="window.location.href='tracking.aspx'">
                                <div class="shortcut-icon">
                                    <i class="fas fa-truck"></i>
                                </div>
                                <div class="shortcut-title">
                                    Track Orders
                                </div>
                                <div class="shortcut-desc">
                                    Track your current orders
                                </div>
                            </div>
                            <div class="shortcut-card" onclick="window.location.href='Shopping.aspx'">
                                <div class="shortcut-icon">
                                    <i class="fas fa-store"></i>
                                </div>
                                <div class="shortcut-title">
                                    Shop Now
                                </div>
                                <div class="shortcut-desc">
                                    Browse our latest products
                                </div>
                            </div>
                            <div class="shortcut-card" onclick="window.location.href='contact.aspx'">
                                <div class="shortcut-icon">
                                    <i class="fas fa-headset"></i>
                                </div>
                                <div class="shortcut-title">
                                    Support
                                </div>
                                <div class="shortcut-desc">
                                    Get help and contact us
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="info-footer">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6">
                                <h3>About</h3>
                                <ul>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">News & Stories</a></li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">History</a> </li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Our Studio</a></li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Shop</a></li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Stockists</a></li>
                                </ul>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6">
                                <h3>Customer sevices</h3>
                                <ul>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Contact Us</a></li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Trade Services</a></li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Login/Register</a></li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Delivery & Returns</a></li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">FAQs</a></li>
                                </ul>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6">
                                <h3>Store</h3>
                                <ul>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Shop</a></li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Wedding</a></li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Birthday</a></li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Women's day</a></li>
                                </ul>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6">
                                <h3>Shop collection</h3>
                                <ul>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">New Arrivals</a></li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Hot</a></li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Sale</a></li>
                                    <li><i class="fas fa-long-arrow-alt-right"></i><a href="#">Deal of the day</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 social">
                            <p>
                                CONNECT WITH US:
                            </p>
                            <a href="#" id="link-insta"></a><a href="#" id="link-fb"></a><a href="#" id="link-tw"></a><a href="#" id="link-sky"></a>
                            <h1>Newsletter</h1>
                            <h2>Sign up for our mailing list to get latest updates and offers</h2>
                            <form class="form-group" action="mail" method="post">
                                <input type="text" name="input-mail" placeholder="Your mail here" class="input-lg">
                                <button type="submit">
                                    <img src="img/Send.png" alt="img-holiwood">
                                </button>
                            </form>
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
    </body>
    </html>
</asp:Content>
