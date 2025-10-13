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
                padding: 40px 0;
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

            .status-active {
                background: #d4edda;
                color: #155724;
            }

            .status-inactive {
                background: #f8d7da;
                color: #721c24;
            }

            .search-box {
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 8px 15px;
                width: 300px;
            }

            .col-md-6 {
                margin-bottom: 2em;
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
                        <h1><i class="fas fa-box"></i>Product Management</h1>
                        <p class="mb-0">
                            Manage your store's product inventory
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
                        <a href="index.aspx" class="nav-link"><i class="fas fa-tachometer-alt"></i>Dashboard </a><a href="products.aspx" class="nav-link active"><i class="fas fa-box"></i>Products </a><a href="categories.aspx" class="nav-link"><i class="fas fa-tags"></i>Categories </a><a href="orders.aspx" class="nav-link"><i class="fas fa-shopping-cart"></i>Orders </a><a href="customers.aspx" class="nav-link"><i class="fas fa-users"></i>Customers </a><a href="analytics.aspx" class="nav-link"><i class="fas fa-chart-bar"></i>Analytics </a>
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
                            <h2><i class="fas fa-box"></i>Products</h2>
                            <p class="mb-0">
                                Manage your product catalog
                            </p>
                        </div>
                        <div class="col-md-6 text-right">
                            <a href="add-edit-product.aspx" class="btn btn-success btn-lg"><i class="fas fa-plus"></i>Add New Product </a>
                        </div>
                    </div>
                </div>

                <!-- Search and Filters -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <input type="text" class="search-box" placeholder="Search products...">
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
                    <div class="table-header">
                        <h4 class="mb-0">Product List</h4>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th>Product Name</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Old Price</th>
                                    <th>Badge</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <img src="../img/340x420(buqet rose).jpg" alt="Rose Bouquet" class="product-image">
                                    </td>
                                    <td><strong>Rose Bouquet</strong><br>
                                        <small class="text-muted">Beautiful red roses arranged in a stunning bouquet</small> </td>
                                    <td>Bouquets, Roses</td>
                                    <td><strong>$89.99</strong></td>
                                    <td><del>$99.99</del></td>
                                    <td><span class="badge badge-warning">Sale</span></td>
                                    <td><span class="status-badge status-active">Active</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-edit" onclick="window.location.href='add-edit-product.aspx?id=1'">
                                                <i class="fas fa-edit"></i>Edit
                                            </button>
                                            <button class="btn-delete" onclick="deleteProduct(1)">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="../img/340x420(tulip yellow).jpg" alt="Yellow Tulips" class="product-image">
                                    </td>
                                    <td><strong>Yellow Tulips</strong><br>
                                        <small class="text-muted">Fresh yellow tulips perfect for spring</small> </td>
                                    <td>Tulips, Seasonal</td>
                                    <td><strong>$45.50</strong></td>
                                    <td><del>$55.00</del></td>
                                    <td><span class="badge badge-info">New</span></td>
                                    <td><span class="status-badge status-active">Active</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-edit" onclick="window.location.href='add-edit-product.aspx?id=2'">
                                                <i class="fas fa-edit"></i>Edit
                                            </button>
                                            <button class="btn-delete" onclick="deleteProduct(2)">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="../img/340x420(cottage).jpg" alt="Cottage Garden" class="product-image">
                                    </td>
                                    <td><strong>Cottage Garden Mix</strong><br>
                                        <small class="text-muted">Wildflower mix perfect for cottage gardens</small> </td>
                                    <td>Bouquets, Seasonal</td>
                                    <td><strong>$67.25</strong></td>
                                    <td><del>$75.00</del></td>
                                    <td><span class="badge badge-success">Popular</span></td>
                                    <td><span class="status-badge status-active">Active</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-edit" onclick="window.location.href='add-edit-product.aspx?id=3'">
                                                <i class="fas fa-edit"></i>Edit
                                            </button>
                                            <button class="btn-delete" onclick="deleteProduct(3)">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="../img/340x420(winter white buqet).jpg" alt="Winter White" class="product-image">
                                    </td>
                                    <td><strong>Winter White Bouquet</strong><br>
                                        <small class="text-muted">Elegant white flowers for winter occasions</small> </td>
                                    <td>Bouquets, Seasonal</td>
                                    <td><strong>$78.99</strong></td>
                                    <td><del>$88.99</del></td>
                                    <td><span class="badge badge-primary">Featured</span></td>
                                    <td><span class="status-badge status-inactive">Inactive</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-edit" onclick="window.location.href='add-edit-product.aspx?id=4'">
                                                <i class="fas fa-edit"></i>Edit
                                            </button>
                                            <button class="btn-delete" onclick="deleteProduct(4)">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="../img/340x420(queen rose).jpg" alt="Queen Rose" class="product-image">
                                    </td>
                                    <td><strong>Queen Rose Collection</strong><br>
                                        <small class="text-muted">Premium roses in elegant arrangements</small> </td>
                                    <td>Roses, Premium</td>
                                    <td><strong>$125.00</strong></td>
                                    <td><del>$150.00</del></td>
                                    <td><span class="badge badge-danger">Limited</span></td>
                                    <td><span class="status-badge status-active">Active</span></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-edit" onclick="window.location.href='add-edit-product.aspx?id=5'">
                                                <i class="fas fa-edit"></i>Edit
                                            </button>
                                            <button class="btn-delete" onclick="deleteProduct(5)">
                                                <i class="fas fa-trash"></i>Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Pagination -->
                <div class="text-center mt-4">
                    <nav>
                        <ul class="pagination">
                            <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">Previous</a> </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item"><a class="page-link" href="#">Next</a> </li>
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
