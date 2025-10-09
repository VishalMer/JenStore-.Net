<%@ Page Title="" Language="C#" MasterPageFile="~/edit-profile.Master" AutoEventWireup="true" CodeBehind="edit-profile.aspx.cs" Inherits="JenStore.edit_profile1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Edit Profile - JenStore</title>
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
        <link rel="stylesheet" type="text/css" href="css/style-edit-profile.css">
        <!-- slick -->

        <!-- GG FONT -->
        <link href="https://fonts.googleapis.com/css?family=Abril+Fatface" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
        <style>
            /* Page-local tweaks for layout spacing */
            .edit-profile-card {
                max-width: 58vw;
                margin: 0 auto;
            }

            .form-row {
                margin-left: -10px;
                margin-right: -10px;
            }

                .form-row .field-col {
                    padding-left: 10px;
                    padding-right: 10px;
                    margin-bottom: 15px;
                }

            .action-row .btn {
                display: inline-block;
                margin-left: 10px;
            }
            /* Requested tweaks */
            /* Make all inputs the same full width within their columns */
            .field-col .input-group {
                width: 90%;
                box-sizing: border-box;
            }

            .edit-profile-card .form-control {
                width: 100%;
                max-width: none;
                box-sizing: border-box;
            }

            .edit-profile-card select.form-control {
                width: 100%;
                max-width: none;
            }

            .action-row .col-sm-12 {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                gap: 10px;
            }

            .btn-update, .btn-cancel {
                min-width: 160px;
            }

            @media (max-width:767px) {
                .form-row .field-col {
                    width: 100%;
                    float: none
                }

                .action-row {
                    text-align: center
                }
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
                        <form class="hidden-lg hidden-md form-group form-search-mobile">
                            <input type="text" name="search" placeholder="Search here..." class="form-control">
                            <button type="submit">
<img src="img/Search.png" alt="search" class="img-responsive">
                            </button>
                        </form>
                        <ul class="nav navbar-nav menu-main">
                            <li class="menu-home"><a href="home.html">Home</a><figure id="home-1">
</figure>
                            </li>
                            <li class="shop-menu dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Shop +</a><figure id="shop-1" class=" hidden-sm hidden-md hidden-xs">
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
                            <li><a href="user-dashboard.html" class="active">My Account</a><figure id="wedding-1" class=" hidden-sm hidden-md hidden-xs">
                            </figure>
                            </li>
                            <li class="blog-menu"><a href="blog.html">Blog</a><figure id="blog-1" class=" hidden-sm hidden-md hidden-xs">
                            </figure>
                            </li>
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
                        <li class="dropdown cart-menu"><a href="shopping-cart.html">
                            <img src="img/cart.png" id="img-cart" alt="img-holiwood"></a> </li>
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



            <div class="container edit-profile-container" style="width: 80%; margin-top: 5em;">
                <div class="row">
                    <div class="col-md-12">
                        <div class="edit-profile-card">
                            <div class="edit-profile-header">
                                <h2><i class="fas fa-user-edit"></i>Edit Profile</h2>
</div>

                            <%-- Success Message Panel --%>
                            <asp:Panel ID="pnlSuccessMessage" runat="server" CssClass="success-message" Visible="false">
                                <i class="fas fa-check-circle"></i>Profile updated successfully!
</asp:Panel>

                            <%-- Error Message Panel --%>
                            <asp:Panel ID="pnlErrorMessage" runat="server" CssClass="error-message" Visible="false">
                                <i class="fas fa-exclamation-circle"></i>
                                <asp:Literal ID="litErrorText" runat="server"></asp:Literal>
</asp:Panel>

                            <%-- The main form container --%>
                            <div class="form-horizontal" role="form">
<div class="row form-row">
                                    <%-- Username Field --%>
                                    <div class="col-xs-6 col-sm-6 field-col">
                                        <div class="form-group">
                                            <label for="txtUsername">Username *</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fas fa-user"></i></span>
                                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your username" autocomplete="username"></asp:TextBox>
                                            </div>
                                        </div>
</div>

                                    <%-- Email Address Field --%>
                                    <div class="col-xs-6 col-sm-6 field-col">
                                        <div class="form-group">
                                            <label for="txtEmail">Email Address *</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fas fa-envelope"></i></span>
                                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="you@example.com" autocomplete="email"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
</div>

                                <div class="row form-row">
                                    <%-- Gender Field --%>
                                    <div class="col-xs-6 col-sm-6 field-col">
                                        <div class="form-group">
                                            <label for="ddlGender">Gender</label>
<div class="input-group">
                                                <span class="input-group-addon"><i class="fas fa-venus-mars"></i></span>
                                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value="">Select Gender</asp:ListItem>
                                                    <asp:ListItem Value="male">Male</asp:ListItem>
                                                    <asp:ListItem Value="female">Female</asp:ListItem>
                                                    <asp:ListItem Value="other">Other</asp:ListItem>
                                                    <asp:ListItem Value="prefer-not-to-say">Prefer not to say</asp:ListItem>
                                                </asp:DropDownList>
</div>
                                        </div>
                                    </div>

<%-- Current Password Field --%>
                                    <div class="col-xs-6 col-sm-6 field-col">
                                        <div class="form-group">
                                            <label for="txtCurrentPassword">Current Password *</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fas fa-lock"></i></span>
<asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your current password" autocomplete="current-password"></asp:TextBox>
                                            </div>
                                        </div>
</div>
                                </div>

                                <%-- Action Buttons --%>
                                <div class="row action-row">
                                    <div class="col-sm-12 text-right">
                                        <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" CssClass="btn-update btn btn-primary" OnClick="btnUpdateProfile_Click" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel btn btn-default" PostBackUrl="~/user-dashboard.aspx" CausesValidation="false" />
</div>
                                </div>
                            </div>
                        </div>
                    </div>
</div>
            </div>
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

        <script src="js/edit-profile.js"></script>
    </body>
    </html>
</asp:Content>
