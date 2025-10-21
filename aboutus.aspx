<%@ Page Title="" Language="C#" MasterPageFile="~/aboutus.Master" AutoEventWireup="true" CodeBehind="aboutus.aspx.cs" Inherits="JenStore.aboutus1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>About Us</title>
        <meta charset="utf-8">
        <!-- bootstrap vs fontawesome-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="icon" href="img/favicon.png" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="css/style-about.css">
        <link rel="stylesheet" type="text/css" href="css/style-res-about.css">
        <link rel="stylesheet" type="text/css" href="css/style-fix-nav.css">
        <link rel="stylesheet" type="text/css" href="css/style-form-search-mobile.css">
        <!-- slick -->

        <!-- GG FONT -->
        <link href="https://fonts.googleapis.com/css?family=Abril+Fatface" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">

        <style>
            .team-img {
                width: 400px;
            }

            .icon-menu li .fa-heart {
                padding-right: 5px !important;
            }

            .title-banner h1, .title-banner p {
                margin-left: -2em;
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
                            <li class="wedding-menu active"><a href="#">About Us</a><figure id="wedding-1" class=" hidden-sm hidden-xs">
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
                        <h1>About Us</h1>
                        <p>Your premier destination for exquisite flowers, exceptional service, and memorable moments</p>
                    </div>
                </div>
            </div>
            <div class="wellcome">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-well">
                            <div class="media">
                                <div class="media-left">
                                    <a href="#">
                                        <img src="img/reference.jpg" alt="img-holiwood" style="height: 115px; width: 115px;"></a>
                                </div>
                                <div class="media-body">
                                    <h1>WELCOME</h1>
                                    <h2>Hello! I am Vishal 
                                                <br>
                                        Founder of JenStore</h2>
                                </div>
                            </div>
                            <p>
                                At JenStore, we believe that flowers have the power to transform ordinary moments into extraordinary memories. Founded with a passion for floral artistry, we specialize in creating stunning arrangements that capture the essence of every celebration.<br>
                                <br>
                                Our commitment to excellence drives us to source only the freshest, highest-quality flowers from trusted growers worldwide. From intimate bouquets to grand event displays, we craft each arrangement with meticulous attention to detail and artistic flair.
                            </p>
                            <div class="social-well">
                                <span>SOCIAL:</span> <a href="#" id="link-insta2"></a><a href="#" id="link-fb2"></a><a href="#" id="link-tw2"></a><a href="#" id="link-sky2"></a>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 img-well">
                            <figure id="img-about">
                                <a href="#">
                                    <img src="img/img-about.jpg" alt="img-holiwood"></a>
                            </figure>
                        </div>
                    </div>
                </div>
            </div>

            <div class="team">

                <div class="container">
                    <h1>Meet our team</h1>
                    <h3>Profestional and  Outstanding Ideas of our passlonate team makes us unique in every sense</h3>
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6 team-account">
                            <a href="#">
                                <img src="img/user_img/admin2.PNG" class="img-responsive team-img" alt="img-holiwood"></a>
                            <div class="title-acc">
                                <h2>Rahul Kumar</h2>
                                <p>Products Designer</p>
                                <div class="social-acc">
                                    <a href="#" class="link-gmail-acc"></a>
                                    <a href="#" class="link-fb-acc"></a>
                                    <a href="#" class="link-in-acc"></a>
                                    <a href="#" class="link-insta-acc"></a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6 team-account">
                            <a href="#">
                                <img src="img/user_img/admin1.PNG" class="img-responsive" alt="img-holiwood"></a>
                            <div class="title-acc">
                                <h2>Vishal Mer</h2>
                                <p>Backend Developer</p>
                                <div class="social-acc">
                                    <a href="#" class="link-gmail-acc"></a>
                                    <a href="#" class="link-fb-acc"></a>
                                    <a href="#" class="link-in-acc"></a>
                                    <a href="#" class="link-insta-acc"></a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6 team-account">
                            <a href="#">
                                <img src="img/user_img/admin3.PNG" class="img-responsive" alt="img-holiwood"></a>
                            <div class="title-acc">
                                <h2>Dhruv Bhau</h2>
                                <p>Template Finder</p>
                                <div class="social-acc">
                                    <a href="#" class="link-gmail-acc"></a>
                                    <a href="#" class="link-fb-acc"></a>
                                    <a href="#" class="link-in-acc"></a>
                                    <a href="#" class="link-insta-acc"></a>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- end row -->

                </div>
            </div>

            <div class="our-story">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 text-center">
                            <h1>Our Story</h1>
                            <h3>Bringing beauty and joy to your special moments since 2018</h3>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                            <div class="story-item">
                                <div class="story-icon">
                                    <i class="fas fa-seedling"></i>
                                </div>
                                <h2>Fresh & Quality</h2>
                                <p>We work directly with local and international flower farms to ensure every bloom is at its peak freshness when it reaches you.</p>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                            <div class="story-item">
                                <div class="story-icon">
                                    <i class="fas fa-truck"></i>
                                </div>
                                <h2>Fast Delivery</h2>
                                <p>Our efficient delivery network ensures your flowers arrive on time, every time, maintaining their beauty and freshness.</p>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                            <div class="story-item">
                                <div class="story-icon">
                                    <i class="fas fa-heart"></i>
                                </div>
                                <h2>Expert Design</h2>
                                <p>Our skilled florists combine creativity with expertise to create arrangements that perfectly match your vision and occasion.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ------------------------- -->


            <div class="feedback">
                <div class="container">
                    <h1>Customers say</h1>
                    <h2>,,</h2>
                    <div id="myCarousel1" class="carousel slide" data-ride="carousel">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <li data-target="#myCarousel1" data-slide-to="0" class="active"></li>
                            <li data-target="#myCarousel1" data-slide-to="1"></li>
                            <li data-target="#myCarousel1" data-slide-to="2"></li>
                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner">
                            <div class="item active">
                                <p>
                                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,<br class="hidden-sm hidden-xs">
                                    when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap<br class="hidden-sm hidden-xs">
                                    into electronic typesetting, remaining essentially unchanged
                                </p>
                                <div class="img-customer">
                                    <img src="img/115x115.png" alt="img-holiwood">
                                    <h1>JUDY BEAUTY - <span>Customers</span></h1>
                                </div>
                            </div>

                            <div class="item">

                                <p>
                                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,<br class="hidden-sm hidden-xs">
                                    when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap<br class="hidden-sm hidden-xs">
                                    into electronic typesetting, remaining essentially unchanged
                                </p>
                                <div class="img-customer">
                                    <img src="img/115x115.png" alt="img-holiwood">
                                    <h1>JUDY BEAUTY - <span>Customers</span></h1>
                                </div>
                            </div>

                            <div class="item">

                                <p>
                                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,<br class="hidden-sm hidden-xs">
                                    when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap<br class="hidden-sm hidden-xs">
                                    into electronic typesetting, remaining essentially unchanged
                                </p>
                                <div class="img-customer">
                                    <img src="img/115x115.png" alt="img-holiwood">
                                    <h1>JUDY BEAUTY - <span>Customers</span></h1>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="img-link">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                            <div class="img-color-1">
                                <div class="img-content">
                                    <img src="img/70x71.png" class="img-responsive" alt="img-holiwood">
                                </div>
                                <h1>100%</h1>
                                <h2>Product quality protection</h2>
                            </div>

                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                            <div class="img-color-2">
                                <div class="img-content">
                                    <img src="img/82x62.png" class="img-responsive" alt="img-holiwood">
                                </div>
                                <h1>100%</h1>
                                <h2>Payment protection</h2>
                            </div>

                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                            <div class="img-color-3">
                                <div class="img-content">
                                    <img src="img/62x62.png" class="img-responsive" alt="img-holiwood">
                                </div>
                                <h1>100%</h1>
                                <h2>On-time shipment protection</h2>
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

