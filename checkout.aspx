<%@ Page Title="" Language="C#" MasterPageFile="~/checkout.Master" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="JenStore.checkout1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Checkout</title>
        <meta charset="utf-8">
        <!-- bootstrap vs fontawesome-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="icon" href="img/favicon.png" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="css/style-about.css">
        <link rel="stylesheet" type="text/css" href="css/style-res-about.css">
        <link rel="stylesheet" type="text/css" href="css/style-faq.css">
        <link rel="stylesheet" type="text/css" href="css/style-checkout.css">
        <link rel="stylesheet" type="text/css" href="css/style-fix-nav.css">
        <link rel="stylesheet" type="text/css" href="css/style-form-search-mobile.css">
        <!-- slick -->

        <!-- GG FONT -->
        <link href="https://fonts.googleapis.com/css?family=Abril+Fatface" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
        <style>
            .payment-tabs {
                list-style: none;
                padding: 0;
                margin: 0;
            }

                .payment-tabs li {
                    margin-bottom: 25px;
                    padding-left: 23px;
                    position: relative;
                    cursor: pointer;
                }

                .payment-tabs input[type="radio"] {
                    display: none;
                }

                .payment-tabs li label::before {
                    content: '';
                    display: inline-block;
                    width: 12px;
                    height: 12px;
                    border: 2px solid #ccc;
                    border-radius: 50%;
                    position: absolute;
                    left: 0;
                    top: 4px;
                    transition: all 0.3s ease-in-out;
                }

                .payment-tabs input[type="radio"]:checked + label::before {
                    border-color: black;
                    background-color: black;
                }

                .payment-tabs h4 {
                    font: 600 18px / 20px "Poppins";
                    color: #000;
                    margin-top: 0;
                    margin-bottom: 5px;
                    line-height: 1.2;
                }

                .payment-tabs p {
                    font: 400 12px / 20px "Poppins";
                    color: #9d9d9d;
                    margin-top: 0;
                    margin-bottom: 0;
                    line-height: 1.5;
                }

                .payment-tabs li label {
                    display: block;
                    cursor: pointer;
                }

            .btnPlaceOrder {
                font: 700 16px / 38px "Abril Fatface" !important;
                letter-spacing: 1px;
            }

            .ErrMsg {
                color: orangered;
                font-weight: 900;
                font: 300 14px / 20px "Poppins";
            }

            .icon-menu li .fa-heart {
                padding-right: 5px !important;
            }

            .head-cart a {
                text-decoration: none;
            }
        </style>
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
                            <img src="img/1350x500.png" class="img-responsive" alt="img-holiwood"></a>
                    </figure>
                    <div class="title-banner">
                        <h1>Checkout</h1>
                        <p>
                            <a href="home.aspx" title="Home">Home</a><i class="fa fa-caret-right"></i><a href="shopping-cart.aspx" title="Shopping cart">Shopping Cart</a><i class="fa fa-caret-right"></i>Checkout
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
                            <a href="shopping-cart.aspx">
                                <h3>Shopping cart</h3>
                            </a>
                        </div>
                    </div>
                    <!-- End col-md-4 -->
                    <div class="col-md-4 space-30">
                        <div class="item active center">
                            <p class="icon">
                                02
                            </p>
                            <a href="#">
                                <h3>Check out</h3>
                            </a>
                        </div>
                    </div>
                    <!-- End col-md-4 -->
                    <div class="col-md-4 space-30">
                        <div class="item center">
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
            <div class="cart-box-container check-out">
                <div class="container container-ver2">
                    <div class="row">
                        <div class="col-md-6">
                            <h3 class="title-brand">BILLING ADDRESS</h3>

                            <div class="form-horizontal">
                                <div class="form-group">
                                    <label class="control-label">Full Name <span class="color">*</span></label>
                                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name..."></asp:TextBox>
                                    <asp:Label ID="nameErr" class="ErrMsg" runat="server" Text=""></asp:Label>
                                </div>

                                <div class="form-group">
                                    <label class="control-label">Phone<span class="color">*</span></label>
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter your phone..."></asp:TextBox>
                                    <asp:Label ID="phoneErr" class="ErrMsg" runat="server" Text=""></asp:Label>
                                </div>

                                <div class="form-group">
                                    <label class="control-label">Address<span class="color">*</span></label>
                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter your address..."></asp:TextBox>
                                    <asp:Label ID="addErr" class="ErrMsg" runat="server" Text=""></asp:Label>
                                </div>

                                <div>
                                    <div class="form-group col-md-6" style="padding-left: 0;">
                                        <label class="control-label">Town/City<span class="color">*</span></label>
                                        <asp:TextBox ID="txtTownCity" runat="server" CssClass="form-control" placeholder="Enter your Town..."></asp:TextBox>
                                        <asp:Label ID="cityErr" class="ErrMsg" runat="server" Text=""></asp:Label>
                                    </div>
                                    <div class="form-group col-md-6" style="padding-right: 0;">
                                        <label class="control-label">POSTCODE <span class="color">*</span></label>
                                        <asp:TextBox ID="txtPostcode" runat="server" CssClass="form-control" placeholder="Enter your postcode..."></asp:TextBox>
                                        <asp:Label ID="postErr" class="ErrMsg" runat="server" Text=""></asp:Label>
                                    </div>
                                </div>
                            </div>

                            <div class="payment-order box">
                                <h3 class="title-brand">PAYMENT METHOD</h3>

                                <asp:RadioButtonList ID="rblPaymentMethod" runat="server"
                                    CssClass="payment-tabs"
                                    RepeatLayout="UnorderedList">
                                    <asp:ListItem Value="Direct Bank Transfer" Selected="True">
        <h4>Direct Bank Transfer</h4>
        <p>Make your payment directly into our bank account. Please use your Order ID as the payment reference. You product won't be shipped until payment confirmation.</p>
                                    </asp:ListItem>
                                    <asp:ListItem Value="Cash on Delivery">
        <h4>Cash on Delivery</h4>
        <p>Pay with cash directly to our delivery agent when your order arrives.</p>
                                    </asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:Label ID="payErr" class="ErrMsg" runat="server" Text=""></asp:Label>

                            </div>

                            <asp:LinkButton ID="btnPlaceOrder" runat="server"
                                CssClass="link-v1 box lh-50 rt full btnPlaceOrder"
                                Text="PLACE ORDER"
                                OnClick="btnPlaceOrder_Click" />
                        </div>
                        <!-- End col-md-8 -->
                        <div class="col-md-6 space-30">
                            <div class="box">
                                <h3 class="title-brand">YOUR ORDER</h3>
                                <div class="info-order">
                                    <div class="product-name">
                                        <ul>
                                            <li class="head">
                                                <span class="name">PRODUCTS NAME</span>
                                                <span class="qty"><b>QTY</b></span>
                                                <span class="total"><b>SUB TOTAL</b></span>
                                            </li>

                                            <asp:DataList ID="dlOrderSummary" runat="server">
                                                <ItemTemplate>
                                                    <li style="width: 100%">
                                                        <span class="name"><%# Eval("product_name") %></span>
                                                        <span class="qty"><%# Eval("quantity") %></span>
                                                        <span class="total" style="margin-left: 11em;">$<%# (Convert.ToDecimal(Eval("price")) * Convert.ToInt32(Eval("quantity"))).ToString("N2") %></span>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:DataList>
                                        </ul>
                                    </div>
                                    <!-- End product-name -->
                                    <ul class="product-order">
                                        <li>
                                            <span class="left">CART SUBTOTAL</span>
                                            <span class="right">
                                                <asp:Label ID="lblSubTotal" runat="server" Text="$0.00" />
                                            </span>
                                        </li>
                                        <li>
                                            <span class="left">SHIPPING & HANDLING</span>
                                            <span class="right">
                                                <asp:Label ID="lblShipping" runat="server" Text="$0.00" />
                                            </span>
                                        </li>
                                        <li>
                                            <span class="left">ORDER TOTAL</span>
                                            <span class="right brand">
                                                <asp:Label ID="lblOrderTotal" runat="server" Text="$0.00" />
                                            </span>
                                        </li>
                                    </ul>
                                </div>
                                <!-- End info-order -->
                            </div>
                        </div>
                    </div>
                    <!-- End row -->
                </div>
                <!-- End container -->
            </div>
            <!-- End cat-box-container -->
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
        <script src="js/function-store.js"></script>
    </body>
    </html>
</asp:Content>

