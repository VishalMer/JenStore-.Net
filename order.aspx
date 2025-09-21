<%@ Page Title="" Language="C#" MasterPageFile="~/order.Master" AutoEventWireup="true" CodeBehind="order.aspx.cs" Inherits="JenStore.order1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Order Completed</title>
        <meta charset="utf-8">
        <!-- bootstrap vs fontawesome-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="icon" href="img/favicon.png" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="css/style-about.css">
        <link rel="stylesheet" type="text/css" href="css/style-res-about.css">
        <link rel="stylesheet" type="text/css" href="css/style-faq.css">
        <link rel="stylesheet" type="text/css" href="css/style-order.css">
        <link rel="stylesheet" type="text/css" href="css/style-fix-nav.css">
        <link rel="stylesheet" type="text/css" href="css/style-form-search-mobile.css">
        <!-- slick -->

        <!-- GG FONT -->
        <link href="https://fonts.googleapis.com/css?family=Abril+Fatface" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    </head>
    <body>
        <header class="container" id="header-v3">
            <div class="row">
                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-3 logo">
                    <a href="#">
                        <img src="img/logo.png" alt="img-holiwood"></a>
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
                            <li class="shop-menu dropdown active"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Shop +</a><figure id="shop-1" class=" hidden-sm hidden-md hidden-xs">
                            </figure>
                                <div class="dropdown-menu">
                                    <div class="container container-menu">
                                        <ul class="row">
                                            <li class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                                                <ul>
                                                    <li class="col-lg-4 col-md-4 col-sm-12 col-xs-12 menu-home-lv2">
                                                        <ul>
                                                            <li><a href="#">SHOP PAGE</a> </li>
                                                            <li class="li-home li-one"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="Shopping.aspx">Shopping</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="col-lg-4 col-md-4 col-sm-12 col-xs-12 menu-home-lv2">
                                                        <ul>
                                                            <li><a href="#">CHECKING PAGE</a></li>
                                                            <li class="li-home li-one"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="shopping-cart.aspx">Shopping Cart</a></li>
                                                            <li class="li-home"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="checkout.aspx">Checkout</a></li>
                                                            <li class="li-home"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="order.aspx">Order</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="col-lg-4 col-md-4 col-sm-12 col-xs-12 menu-home-lv2">
                                                        <ul>
                                                            <li><a href="#">OTHER PAGE</a></li>
                                                            <li class="li-home li-one"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="FAQ.aspx">FAQ</a></li>
                                                            <li class="li-home"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="login_register.aspx">Login/Register</a></li>
                                                            <li class="li-home"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="page404.aspx">Page404</a></li>
                                                            <li class="li-home"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="tracking.aspx">Tracking</a></li>
                                                            <li class="li-home"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="wishlist.aspx">Wishlist</a></li>
                                                        </ul>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li class="col-lg-4 col-md-4 hidden-sm hidden-xs li-banner"><a href="#">
                                                <img src="img/340x240.png" alt="img-holiwood"></a> </li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li><a href="order.aspx" class="active">Order</a><figure id="wedding-1" class=" hidden-sm hidden-md hidden-xs">
                            </figure>
                            </li>
                            <li class="blog-menu"><a href="blog.aspx">Blog</a><figure id="blog-1" class=" hidden-sm hidden-md hidden-xs">
                            </figure>
                            </li>
                            <li class="contact-menu"><a href="contact.aspx">Contact</a><figure id="contact-1" class=" hidden-sm hidden-md hidden-xs">
                            </figure>
                            </li>
                            <li class="hidden-lg hidden-md"><a href="user-dashboard.aspx"><i class="far fa-user"></i>My Account</a></li>
                            <li>
                                <figure id="btn-close-menu" class="hidden-lg hidden-md">
                                    <i class="far fa-times-circle"></i>
                                </figure>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-10 col-xs-9">
                    <ul class="nav navbar-nav navbar-right icon-menu">
                        <li id="input-search" class="hidden-sm hidden-xs"><a href="#">
                            <img id="search-img" src="img/Search.png" alt="img-holiwood"></a> </li>
                        <li class="icon-user hidden-sm hidden-xs"><a href="user-dashboard.aspx"><i class="far fa-user"></i></a></li>
                        <li class="dropdown cart-menu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <img src="img/cart.png" id="img-cart" alt="img-holiwood"></a>
                            <div class="dropdown-menu">
                                <div class="cart-1">
                                    <div class="img-cart">
                                        <img src="img/340x420.png" class="img-responsive" alt="img-holiwood">
                                    </div>
                                    <div class="info-cart">
                                        <h1>Pink roses</h1>
                                        <span class="number">x1</span> <span class="prince-cart">$207.2</span>
                                    </div>
                                </div>
                                <div class="cart-1">
                                    <div class="img-cart">
                                        <img src="img/340x420.png" class="img-responsive" alt="img-holiwood">
                                    </div>
                                    <div class="info-cart">
                                        <h1>Eleganr by BloomNation</h1>
                                        <span class="number">x1</span> <span class="prince-cart">$207.2</span>
                                    </div>
                                </div>
                                <div class="cart-1">
                                    <div class="img-cart">
                                        <img src="img/340x420.png" class="img-responsive" alt="img-holiwood">
                                    </div>
                                    <div class="info-cart">
                                        <h1>Queen Rose - Yellow</h1>
                                        <span class="number">x1</span> <span class="prince-cart">$207.2</span>
                                    </div>
                                </div>
                                <div class="total">
                                    <span>Total:</span> <span>$621.6</span>
                                </div>
                                <div id="div-cart-menu">
                                    <a href="#">ADD TO CART</a> <a href="#" class="check">CHECK VIEW</a>
                                </div>
                            </div>
                        </li>
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
                        <h1>Order Completed</h1>
                        <p>
                            <a href="#" title="Home">Home</a><i class="fa fa-caret-right"></i>Order Completed
                        </p>
                    </div>
                </div>
            </div>
            <div class="container container-ver2 space-padding-tb-30">
                <div class="row head-cart">
                    <div class="col-md-4 space-30">
                        <div class="item active center">
                            <p class="icon">
                                01
                            </p>
                            <h3>Shopping cart</h3>
                        </div>
                    </div>
                    <!-- End col-md-4 -->
                    <div class="col-md-4 space-30">
                        <div class="item active center">
                            <p class="icon">
                                02
                            </p>
                            <h3>Check out</h3>
                        </div>
                    </div>
                    <!-- End col-md-4 -->
                    <div class="col-md-4 space-30">
                        <div class="item center active">
                            <p class="icon">
                                03
                            </p>
                            <h3>Order completed</h3>
                        </div>
                    </div>
                    <!-- End col-md-4 -->
                </div>
            </div>
            <!-- End container -->
            <div class="container container-ver2">
                <div class="box float-left order-complete center space-50">
                    <div class="icon space-20">
                        <img src="img/icon-order-complete.png" alt="icon">
                    </div>
                    <p class="box center space-50">
                        Thank you for shopping with us, your order is complete!
                    </p>
                    <div class="box">
                        <a class="link-v1 lh-50 margin-right-20 space-20 color-brand" href="#" title="HOME PAGE">HOME PAGE</a> <a class="link-v1 lh-50 rt space-20" href="#" title="CONTINUS SHOPPING">CONTINUS SHOPPING</a>
                    </div>
                </div>
            </div>

            <!-- Order Details Section -->
            <div class="container container-ver2" id="orderDetailsContainer" runat="server">
                <div class="order-details-section">
                    <div class="row">
                        <div class="col-md-12">
                            <h2 class="order-details-title">Order Details</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-6">
                            <div class="order-info-box">
                                <h3>Order Information</h3>
                                <div class="order-info-item">
                                    <span class="info-label">Order ID:</span>
                                    <span class="info-value">
                                        <asp:Label ID="lblOrderID" runat="server"></asp:Label></span>
                                </div>
                                <div class="order-info-item">
                                    <span class="info-label">Order Date:</span>
                                    <span class="info-value">
                                        <asp:Label ID="lblOrderDate" runat="server"></asp:Label></span>
                                </div>
                                <div class="order-info-item">
                                    <span class="info-label">Order Status:</span>
                                    <span class="info-value">
                                        <asp:Label ID="lblOrderStatus" runat="server"></asp:Label></span>
                                </div>
                                <div class="order-info-item">
                                    <span class="info-label">Payment Method:</span>
                                    <span class="info-value">
                                        <asp:Label ID="lblPaymentMethod" runat="server"></asp:Label></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-6">
                            <div class="order-info-box">
                                <h3>Shipping Information</h3>
                                <div class="order-info-item">
                                    <span class="info-label">Address:</span>
                                    <span class="info-value">
                                        <asp:Label ID="lblShippingAddress" runat="server"></asp:Label></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="order-summary-box">
                                <h3>Order Summary</h3>
                                <div class="order-items">
                                    <asp:Repeater ID="rptOrderItems" runat="server">
                                        <ItemTemplate>
                                            <div class="order-item">
                                                <div class="item-image">
                                                    <img src='<%# Eval("image_url") %>' alt='<%# Eval("product_name") %>' class="img-responsive">
                                                </div>
                                                <div class="item-details">
                                                    <h4><%# Eval("product_name") %></h4>
                                                    <p>Quantity: <%# Eval("quantity") %></p>
                                                    <span class="item-price"><%# Eval("price_at_purchase", "{0:C}") %></span>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <div class="order-totals">
                                    <div class="total-line">
                                        <span class="total-label">Subtotal:</span>
                                        <span class="total-value">
                                            <asp:Label ID="lblSubTotal" runat="server"></asp:Label></span>
                                    </div>
                                    <div class="total-line">
                                        <span class="total-label">Shipping:</span>
                                        <span class="total-value">
                                            <asp:Label ID="lblShipping" runat="server"></asp:Label></span>
                                    </div>
                                    <div class="total-line total-final">
                                        <span class="total-label">Total Amount:</span>
                                        <span class="total-value">
                                            <asp:Label ID="lblGrandTotal" runat="server"></asp:Label></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="order-actions">
                                <a href="#" class="btn btn-primary">Download Invoice</a> <a href="#" class="btn btn-secondary">Track Order</a> <a href="#" class="btn btn-outline">Reorder Items</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Order Details Section -->

            <!-- Order History Section -->
            <div class="container container-ver2">
                <div class="order-history-section">
                    <div class="row">
                        <div class="col-md-12">
                            <h2 class="order-history-title">Order History</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="order-history-table-container">
                                <asp:GridView ID="gvOrderHistory" runat="server"
                                    AutoGenerateColumns="False"
                                    CssClass="order-history-table"
                                    GridLines="None"
                                    AllowPaging="True"
                                    PageSize="5"
                                    OnPageIndexChanging="gvOrderHistory_PageIndexChanging"
                                    OnRowCommand="gvOrderHistory_RowCommand">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Order ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGridOrderId" runat="server" Text='<%# "#ORD-" + Eval("order_id") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="order-id" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Order Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGridOrderDate" runat="server" Text='<%# Eval("order_date", "{0:MMM dd, yyyy}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="order-date" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <span class='status-badge <%# GetStatusClass(Eval("order_status")) %>'>
                                                    <%# Eval("order_status") %>
                                                </span>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="order-status" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGridTotalAmount" runat="server" Text='<%# Eval("total_amount", "{0:C}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="order-total" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Payment Method">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGridPaymentMethod" runat="server" Text='<%# Eval("payment_method") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="payment-method" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Actions">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnViewDetails" runat="server"
                                                    CssClass="btn-view-details"
                                                    CommandName="ViewDetails"
                                                    CommandArgument='<%# Eval("order_id") %>'
                                                    Text="View Details">
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="order-actions" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="pagination-container" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="pagination-container">
                                <nav aria-label="Order history pagination">
                                    <ul class="pagination">
                                        <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">Previous</a> </li>
                                        <li class="page-item active"><a class="page-link" href="#">1</a> </li>
                                        <li class="page-item"><a class="page-link" href="#">2</a> </li>
                                        <li class="page-item"><a class="page-link" href="#">3</a> </li>
                                        <li class="page-item"><a class="page-link" href="#">Next</a> </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Order History Section -->
            <!-- End container -->
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
        <script src="js/function-shopping-cart.js"></script>
    </body>
    </html>
</asp:Content>

