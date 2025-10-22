<%@ Page Title="" Language="C#" MasterPageFile="~/shopping-cart.Master" AutoEventWireup="true" CodeBehind="shopping-cart.aspx.cs" Inherits="JenStore.shopping_cart1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Shopping Cart</title>
        <meta charset="utf-8">
        <!-- bootstrap vs fontawesome-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="icon" href="../img/favicon.png" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="../css/style-about.css">
        <link rel="stylesheet" type="text/css" href="../css/style-res-about.css">
        <link rel="stylesheet" type="text/css" href="../css/style-faq.css">
        <link rel="stylesheet" type="text/css" href="../css/style-shopping.css">
        <link rel="stylesheet" type="text/css" href="../css/style-fix-nav.css">
        <link rel="stylesheet" type="text/css" href="../css/style-form-search-mobile.css">
        <!-- slick -->

        <!-- GG FONT -->
        <link href="https://fonts.googleapis.com/css?family=Abril+Fatface" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
        <style>
            .fa-minus {
                margin-right: -30px;
                position: relative;
                z-index: 20 !important;
                color: black;
            }

            .fa-plus {
                margin-left: -30px;
                position: relative;
                z-index: 20 !important;
                color: black;
            }

            .cart-table .product-photo {
                width: 15%;
            }

            .cart-table .produc-name {
                width: 30%;
            }

            .cart-table .produc-price {
                width: 15%;
            }

            .cart-table .product-quantity {
                width: 18%;
            }

            .cart-table .total-price {
                width: 15%;
            }

            .cart-table .product-remove {
                width: 7%;
            }

            .icon-menu li .fa-heart {
                padding-right: 5px !important;
            }

            .cart-box-container a{
                text-decoration:none;
            }
        </style>
    </head>
    <body>
        <header class="container" id="header-v3">
            <div class="row">
                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-3 logo">
                    <a href="home.aspx">
                        <img src="../img/logo.png" alt="img-holiwood"></a>
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
                                <img src="../img/cart.png" id="img-cart" alt="img-holiwood"></a>
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
                            <img src="../img/1350x500.png" class="img-responsive" alt="img-holiwood"></a>
                    </figure>
                    <div class="title-banner">
                        <h1>Shopping Cart</h1>
                        <p>
                            <a href="home.aspx" title="Home">Home</a><i class="fa fa-caret-right"></i>Shopping Cart
                        </p>
                    </div>
                </div>
            </div>
            <div class="cart-box-container">
                <div class="container container-ver2 space-padding-tb-30">
                    <div class="row head-cart">
                        <div class="col-md-4 space-30">
                            <div class="item active center">
                                <p class="icon">
                                    01
                                </p>
                                <a href="#"><h3>Shopping cart</h3></a>
                            </div>
                        </div>
                        <!-- End col-md-4 -->
                        <div class="col-md-4 space-30">
                            <div class="item center">
                                <p class="icon">
                                    02
                                </p>
                                <h3>Check out</h3>
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
                <div class="container container-ver2">
                    <div class="box cart-container" style="text-align: start;">
                        <table class="table cart-table space-30">
                            <thead>
                                <tr>
                                    <th class="product-photo">Photo</th>
                                    <th class="produc-name">Name</th>
                                    <th class="produc-price">Price</th>
                                    <th class="product-quantity">qty</th>
                                    <th class="total-price">Total</th>
                                    <th class="product-remove"></th>
                                </tr>
                            </thead>
                            <tbody>

                                <asp:GridView ID="gvCartProducts" runat="server" AutoGenerateColumns="False"
                                    CssClass="table cart-table space-30" GridLines="None"
                                    OnRowCommand="gvCartCommand">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <img src='<%# Eval("image_url") %>' alt='<%# Eval("product_name") %>' style="width: 100px; height: auto;" />
                                            </ItemTemplate>
                                            <ItemStyle CssClass="product-photo" />
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <a href="#" title=""><%# Eval("product_name") %></a>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="produc-name" />
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Eval("price", "{0:C2}") %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="total-price" />
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <div class="quantity-stepper">
                                                    <asp:LinkButton ID="btnDecrease" runat="server" CssClass="qty-btn"
                                                        CommandName="Decrease" CommandArgument='<%# Eval("cart_item_id") %>'><i class="fa fa-minus"></i></asp:LinkButton>

                                                    <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("quantity") %>'
                                                        CssClass="qty-input" ReadOnly="true" />

                                                    <asp:LinkButton ID="btnIncrease" runat="server" CssClass="qty-btn"
                                                        CommandName="Increase" CommandArgument='<%# Eval("cart_item_id") %>'><i class="fa fa-plus"></i></asp:LinkButton>
                                                </div>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="product-quantity" />
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# (Convert.ToDecimal(Eval("price")) * Convert.ToInt32(Eval("quantity"))).ToString("C2") %>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="total-price" />
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnRemoveFromCart" runat="server"
                                                    CssClass="remove" ToolTip="Remove item from cart"
                                                    CommandName="RemoveItem" CommandArgument='<%# Eval("cart_item_id") %>'>
                                                         <img src="../img/icon-delete-cart.png" alt="close" />
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="product-remove" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

                            </tbody>
                        </table>
                        <div class="row-total">
                            <div class="float-left">
                                <h3>Sub Total</h3>
                            </div>
                            <!--End align-left-->
                            <div class="float-right">
                                <p>
                                    <asp:Label ID="lblSubTotal" runat="server" Text="$0.00"></asp:Label>
                            </div>
                            <!--End align-right-->
                        </div>
                        <div class="box space-30">
                            <div class="float-left">

                                <asp:LinkButton ID="btnClearCart" runat="server" CssClass="link-v1 lh-50 margin-right-20 space-20" OnClick="btnClearCart_Click">CLEAR SHOPPING CART</asp:LinkButton>
                                <a class="link-v1 lh-50 bg-brand" href="shopping.aspx" title="CONTINUS SHOPPING">CONTINUE SHOPPING</a>

                            </div>
                            <!-- End float left -->
                            <div class="float-right">
                                <a class="link-v1 lh-50 bg-brand" href="checkout.aspx" title="POCEEED TO CHECKOUT">POCEEED TO CHECKOUT</a>
                            </div>
                            <!-- End float-right -->
                        </div>
                    </div>
                    <!-- End container -->
                </div>
                <!-- End cat-box-container -->
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
                                    <img src="../img/Send.png" alt="img-holiwood">
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
        <script src="../js/jquery.min_af.js"></script>
        <script src="../js/bootstrap.min_0028.js"></script>

        <!-- js file -->
        <script src="../js/function-back-top.js"></script>
        <script src="../js/function-sidebar.js"></script>
        <script src="../js/funtion-header-v3.js"></script>
        <script src="../js/function-search-v2.js"></script>
        <script src="../js/function-shopping-cart.js"></script>
    </body>
    </html>
</asp:Content>

