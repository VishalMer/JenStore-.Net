<%@ Page Title="" Language="C#" MasterPageFile="~/single-detail.Master" AutoEventWireup="true" CodeBehind="product-details.aspx.cs" Inherits="JenStore.single_detail1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Product Detail</title>
        <meta charset="utf-8">
        <!-- bootstrap vs fontawesome-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="icon" href="img/favicon.png" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="css/style-product-detail.css">
        <link rel="stylesheet" type="text/css" href="css/style-res-product-detail.css">
        <link rel="stylesheet" type="text/css" href="css/style-fix-nav.css">
        <link rel="stylesheet" type="text/css" href="css/style-form-search-mobile.css">
        <!-- slick -->
        <link rel="stylesheet" type="text/css" href="slick/slick.css">
        <link rel="stylesheet" type="text/css" href="slick/slick-theme.css">

        <!-- GG FONT -->
        <link href="https://fonts.googleapis.com/css?family=Abril+Fatface" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
        <style>
            .product-out-of-stock .product-image-category {
                cursor: not-allowed;
                filter: grayscale(100%) !important;
            }

            .img-responsive {
                min-height: 23em;
                min-width: 100%;
            }

            .related .product-title-category h5 {
                z-index: 100;
                position: absolute;
            }

            .product-category {
                margin-top: 2em;
                margin-bottom: 2em;
            }

            .bold {
                font-family: Poppins;
                font-weight: 600;
                font-size: 18px;
                color: black;
                padding-top: 5px;
            }
            .container h1{
                margin-top: 2em;
                margin-bottom: -2em;    
                font-weight: 600;
            }
            .p_description{
                margin: -1.5em 0 -1em 0;
                font-family:'poppins';
                font-size:12px !important;
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
                            <li><a href="single-detail.aspx" class="active">View Detail</a><figure id="wedding-1" class=" hidden-sm hidden-md hidden-xs">
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

                        <li class="cart-menu">
                            <a href="shopping-cart.aspx">
                                <img src="img/cart.png" id="img-cart" alt="img-holiwood"></a>
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
            <div class="container">
                <div class="menu-breadcrumb">
                    <ul class="breadcrumb">
                        <li><a href="home.aspx">Home</a></li>
                        <li><a href="shopping.aspx">SHOPPING</a></li>
                        <li><a href="#">Queen Rose - Pink</a></li>
                    </ul>
                </div>
            </div>
            <div class="product-detail">
                <div class="container">
                    <div class="row">
                        <div class="slider-for">
                            <asp:DataList ID="dlProductDetails" runat="server" OnItemCommand="prDetails_Command" RepeatLayout="Flow" Width="100%" RepeatColumns="4">
                                <ItemTemplate>
                                    <div class="product-content">
                                        <div class="col-lg-5 col-md-6 col-sm-12 col-xs-12 img-content">
                                            <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("image_url") %>' AlternateText='<%# Eval("product_name") %>' />
                                        </div>
                                        <div class="col-lg-7 col-md-6 col-sm-12 col-xs-12 detail">
                                            <h1>
                                                <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("product_name") %>' /></h1>
                                            <p class="p1">
                                                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("description") %>' />
                                            </p>
                                            <div class="star">
                                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                                                <span>
                                                    <asp:Label ID="lblRating" runat="server" Text='<%# Eval("rating_count") + " Rating(s)" %>' />
                                                    | Add Your Rating</span>
                                            </div>
                                            <div class="p_description">
                                                <p><%# Eval("description") %></p>
                                            </div>
                                            <div class="prince">
                                                <span><%# Eval("price", "{0:C}") %></span>
                                                <asp:PlaceHolder ID="phOldPrice" runat="server" Visible='<%# Eval("old_price") != DBNull.Value %>'>
                                                    <s class="strike"><%# Eval("old_price", "{0:C}") %></s>
                                                </asp:PlaceHolder>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="Quality" style="display: flex; align-items: center; gap: 20px; flex-wrap: wrap;">
                                                        <div class="input-group input-number-group">
                                                            <span class="text-qua">Quantity:</span>
                                                            <div class="input-group-button">
                                                                <span class="input-number-decrement">-</span>
                                                            </div>
                                                            <asp:TextBox ID="txtQuantity" runat="server" CssClass="input-number" TextMode="Number" Text="1"></asp:TextBox>
                                                            <div class="input-group-button">
                                                                <span class="input-number-increment">+</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="add-cart" style="margin-top: 15px;">
                                                <asp:LinkButton ID="btnAddToCart" runat="server" CssClass="list-icon icon-2" CommandName="AddToCart" CommandArgument='<%# Eval("product_id") %>'><i class="fas fa-shopping-basket"></i></asp:LinkButton>
                                                <asp:LinkButton ID="btnAddToWishlist" runat="server" CssClass="list-icon icon-2" CommandName="AddToWishlist" CommandArgument='<%# Eval("product_id") %>'>
                                                    <i class='<%# (Convert.ToInt32(Eval("IsInWishlist")) == 1) ? "fas fa-heart" : "far fa-heart" %>' 
                                                    style='<%# (Convert.ToInt32(Eval("IsInWishlist")) == 1) ? "color: red;" : "" %>'></i>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>
                </div>

                <%-------------Rlated products-------------%>
                <div class="related">
                    <div class="container">
                        <h1>Related Products</h1>
                        <div class="row rlated-contailner">

                            <asp:DataList ID="dlRelatedProducts" runat="server"
                                RepeatColumns="4"
                                RepeatDirection="Horizontal"
                                OnItemCommand="relProCommand">
                                <ItemTemplate>
                                    <div class='col-lg-3 col-md-3 col-sm-6 col-xs-6 product-category <%# Convert.ToInt32(Eval("stock_quantity")) <= 0 ? "product-out-of-stock" : "" %>'>
                                        <div class="product-image-category" style="width: 268px; display: inline-block;">
                                            <figure class='<%# Eval("badge")?.ToString().ToLower() %>'>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="ViewProduct" CommandArgument='<%# Eval("product_id") %>'>
                                                    <img src='<%# Eval("image_url") %>' class="img-responsive" alt='<%# Eval("product_name") %>' style="width: 100px; height: 100px;" />
                                                </asp:LinkButton>
                                            </figure>
                                            <div class="product-icon-category">
                                                <%--<a href="#"><i class="fas fa-shopping-basket"></i></a><a href="#"><i class="far fa-heart"></i></a>--%>
                                                <asp:LinkButton ID="btnViewProduct" runat="server" CommandName="ViewProduct" CommandArgument='<%# Eval("product_id") %>'><i class="far fa-eye"></i></asp:LinkButton>
                                                <%--<asp:LinkButton ID="btnAddToCart" runat="server" CssClass="list-icon icon-2" CommandName="AddToCart" CommandArgument='<%# Eval("product_id") %>'><i class="fas fa-shopping-basket"></i></asp:LinkButton>--%>
                                                <asp:LinkButton ID="LinkButton3" runat="server" CommandName="AddToCart" CommandArgument='<%# Eval("product_id") %>'
    Enabled='<%# Convert.ToInt32(Eval("stock_quantity")) > 0 %>'><i class="fas fa-shopping-basket"></i></asp:LinkButton>

                                                <asp:LinkButton ID="btnAddToWishlist" runat="server" CssClass="list-icon icon-2" CommandName="AddToWishlist" CommandArgument='<%# Eval("product_id") %>'>
                                                <i class='<%# (Convert.ToInt32(Eval("IsInWishlist")) == 1) ? "fas fa-heart" : "far fa-heart" %>' 
                                                     style='<%# (Convert.ToInt32(Eval("IsInWishlist")) == 1) ? "color: red;" : "" %>'></i>
                                                </asp:LinkButton>
                                            </div>
                                    </div>
                                    <div class="product-title-category">
                                        <h5>
                                            <div style="font-weight: 600; font-family: poppins; font-size: 15px; padding-bottom: 5px; text-align: start;">
                                                <asp:LinkButton ID="LinkButton2" runat="server" CommandName="ViewProduct" CommandArgument='<%# Eval("product_id") %>'>
                                                        <%# Eval("product_name") %>
                                                </asp:LinkButton>
                                            </div>
                                            <div class="star" style="text-align: start">
                                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                                            </div>
                                            <div class="prince" style="text-align: start">
                                                $<%# Eval("price") %><span runat="server" visible='<%# Eval("old_price") != DBNull.Value %>'>
    <s class="strike">$<%# Eval("old_price", "{0:N2}") %></s>
</span>
                                            </div>
                                        </h5>
                                    </div>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>

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
        <script src="slick/slick.js"></script>
        <!-- js file -->
        <script src="js/function-slick.js"></script>
        <script src="js/function-flower.js"></script>
        <script src="js/function-input-number.js"></script>
        <script src="js/function-select-custom.js"></script>
        <script src="js/function-back-top.js"></script>
        <script src="js/funtion-header-v3.js"></script>
        <script src="js/function-sidebar.js"></script>
        <script src="js/function-search-v2.js"></script>
    </body>
    </html>
</asp:Content>

