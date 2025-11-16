<%@ Page Title="" Language="C#" MasterPageFile="~/admin-panel/products.Master" AutoEventWireup="true" CodeBehind="products.aspx.cs" Inherits="JenStore.admin_panel.products1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Product Management - JenStore Admin</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="icon" href="../img/favicon.png" type="image/x-icon" />
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
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

                    .admin-nav .nav-link:hover,
                    .admin-nav .nav-link.active {
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
                padding:0px 0 40px 0 !important;
            }

            .page-header {
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .products-table {
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

            .product-image {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 8px;
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

            .stock-ok {
                font-weight: bold;
                color: #155724; /* Darker Green for better contrast */
                background-color: #d4edda; /* Light Green */
                padding: 3px 8px;
                border-radius: 12px;
            }

            .stock-low {
                font-weight: bold;
                color: #856404; /* Darker Yellow/Orange for better contrast */
                background-color: #fff3cd; /* Light Yellow/Orange */
                padding: 3px 8px;
                border-radius: 12px;
            }

            .stock-out-of-stock {
                font-weight: bold;
                color: #dc3545; /* Red */
                background-color: #f8d7da;
                padding: 3px 6px;
                border-radius: 12px;
            }

            .search-box {
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 8px 15px;
                width: 300px;
                margin-bottom: 1.5em;
            }

            /*added css*/
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
                        <h1><i class="fas fa-box"></i> Product Management</h1>
                        <p class="mb-0">
                            Manage your store's product inventory
                        </p>
                    </div>
                    <div class="col-md-6 text-right">
                        <a href="../home.aspx" class="btn btn-store btn-sm ml-2"><i class="fas fa-home"></i> Back to Store </a> <a href="../login_register.aspx" class="btn btn-logout btn-sm ml-2"><i class="fas fa-sign-out-alt"></i> Logout </a>
                    </div>
                </div>
            </div>
        </header>

        <!-- Admin Navigation -->
        <nav class="admin-nav">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <a href="index.aspx" class="nav-link"><i class="fas fa-tachometer-alt"></i> Dashboard </a>
                        <a href="products.aspx" class="nav-link active"><i class="fas fa-box"></i> Products </a>
                        <a href="categories.aspx" class="nav-link"><i class="fas fa-tags"></i> Categories </a>
                        <a href="orders.aspx" class="nav-link"><i class="fas fa-shopping-cart"></i> Orders </a>
                        <a href="customers.aspx" class="nav-link"><i class="fas fa-users"></i> Customers </a>
                        <a href="feedback.aspx" class="nav-link"><i class="fas fa-comments"></i> Feedback</a>
                        <a href="notifications.aspx" class="nav-link"><i class="fas fa-bullhorn"></i> Notifications</a>
                        <a href="analytics.aspx" class="nav-link"><i class="fas fa-chart-bar"></i> Analytics </a>
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
                            <h2><i class="fas fa-box"></i> Products</h2>
                            <p class="mb-0">
                                Manage your product catalog
                            </p>
                        </div>
                        <div class="col-md-6 text-right">
                            <a href="add-edit-product.aspx" class="btn btn-success btn-lg"><i class="fas fa-plus"></i> Add New Product </a>
                        </div>
                    </div>
                </div>

                <!-- Search and Filters -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" 
                        placeholder="search products..." AutoPostBack="true" 
                        OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                    </div>
                    <div class="col-md-6 text-right">
                        <select class="form-control" style="width: auto; display: inline-block;">
                            <option>All Categories</option>
                            <option>Roses</option>
                            <option>Bouquets</option>
                            <option>Tulips</option>
                            <option>Seasonal</option>
                        </select>
                    </div>
                </div>

                <!-- Products Table -->
                <div class="products-table">
                    <div class="table-responsive">
                        <asp:GridView ID="gvProducts" runat="server"
                            AutoGenerateColumns="False"
                            CssClass="table table-hover mb-0"
                            GridLines="None"
                            OnRowCommand="gv_Command">
                            <Columns>
                                <asp:TemplateField HeaderText="Image">
                                    <ItemTemplate>
                                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# "~/" + Eval("image_url") %>' CssClass="product-image" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Product Name">
                                    <ItemTemplate>
                                        <strong><%# Eval("product_name") %></strong><br />
                                        <small class="text-muted"><%# Eval("description") %></small>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Category">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("category_names") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Price">
                                    <ItemTemplate>
                                        <strong><%# Eval("price", "{0:C}") %></strong><br />
                                        <strike><small class="text-muted"><%# Eval("old_price", "{0:C}") %></small></strike>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:TemplateField HeaderText="Old Price">
                                    <ItemTemplate>
                                        <del><%# (Eval("old_price") != DBNull.Value && Convert.ToDecimal(Eval("old_price")) > 0) ? string.Format("{0:C}", Eval("old_price")) : "" %></del>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Stock">
                                    <ItemTemplate>
                                        <span class='<%# GetStockStatus(Eval("stock_quantity")) %>'>
                                            <%# Convert.ToInt32(Eval("stock_quantity")) > 0 ? Eval("stock_quantity") : "Out" %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <div class="action-buttons">
                                            <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn-edit" CommandName="EditProduct" CommandArgument='<%# Eval("product_id") %>'><i class="fas fa-edit"></i> Edit</asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn-delete" CommandName="DeleteProduct" CommandArgument='<%# Eval("product_id") %>' OnClientClick="return confirm('Are you sure you want to delete this product?');"><i class="fas fa-trash"></i> Delete</asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <nav>
                        <ul class="pagination">
                            <li class='<%# !lnkPrev.Enabled ? "page-item disabled" : "page-item" %>'>
                                <asp:LinkButton ID="lnkPrev" runat="server" CssClass="page-link" OnClick="lnkPrev_Click"><span aria-hidden="true">&laquo;</span></asp:LinkButton>
                            </li>
                            <asp:Repeater ID="rptPager" runat="server" OnItemCommand="rptPager_ItemCommand">
                                <ItemTemplate>
                                    <li class='<%# Convert.ToBoolean(Eval("Enabled")) ? "page-item active" : "page-item" %>'>
                                        <asp:LinkButton ID="lnkPage" runat="server" CssClass="page-link" CommandName="Page" CommandArgument='<%# Eval("Value") %>'><%# Eval("Text") %></asp:LinkButton>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                            <li class='<%# !lnkNext.Enabled ? "page-item disabled" : "page-item" %>'>
                                <asp:LinkButton ID="lnkNext" runat="server" CssClass="page-link" OnClick="lnkNext_Click"><span aria-hidden="true">&raquo;</span></asp:LinkButton>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            function deleteProduct(productId) {
                if (confirm('Are you sure you want to delete this product? This action cannot be undone.')) {
                    // Here you would typically make an API call to delete the product
                    console.log('Deleting product with ID:', productId);
                    alert('Product deleted successfully!');
                    // Refresh the page or remove the row from the table
                }
            }
        </script>
    </body>
    </html>
</asp:Content>
