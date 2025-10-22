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
        <link rel="icon" href="../img/favicon.png" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="../css/style-about.css">
        <link rel="stylesheet" type="text/css" href="../css/style-res-about.css">
        <link rel="stylesheet" type="text/css" href="../css/style-faq.css">
        <link rel="stylesheet" type="text/css" href="../css/style-login.css">
        <link rel="stylesheet" type="text/css" href="../css/style-fix-nav.css">
        <link rel="stylesheet" type="text/css" href="../css/style-form-search-mobile.css">
        <link rel="stylesheet" type="text/css" href="../css/style-edit-profile.css">
        <!-- slick -->

        <!-- GG FONT -->
        <link href="https://fonts.googleapis.com/css?family=Abril+Fatface" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
        <style>
            .form-group {
                margin-right: 0px !important;
                margin-left: 7px !important;
            }

            .btn-cancel:hover {
                color: #6c757d !important;
                background-color: white;
                border: .5px solid #6c757d;
            }

            .btn-update:hover {
                color: #ff6b6b;
                background-color: white;
                border: .5px solid #ff6b6b;
            }

            .errMSG {
                color: red;
                font-family: 'poppins';
            }

            .sucMSG {
                color: green;
                font-family: 'poppins';
            }
        </style>
    </head>
    <body>
        <main>

            <div class="container edit-profile-container" style="width: 80%;">
                <div class="row">
                    <div class="col-md-12">
                        <div class="edit-profile-card">
                            <div class="edit-profile-header">
                                <h2><i class="fas fa-user-edit"></i>Edit Profile</h2>
                            </div>

                            <asp:Label ID="successMsg" runat="server" CssClass="sucMSG" Text="Profile updated successfully!" Visible="false"></asp:Label>
                            <asp:Label ID="errorMsg" runat="server" CssClass="errMSG" Text="An error occured while updating profile!" Visible="false"></asp:Label>

                            <div class="form-horizontal" role="form">
                                <div class="row form-row">
                                    <div class="col-xs-6 col-sm-6 field-col">
                                        <div class="form-group">
                                            <label for="<%=txtUsername.ClientID %>">Username *</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fas fa-user"></i></span>
                                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your username"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-6 field-col">
                                        <div class="form-group">
                                            <label for="<%=txtEmail.ClientID %>">Email Address *</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fas fa-envelope"></i></span>
                                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="you@example.com"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row form-row">
                                    <div class="col-xs-6 col-sm-6 field-col">
                                        <div class="form-group">
                                            <label for="<%=ddlGender.ClientID %>">Gender</label>
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
                                    <div class="col-xs-6 col-sm-6 field-col">
                                        <div class="form-group">
                                            <label for="<%=txtCurrentPassword.ClientID %>">Current Password *</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fas fa-lock"></i></span>
                                                <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your current password"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row action-row">
                                    <div class="col-sm-12 text-right">
                                        <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" CssClass="btn-update btn btn-primary" OnClick="btnUpdateProfile_Click" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel btn btn-default"
                                            OnClientClick="return confirm('Are you sure you want to cancel? Any unsaved changes will be lost.');"
                                            OnClick="btnCancel_Click" CausesValidation="false" />

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

        <script src="../js/edit-profile.js"></script>
    </body>
    </html>
</asp:Content>
