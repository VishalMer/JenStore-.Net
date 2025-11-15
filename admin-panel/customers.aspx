<%@ Page Title="" Language="C#" MasterPageFile="~/admin-panel/customers.Master" AutoEventWireup="true" CodeBehind="customers.aspx.cs" Inherits="JenStore.admin_panel.customers1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Customer Management - JenStore Admin</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="icon" href="../img/favicon.png" type="image/x-icon" />
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
        <link rel="stylesheet" href="../css/admin.css">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: #f8f9fa;
            }

            .admin-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 20px 0;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .admin-nav {
                background: white;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 15px 0;
            }

                .admin-nav .nav-link {
                    color: #333;
                    font-weight: 500;
                    padding: 10px 20px;
                    margin: 0 5px;
                    border-radius: 5px;
                    transition: all 0.3s ease;
                }

                    .admin-nav .nav-link:hover, .admin-nav .nav-link.active {
                        background: #667eea;
                        color: white;
                        text-decoration: none;
                    }
            /* Header Action Buttons */
            .btn-store {
                background: linear-gradient(135deg, #00c6ff 0%, #0072ff 100%);
                color: #fff !important;
                border: 0;
                border-radius: 30px;
                padding: 8px 16px;
                box-shadow: 0 6px 18px rgba(0,114,255,.35);
                transition: transform .2s ease, box-shadow .2s ease, opacity .2s ease;
            }

                .btn-store:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 24px rgba(0,114,255,.45);
                    text-decoration: none;
                    opacity: .95;
                }

            .btn-logout {
                background: linear-gradient(135deg, #ff5858 0%, #f857a6 100%);
                color: #fff !important;
                border: 0;
                border-radius: 30px;
                padding: 8px 16px;
                box-shadow: 0 6px 18px rgba(248,87,166,.35);
                transition: transform .2s ease, box-shadow .2s ease, opacity .2s ease;
            }

                .btn-logout:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 24px rgba(248,87,166,.45);
                    text-decoration: none;
                    opacity: .95;
                }

            .content-container {
                padding: 0px 0 40px 0 !important;
            }

            .page-header {
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .users-table {
                background: white;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .table-header {
                background: #f8f9fa;
                padding: 20px;
                border-bottom: 1px solid #dee2e6;
            }

            .user-avatar {
                width: 48px;
                height: 48px;
                border-radius: 50%;
                object-fit: cover;
            }

            .action-buttons {
                display: flex;
                gap: 8px;
            }

            .btn-edit {
                background: #007bff;
                border: none;
                color: white;
                padding: 6px 12px;
                border-radius: 4px;
                font-size: 12px;
            }

            .btn-delete {
                background: #dc3545;
                border: none;
                color: white;
                padding: 6px 12px;
                border-radius: 4px;
                font-size: 12px;
            }

            .btn-edit:hover {
                background: #0056b3;
            }

            .btn-delete:hover {
                background: #c82333;
            }

            .status-badge {
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 11px;
                font-weight: 600;
            }

            .status-active {
                background: #d4edda;
                color: #155724;
            }

            .status-banned {
                background: #f8d7da;
                color: #721c24;
            }

            .status-pending {
                background: #fff3cd;
                color: #856404;
            }

            .search-box {
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 8px 15px;
                width: 300px;
            }

            .role-badge {
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 11px;
                font-weight: 600;
                background: #e2e3f3;
                color: #4338ca;
            }

            .alert {
                background: none !important;
                border: none;
            }

            .btn-edit:hover {
                color: #667eea;
                background-color: white;
                text-decoration: none;
            }

            .btn-delete:hover {
                color: #dc3545;
                background-color: white;
                text-decoration: none;
                transition: ease-in;
            }
        </style>
        <link rel="stylesheet" href="../css/admin.css">
    </head>
    <body>
        <!-- Admin Header -->
        <header class="admin-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h1><i class="fas fa-users"></i>Customer Management</h1>
                        <p class="mb-0">
                            View, edit, and manage customer accounts
                        </p>
                    </div>
                    <div class="col-md-6 text-right">
                        <a href="../home.aspx" class="btn btn-store btn-sm ml-2"><i class="fas fa-home"></i>Back to Store </a><a href="../login_register.aspx" class="btn btn-logout btn-sm ml-2"><i class="fas fa-sign-out-alt"></i>Logout </a>
                    </div>
                </div>
            </div>
        </header>

        <!-- Admin Navigation -->
        <nav class="admin-nav">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <a href="index.aspx" class="nav-link"><i class="fas fa-tachometer-alt"></i>Dashboard </a>
                        <a href="products.aspx" class="nav-link"><i class="fas fa-box"></i>Products </a>
                        <a href="categories.aspx" class="nav-link"><i class="fas fa-tags"></i>Categories </a>
                        <a href="orders.aspx" class="nav-link"><i class="fas fa-shopping-cart"></i>Orders </a>
                        <a href="customers.aspx" class="nav-link active"><i class="fas fa-users"></i>Customers </a>
                        <a href="feedback.aspx" class="nav-link"><i class="fas fa-comments"></i>Feedback</a>
                        <a href="notifications.aspx" class="nav-link"><i class="fas fa-bullhorn"></i>Notifications</a>
                        <a href="analytics.aspx" class="nav-link"><i class="fas fa-chart-bar"></i>Analytics </a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="content-container">
            <div class="container">
                <!-- Page Header -->
                <div class="page-header">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h2><i class="fas fa-users"></i>Customers</h2>
                            <p class="mb-0">
                                Manage your user database
                            </p>
                        </div>
                        <div class="col-md-6 text-right">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="search customers..." AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert alert-danger" />

                <!-- Users Table -->
                <div class="users-table">
                    <div class="table-header">
                        <h4 class="mb-0">customer list</h4>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="gvCustomers" runat="server"
                            AutoGenerateColumns="False"
                            CssClass="table table-hover mb-0"
                            GridLines="None"
                            OnRowCommand="gvCustomers_RowCommand">
                            <HeaderStyle ForeColor="#6b7280" />
                            <Columns>
                                <asp:TemplateField HeaderText="user">
                                    <ItemTemplate>
                                        <%-- Add an avatar image : <img src='...' class='user-avatar' /> --%>
                                        <strong><%# Eval("uname") %></strong><br />
                                        <small class="text-muted">user id: <%# Eval("id") %></small>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="email" HeaderText="email" />

                                <asp:TemplateField HeaderText="role">
                                    <ItemTemplate>
                                        <span class="role-badge"><%# Eval("role") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="joined">
                                    <ItemTemplate>
                                        <%# Eval("created_at", "{0:MMM dd, yyyy}") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="OrderCount" HeaderText="orders" />

                                <asp:TemplateField HeaderText="status">
                                    <ItemTemplate>
                                        <span class='status-badge <%# (Eval("is_active") != DBNull.Value && Convert.ToBoolean(Eval("is_active"))) ? "status-active" : "status-banned" %>'>
                                            <%# (Eval("is_active") != DBNull.Value && Convert.ToBoolean(Eval("is_active"))) ? "Active" : "Inactive" %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="actions">
                                    <ItemTemplate>
                                        <div class="action-buttons">
                                            <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn-edit"
                                                CommandName="EditUser" CommandArgument='<%# Eval("id") %>'>
                                            <i class="fas fa-edit"></i> edit
                                        </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn-delete"
                                                CommandName="DeleteUser" CommandArgument='<%# Eval("id") %>'
                                                OnClientClick="return confirm('are you sure you want to delete this user?');">
                                            <i class="fas fa-trash"></i> delete
                                        </asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Pagination -->
                <div class="text-center mt-4" style="margin-top: 20px;">
                    <nav>
                        <ul class="pagination">
                            <li class='<%# !lnkPrev.Enabled ? "page-item disabled" : "page-item" %>'>
                                <asp:LinkButton ID="lnkPrev" runat="server" CssClass="page-link" OnClick="lnkPrev_Click">&laquo;</asp:LinkButton>
                            </li>

                            <asp:Repeater ID="rptPager" runat="server" OnItemCommand="rptPager_ItemCommand">
                                <ItemTemplate>
                                    <li class='<%# Convert.ToBoolean(Eval("Enabled")) ? "page-item active" : "page-item" %>'>
                                        <asp:LinkButton ID="lnkPage" runat="server" CssClass="page-link" CommandName="Page" CommandArgument='<%# Eval("Value") %>'><%# Eval("Text") %></asp:LinkButton>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>

                            <li class='<%# !lnkNext.Enabled ? "page-item disabled" : "page-item" %>'>
                                <asp:LinkButton ID="lnkNext" runat="server" CssClass="page-link" OnClick="lnkNext_Click">&raquo;</asp:LinkButton>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <!-- Edit User Modal -->
        <<div class="modal fade" id="editUserModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="fas fa-edit"></i>Edit User</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="hdnEditUserId" runat="server" />
                        <div class="form-group">
                            <label>full name *</label>
                            <asp:TextBox ID="txtEditUserName" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>email *</label>
                            <asp:TextBox ID="txtEditUserEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>role</label>
                            <asp:DropDownList ID="ddlEditUserRole" runat="server" CssClass="form-control">
                                <asp:ListItem Value="customer">Customer</asp:ListItem>
                                <asp:ListItem Value="admin">Admin</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label>status</label>
                            <asp:DropDownList ID="ddlEditUserStatus" runat="server" CssClass="form-control">
                                <asp:ListItem Value="1">Active</asp:ListItem>
                                <asp:ListItem Value="0">Inactive</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">cancel</button>
                        <asp:Button ID="btnSaveChanges" runat="server" Text="save changes" CssClass="btn btn-primary" OnClick="btnSaveChanges_Click" />
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </body>
    </html>
</asp:Content>
