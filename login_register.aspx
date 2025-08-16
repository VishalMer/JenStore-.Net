<%@ Page Title="" Language="C#" MasterPageFile="~/login_register.Master" AutoEventWireup="true" CodeBehind="login_register.aspx.cs" Inherits="JenStore.login_register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Login/Register</title>
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
            .link-v1.rt {
                font-family: Abril Fatface;
                font-weight: 400;
                font-size: 18px;
                color: white; /* This color is used initially */
                padding: 10px 40px;
                background-color: black;
                border: 1px solid black;
                background-image: -webkit-linear-gradient(90deg, black 50%, transparent 50%);
                background-image: linear-gradient(90deg, black 50%, transparent 50%);
                background-size: 600px;
                background-repeat: no-repeat;
                background-position: 0%;
                -webkit-transition: all 0.3s ease-in-out;
                transition: all 0.3s ease-in-out;
            }

                .link-v1.rt:hover {
                    background-position: 100%;
                    background-color: #fff;
                    color: black;
                    text-decoration: none;
                }

            .ErrMsg {
                color: orangered;
                font-weight: 900;
                font: 300 14px / 20px "Poppins";
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
                        <%-- <form class="hidden-lg hidden-md form-group form-search-mobile">
                            <input type="text" name="search" placeholder="Search here..." class="form-control">
                            <button type="submit">
                                <img src="img/Search.png" alt="search" class="img-responsive">
                            </button>
                        </form>--%>
                        <ul class="nav navbar-nav menu-main">
                            <li class="menu-home"><a href="home.html">Home</a><figure id="home-1">
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
                                                            <li class="li-home li-one"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="Shopping.html">Shopping</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="col-lg-4 col-md-4 col-sm-12 col-xs-12 menu-home-lv2">
                                                        <ul>
                                                            <li><a href="#">CHECKING PAGE</a></li>
                                                            <li class="li-home li-one"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="shopping-cart.html">Shopping Cart</a></li>
                                                            <li class="li-home"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="checkout.html">Checkout</a></li>
                                                            <li class="li-home"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="order.html">Order</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="col-lg-4 col-md-4 col-sm-12 col-xs-12 menu-home-lv2">
                                                        <ul>
                                                            <li><a href="#">OTHER PAGE</a></li>
                                                            <li class="li-home li-one"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="FAQ.html">FAQ</a></li>
                                                            <li class="li-home"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="login_register.html">Login/Register</a></li>
                                                            <li class="li-home"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="page404.html">Page404</a></li>
                                                            <li class="li-home"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="tracking.html">Tracking</a></li>
                                                            <li class="li-home"><i class="fas fa-long-arrow-alt-right hidden-sm hidden-md hidden-xs"></i><a href="wishlist.html">Wishlist</a></li>
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
                            <li><a href="login_register.html" class="active">Login/Register</a><figure id="wedding-1" class=" hidden-sm hidden-md hidden-xs">
                            </figure>
                            </li>
                            <li class="blog-menu"><a href="blog.html">Blog</a><figure id="blog-1" class=" hidden-sm hidden-md hidden-xs">
                            </figure>
                            </li>
                            <li class="contact-menu"><a href="contact.html">Contact</a><figure id="contact-1" class=" hidden-sm hidden-md hidden-xs">
                            </figure>
                            </li>
                            <li class="hidden-lg hidden-md"><a href="user-dashboard.html"><i class="far fa-user"></i>My Account</a></li>
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
                        <li class="icon-user hidden-sm hidden-xs"><a href="user-dashboard.html"><i class="far fa-user"></i></a></li>
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
                        <h1>Login/Register</h1>
                        <p>
                            <a href="#" title="Home">Home</a><i class="fa fa-caret-right"></i>Login/Register
                        </p>
                    </div>
                </div>
            </div>
            <div class="container container-ver2">
                <div class="page-login box space-50">
                    <div class="row">
                        <div class="col-md-6 sign-in space-30">
                            <h3>sign in</h3>
                            <p>
                                Hello, welcome to your account.
                            </p>
                            <div class="social space-30 box">
                                <a class="float-left" href="#" title="facebook"><i class="fab fa-facebook-f"></i>SIGN IN WITH FACEBOOK </a><a class="float-right" href="#" title="TWITTER"><i class="fab fa-twitter"></i>SIGN IN WITH TWITTER </a>
                            </div>
                            <!-- End social -->
                            <%--<form class="form-horizontal" method="POST">--%>
                            <div class="group box space-20">
                                <label class="control-label" for="inputemail">
                                    EMAIL ADDRESS OR USERNAME *</label>
                                <asp:TextBox class="form-control" type="text" placeholder="Your email or username" ID="inputemail" runat="server"></asp:TextBox>
                                <asp:Label ID="emailErr" class="ErrMsg" runat="server" Text=""></asp:Label>
                                <%--<input class="form-control" type="text" placeholder="Your email or username" id="inputemail">--%>
                            </div>
                            <div class="group box">
                                <label class="control-label" for="inputpass">
                                    PASSWORD *</label>
                                <asp:TextBox class="form-control" type="password" placeholder="Password" ID="inputpass" runat="server"></asp:TextBox>
                                <asp:Label ID="passErr" class="ErrMsg" runat="server" Text=""></asp:Label>
                                <%--<input class="form-control" type="password" placeholder="Password" id="inputpass">--%>
                            </div>
                            <div class="remember">
                                <input id="remeber" type="checkbox" name="check" value="remeber">
                                <label for="remeber" class="label-check">
                                    remember me!</label>
                                <a class="help" href="#" title="help ?">Fogot your password?</a>
                            </div>
                            <asp:Button class="link-v1 rt" ID="loginBTN" runat="server" Text="LOGIN NOW" OnClick="loginBTN_Click" />
                            <%--<button type="submit" class="link-v1 rt">
                                    LOGIN NOW
                                </button>--%>
                            <%--</form>--%>
                            <!-- End form -->
                        </div>
                        <!-- End col-md-6 -->
                        <div class="col-md-6">
                            <div class="register box space-50">
                                <h3>Create A New Account</h3>
                                <p>
                                    Create your own Rimbus account.
                                </p>
                                <%--<form class="form-horizontal" method="POST">--%>
                                <div class="group box space-20">
                                    <label class="control-label" for="inputusernameres">
                                        USERNAME *</label>
                                    <asp:TextBox class="form-control" type="text" placeholder="Your username" ID="inputusernameres" runat="server"></asp:TextBox>
                                    <asp:Label ID="userError" class="ErrMsg" runat="server" Text=""></asp:Label>
                                    <%--<input class="form-control" type="text" placeholder="Your username" id="inputusernameres">--%>
                                </div>
                                <div class="group box space-20">
                                    <label class="control-label" for="inputemailres">
                                        EMAIL ADDRESS *</label>
                                    <asp:TextBox class="form-control" type="email" placeholder="Your email" ID="inputemailres" runat="server"></asp:TextBox>
                                    <asp:Label ID="emailError" class="ErrMsg" runat="server" Text=""></asp:Label>
                                    <%--<input class="form-control" type="email" placeholder="Your email" id="inputemailres">--%>
                                </div>
                                <div class="group box space-20">
                                    <label class="control-label" for="inputpassres">
                                        PASSWORD *</label>
                                    <asp:TextBox class="form-control" type="password" placeholder="Password" ID="inputpassres" runat="server"></asp:TextBox>
                                    <asp:Label ID="passError" class="ErrMsg" runat="server" Text=""></asp:Label>
                                    <%--<input class="form-control" type="password" placeholder="Password" id="inputpassres">--%>
                                </div>
                                <div class="group box space-20">
                                    <label class="control-label">
                                        GENDER *</label>
                                    <asp:RadioButtonList ID="rdGen" runat="server">
                                        <asp:ListItem>Male </asp:ListItem>
                                        <asp:ListItem>Female</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:Label ID="genError" class="ErrMsg" runat="server" Text=""></asp:Label>
                                    <%-- <div class="radio-group">
                                        <label class="radio-inline">
                                        <input type="radio" name="gender" value="male" id="gender-male" required> <span class="radio-label">Male</span>
                                        </label>
                                        &nbsp;<label class="radio-inline"><input type="radio" name="gender" value="female" id="gender-female" required> <span class="radio-label">Female</span>
                                        </label>
                                        &nbsp;</div>--%>
                                </div>
                                <asp:Button class="link-v1 rt" ID="submit" runat="server" Text="Sign Up" OnClick="submit_Click" />
                                <%--<button type="submit" class="link-v1 rt">
                                    Sign Up
                                </button>--%>
                                <%--</form>--%>
                            </div>
                            <!-- End register -->
                            <div class="sigg-to-day box">
                                <h3>SIGN UP TODAY</h3>
                                <form class="form-horizontal" method="POST">
                                    <div class="checkbox">
                                        <input id="check1" type="checkbox" name="check" value="check1">
                                        <label class="label-check" for="check1">
                                            Speed your way through the checkout.</label>
                                        <input id="check2" type="checkbox" name="check" value="check2">
                                        <label class="label-check" for="check2">
                                            Track your orders easily.</label>
                                        <input id="check3" type="checkbox" name="check" value="check3">
                                        <label class="label-check" for="check3">
                                            Keep a record of all purchases.</label>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <!-- End col-md-6 -->
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

