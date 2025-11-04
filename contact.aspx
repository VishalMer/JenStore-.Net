<%@ Page Title="" Language="C#" MasterPageFile="~/contact.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="JenStore.contact1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Contact</title>
        <meta charset="utf-8">
        <!-- bootstrap vs fontawesome-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="icon" href="img/icons/favicon.png" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="../css/style-contact.css">
        <link rel="stylesheet" type="text/css" href="../css/style-res-contact.css">
        <link rel="stylesheet" type="text/css" href="../css/style-fix-nav.css">
        <link rel="stylesheet" type="text/css" href="../css/style-form-search-mobile.css">
        <!-- slick -->

        <!-- GG FONT -->
        <link href="https://fonts.googleapis.com/css?family=Abril+Fatface" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
        <style>
            .icon-menu li .fa-heart {
                font-size: 22px;
                top: 1px;
                color: black;
                padding-right: 5px !important;
            }

            .icon-menu li img {
                padding-right: 5px !important;
            }

            .icon-menu li .fa-user {
                padding-right: 15px !important;
            }

            .message-contact .form-group label {
                font-family: Poppins;
                font-weight: 600;
                color: black;
                padding: 25px 0 10px 0;
            }

            .message .message-contact input {
                outline: 0;
                border: 0;
                border-radius: 0;
                box-shadow: none;
                padding-left: 20px;
                border: 1px solid #ddd;
                width: 90% 214.125px;
                padding-left: 20px;
                background: #fff;
                font-family: Poppins !important;
                font-size:14px;
            }

            .message .message-contact textarea {
                border-radius:0px;
                margin-bottom:2em;
            }

            .message-contact label span {
                color: red;
            }

            .form-group .btn-send {
                font-family: Abril Fatface;
                font-weight: 400;
                font-size: 18px;
                color: white;
                padding: 10px 30px;
                background-color: black !important;
                border: 1px solid black !important;
                background-image: -webkit-linear-gradient(90deg, black 50%, transparent 50%);
                background-image: linear-gradient(90deg, black 50%, transparent 50%);
                background-size: 600px;
                background-repeat: no-repeat;
                background-position: 0%;
                -webkit-transition: all 0.3s ease-in-out;
                transition: all 0.3s ease-in-out;
                margin-left: 0.8em;
            }

                .form-group .btn-send:hover {
                    background-position: 100%;
                    background-color: #fff !important;
                    color: black;
                    text-decoration: none;
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
                            <li class="wedding-menu "><a href="aboutus.aspx">About Us</a><figure id="wedding-1" class=" hidden-sm hidden-xs">
                            </figure>
                            </li>
                            <li class="contact-menu active"><a href="#">Contact</a><figure id="contact-1" class="hidden-sm hidden-xs">
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
                        <h1>Contact Us</h1>
                        <p>
                            It is a long established fact that a reader will<br>
                            be distracted by the readable content of a page when looking at its layout
                        </p>
                    </div>
                </div>
            </div>
            <div class="img-link">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                            <div class="img-color-1">
                                <div class="img-content">
                                    <img src="img/icons/50x70.png" class="img-responsive" alt="img-holiwood">
                                </div>
                                <h1>Our Address</h1>
                                <h2>123 canberra Street, NewYork, USA.</h2>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                            <div class="img-color-2">
                                <div class="img-content">
                                    <img src="img/icons/62x61.png" class="img-responsive" alt="img-holiwood">
                                </div>
                                <h1>Phone Number</h1>
                                <h2>Office: (800) 123 456 789</h2>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                            <div class="img-color-3">
                                <div class="img-content">
                                    <img src="img/icons/77x60.png" class="img-responsive" alt="img-holiwood">
                                </div>
                                <h1>Email Address</h1>
                                <h2>Contact@Jenstore.org</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="message">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                            <figure id="img-contact">
                                <a href="#">
                                    <img src="img/backgounds/img-contact.jpg" class="img-responsive" alt="img-holiwood"></a>
                            </figure>
                        </div>
                        <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12 message-contact">
                            <h1>Send us a message</h1>
                            
                            <asp:Panel ID="loginWarning" Visible="false" runat="server" style="margin-left: 15px; font-family:'poppins'">
                                <asp:Label ID="lblLoginText" runat="server" Text="LOGIN required to send us a message. "/>
                                <asp:HyperLink ID="hlLogin" runat="server" NavigateUrl="~/login_register.aspx" style="font-weight:600;">
                                    LOGIN NOW
                                </asp:HyperLink>
                           </asp:Panel>

                            <asp:Label ID="lblSuc" runat="server" Visible="false" Style="display: block; margin:0 0 -10px 15px; color:green;"></asp:Label>
                            <asp:Label ID="lblError" runat="server" Visible="false" Style="display: block; margin:0 0 -10px 15px; color:red;"></asp:Label>

                            <div class="form-group">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                    <label for="name-ip">
                                        Name<span>*</span></label><br>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="input-lg form-control" placeholder="mark stevens" ReadOnly="true"></asp:TextBox>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                    <label for="mail-ip">
                                        Mail<span>*</span></label><br>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-lg form-control" placeholder="mark.stevens@example.com" ReadOnly="true" TextMode="Email"></asp:TextBox>

                                </div>

                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                    <label>
                                        What's on your mind?<span>*</span></label>
                                    <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="write your message here..."></asp:TextBox>

                                </div>
                                <asp:Button ID="btnSend" runat="server" Text="Send Message" CssClass="btn-send" OnClick="btnSend_Click" />

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="map">
            </div>
            <div class="info-footer">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
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
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 social">
                            <p>
                                CONNECT WITH US:
                            </p>
                            <a href="#" id="link-insta"></a><a href="#" id="link-fb"></a><a href="#" id="link-tw"></a><a href="#" id="link-sky"></a>
                            <h1>Newsletter</h1>
                            <h2>Sign up for our mailing list to get latest updates and offers</h2>
                            <form class="form-group" action="mail" method="post">
                                <input type="text" name="input-mail" placeholder="Your mail here" class="input-lg">
                                <button type="submit">
                                    <img src="img/icons/Send.png" alt="img-holiwood">
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
        <script src="../js/function-map.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBnMr64OtHBrpxBLLbYX2K2Waf4enq8sp0&callback"></script>
        <script src="../js/function-back-top.js"></script>
        <script src="../js/function-sidebar.js"></script>
        <script src="../js/funtion-header-v3.js"></script>
        <script src="../js/function-search-v2.js"></script>
    </body>
    </html>
</asp:Content>

