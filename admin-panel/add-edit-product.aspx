<%@ Page Title="" Language="C#" MasterPageFile="~/admin-panel/add-edit-product.Master" AutoEventWireup="true" CodeBehind="add-edit-product.aspx.cs" Inherits="JenStore.admin_panel.add_edit_product1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Add/Edit Product - JenStore Admin</title>
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

            .product-form {
                background: white;
                border-radius: 10px;
                padding: 30px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .form-section {
                border-bottom: 1px solid #eee;
                padding-bottom: 25px;
                margin-bottom: 25px;
            }

                .form-section:last-child {
                    border-bottom: none;
                    padding-bottom: 0;
                    margin-bottom: 0;
                }

            .section-title {
                color: #333;
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #667eea;
            }

            .image-upload-area {
                border: 2px dashed #ddd;
                border-radius: 10px;
                padding: 40px;
                text-align: center;
                background: #f8f9fa;
                cursor: pointer;
                transition: all 0.3s ease;
            }

                .image-upload-area:hover {
                    border-color: #667eea;
                    background: #f0f2ff;
                }

                .image-upload-area.dragover {
                    border-color: #667eea;
                    background: #e8f0ff;
                }

            .upload-icon {
                font-size: 48px;
                color: #667eea;
                margin-bottom: 15px;
            }

            .preview-image {
                max-width: 200px;
                max-height: 200px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .category-checkboxes {
                max-height: 200px;
                overflow-y: auto;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 15px;
                background: #f8f9fa;
            }

            .category-item {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }

                .category-item:last-child {
                    margin-bottom: 0;
                }

                .category-item input[type="checkbox"] {
                    margin-right: 10px;
                }

            .badge-options {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }

            .badge-option {
                padding: 8px 16px;
                border: 2px solid #ddd;
                border-radius: 20px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

                .badge-option:hover {
                    border-color: #667eea;
                    background: #f0f2ff;
                }

                .badge-option.selected {
                    border-color: #667eea;
                    background: #667eea;
                    color: white;
                }

            .form-actions {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                margin-top: 30px;
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
                        <h1><i class="fas fa-edit"></i>Add/Edit Product</h1>
                        <p class="mb-0" id="page-subtitle">
                            Create a new product for your store
                        </p>
                    </div>
                    <div class="col-md-6 text-right">
                        <a href="products.aspx" class="btn btn-outline-light btn-sm"><i class="fas fa-arrow-left"></i>Back to Products </a><a href="../home.aspx" class="btn btn-store btn-sm ml-2"><i class="fas fa-home"></i>Back to Store </a><a href="../login_register.aspx" class="btn btn-logout btn-sm ml-2"><i class="fas fa-sign-out-alt"></i>Logout </a>
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
                    <div class="page-header">
                        <h2><i class="fas fa-edit"></i>
                            <asp:Label ID="lblPageTitle" runat="server" Text="Add New Product"></asp:Label></h2>
                        <p>
                            <asp:Label ID="lblPageSubtitle" runat="server" Text="Fill in the details below to create a new product"></asp:Label></p>
                    </div>

                    <div class="product-form">
                        <asp:HiddenField ID="hdnProductId" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnExistingImage" runat="server" />

                        <div class="form-section">
                            <h3 class="section-title"><i class="fas fa-info-circle"></i>Basic Information</h3>
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="form-group">
                                        <label for="txtProductName">Product Name *</label>
                                        <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="ddlBadge">Badge</label>
                                        <asp:DropDownList ID="ddlBadge" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="">No Badge</asp:ListItem>
                                            <asp:ListItem Value="sale">Sale</asp:ListItem>
                                            <asp:ListItem Value="new">New</asp:ListItem>
                                            <asp:ListItem Value="popular">Popular</asp:ListItem>
                                            <asp:ListItem Value="featured">Featured</asp:ListItem>
                                            <asp:ListItem Value="limited">Limited</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="txtDescription">Description *</label>
                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" required="true"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-section">
                            <h3 class="section-title"><i class="fas fa-dollar-sign"></i>Pricing</h3>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="txtPrice">Price *</label>
                                        <div class="input-group">
                                            <span class="input-group-addon">$</span>
                                            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" required="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="txtOldPrice">Old Price</label>
                                        <div class="input-group">
                                            <span class="input-group-addon">$</span>
                                            <asp:TextBox ID="txtOldPrice" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="txtStock">Stock *</label>
                                        <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" TextMode="Number" required="true"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <h3 class="section-title"><i class="fas fa-image"></i>Product Image</h3>
                            <asp:FileUpload ID="fileUploadImage" runat="server" CssClass="form-control" />
                            <asp:Image ID="imgPreview" runat="server" CssClass="preview-image" Style="margin-top: 15px;" Visible="false" />
                        </div>

                        <div class="form-section">
                            <h3 class="section-title"><i class="fas fa-tags"></i>Categories</h3>
                            <div class="category-checkboxes">
                                <asp:CheckBoxList ID="cblCategories" runat="server"></asp:CheckBoxList>
                            </div>
                        </div>

                        <div class="form-actions text-right">
                            <asp:Button ID="btnSave" runat="server" Text="Save Product" CssClass="btn btn-success btn-lg" OnClick="btnSave_Click" />
                            <a href="products.aspx" class="btn btn-secondary btn-lg">Cancel</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            // Check if we're editing an existing product
            const urlParams = new URLSearchParams(window.location.search);
            const productId = urlParams.get('id');

            if (productId) {
                // We're editing - load product data
                loadProductData(productId);
            }

            function loadProductData(id) {
                // This would typically make an API call to get product data
                // For now, we'll simulate loading data
                document.getElementById('page-title').innerHTML = '<i class="fas fa-edit"></i> Edit Product';
                document.getElementById('page-subtitle').textContent = 'Update the product information below';

                // Simulate loading product data
                setTimeout(() => {
                    document.getElementById('productName').value = 'Rose Bouquet';
                    document.getElementById('productDescription').value = 'Beautiful red roses arranged in a stunning bouquet perfect for any occasion.';
                    document.getElementById('productPrice').value = '89.99';
                    document.getElementById('productOldPrice').value = '99.99';
                    document.getElementById('productBadge').value = 'sale';
                    const stockField = document.getElementById('productStock');
                    if (stockField) stockField.value = '20';
                    document.getElementById('cat-roses').checked = true;
                    document.getElementById('cat-bouquets').checked = true;

                    // Show preview image
                    document.getElementById('previewImage').src = '../img/340x420(buqet rose).jpg';
                    document.getElementById('previewImage').style.display = 'block';
                    document.getElementById('uploadContent').style.display = 'none';
                }, 500);
            }

            function handleImageUpload(event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('previewImage').src = e.target.result;
                        document.getElementById('previewImage').style.display = 'block';
                        document.getElementById('uploadContent').style.display = 'none';
                        document.getElementById('imageUrl').value = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            }

            function resetForm() {
                document.getElementById('productForm').reset();
                document.getElementById('previewImage').style.display = 'none';
                document.getElementById('uploadContent').style.display = 'block';
                document.getElementById('imageUrl').value = '';
            }

            // Handle form submission
            document.getElementById('productForm').addEventListener('submit', function (e) {
                e.preventDefault();

                // Collect form data
                const formData = new FormData(this);

                // Here you would typically make an API call to save the product
                console.log('Saving product...', Object.fromEntries(formData));

                alert('Product saved successfully!');

                // Redirect back to products page
                window.location.href = 'products.aspx';
            });

            // Drag and drop functionality
            const imageUploadArea = document.getElementById('imageUploadArea');

            imageUploadArea.addEventListener('dragover', function (e) {
                e.preventDefault();
                this.classList.add('dragover');
            });

            imageUploadArea.addEventListener('dragleave', function (e) {
                e.preventDefault();
                this.classList.remove('dragover');
            });

            imageUploadArea.addEventListener('drop', function (e) {
                e.preventDefault();
                this.classList.remove('dragover');

                const files = e.dataTransfer.files;
                if (files.length > 0) {
                    document.getElementById('imageInput').files = files;
                    handleImageUpload({ target: { files: files } });
                }
            });
        </script>
    </body>
    </html>
</asp:Content>
