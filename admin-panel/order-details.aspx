<%@ Page Title="" Language="C#" MasterPageFile="~/admin-panel/order-details.Master" AutoEventWireup="true" CodeBehind="order-details.aspx.cs" Inherits="JenStore.admin_panel.order_details1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Order Details - JenStore Admin</title>
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
                padding: 0 0 40px 0 !important;
            }

            .page-header {
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .order-info-card {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .order-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                padding-bottom: 20px;
                border-bottom: 2px solid #f0f0f0;
            }

            .order-id {
                font-size: 24px;
                font-weight: 700;
                color: #333;
            }

            .order-status {
                padding: 8px 16px;
                border-radius: 25px;
                font-size: 14px;
                font-weight: 600;
                text-transform: uppercase;
            }

            /* Delivered  -> Green */
            .status-delivered {
                background: #d4edda;
                color: #155724;
            }

            /* Shipped -> Blue */
            .status-shipped {
                background: #cce5ff;
                color: #004085;
            }

            /* Processing -> Yellow */
            .status-processing {
                background: #fff3cd !important;
                color: #856404 !important;
            }

            /* Cancelled -> Red */
            .status-cancelled {
                background: #f8d7da !important;
                color: #721c24 !important;
            }

            /* Pending -> Grey/Teal */
            .status-pending {
                background: #e2e3e5 !important; /* You can also use #d1ecf1 if you prefer the teal */
                color: #383d41 !important;
            }

            .info-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 20px;
            }

            .info-item {
                padding: 15px;
                background: #f8f9fa;
                border-radius: 8px;
            }

            .info-label {
                font-size: 12px;
                color: #666;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 5px;
            }

            .info-value {
                font-size: 16px;
                font-weight: 600;
                color: #333;
            }

            .products-section {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .section-title {
                font-size: 20px;
                font-weight: 600;
                color: #333;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 2px solid #f0f0f0;
            }

            .product-item {
                display: flex;
                align-items: center;
                padding: 20px 0;
                border-bottom: 1px solid #f0f0f0;
            }

                .product-item:last-child {
                    border-bottom: none;
                }

            .product-image {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
                margin-right: 20px;
            }

            .product-details {
                flex: 1;
            }

            .product-name {
                font-size: 18px;
                font-weight: 600;
                color: #333;
                margin-bottom: 5px;
            }

            .product-category {
                color: #666;
                font-size: 14px;
                margin-bottom: 8px;
            }

            .product-price {
                font-size: 16px;
                font-weight: 600;
                color: #667eea;
            }

            .product-quantity {
                text-align: center;
                margin: 0 20px;
            }

            .quantity-badge {
                background: #667eea;
                color: white;
                padding: 8px 12px;
                border-radius: 20px;
                font-weight: 600;
            }

            .product-total {
                font-size: 18px;
                font-weight: 700;
                color: #333;
                text-align: right;
                min-width: 100px;
            }

            .customer-section {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .customer-info {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
            }

            .shipping-section {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .order-summary {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                padding: 10px 0;
                border-bottom: 1px solid #f0f0f0;
            }

                .summary-row:last-child {
                    border-bottom: none;
                    font-weight: 700;
                    font-size: 18px;
                    color: #667eea;
                }

            .action-buttons {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-top: 30px;
            }

            .btn-group {
                display: flex;
                gap: 15px;
                flex-wrap: wrap;
            }

            .btn {
                padding: 12px 24px;
                border-radius: 8px;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-primary {
                background: #667eea;
                border-color: #667eea;
            }

            .btn-success {
                background: #28a745;
                border-color: #28a745;
            }

            .btn-warning {
                background: #ffc107;
                border-color: #ffc107;
                color: #212529;
            }

            .btn-danger {
                background: #dc3545;
                border-color: #dc3545;
            }

            .btn-secondary {
                background: #6c757d;
                border-color: #6c757d;
            }
            /* Ensure white text on secondary buttons, including modal Cancel */
            .btn-secondary {
                color: #fff;
            }

                .btn-secondary:hover {
                    background: #5a6268;
                    border-color: #545b62;
                    color: #fff;
                }
            /* Add styles for info and dark buttons used in actions */
            .btn-info {
                background: #17a2b8;
                border-color: #17a2b8;
                color: #fff;
            }

                .btn-info:hover {
                    background: #138496;
                    border-color: #138496;
                    color: #fff;
                }

            .btn-dark {
                background: #343a40;
                border-color: #343a40;
                color: #fff;
            }

                .btn-dark:hover {
                    background: #23272b;
                    border-color: #23272b;
                    color: #fff;
                }

            .btn-back {
                background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
                color: #fff !important;
                border: 0;
                border-radius: 30px;
                padding: 8px 16px;
                box-shadow: 0 6px 18px rgba(56,249,215,.35);
                transition: transform .2s ease, box-shadow .2s ease, opacity .2s ease;
            }

                .btn-back:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 24px rgba(56,249,215,.45);
                    text-decoration: none;
                    opacity: .95;
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
                        <h1><i class="fas fa-file-alt"></i> Order Details</h1>
                        <p class="mb-0" id="orderIdDisplay">
                            Viewing order details
                        </p>
                    </div>
                    <div class="col-md-6 text-right">
                        <a href="orders.aspx" class="btn btn-back btn-sm ml-2"><i class="fas fa-arrow-left"></i> Back to Orders</a> <a href="../home.aspx" class="btn btn-store btn-sm ml-2"><i class="fas fa-home"></i> Back to Store </a> <a href="../login_register.aspx" class="btn btn-logout btn-sm ml-2"><i class="fas fa-sign-out-alt"></i> Logout </a>
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
                        <a href="products.aspx" class="nav-link"><i class="fas fa-box"></i> Products </a>
                        <a href="categories.aspx" class="nav-link"><i class="fas fa-tags"></i> Categories </a>
                        <a href="orders.aspx" class="nav-link active"><i class="fas fa-shopping-cart"></i> Orders </a>
                        <a href="customers.aspx" class="nav-link"><i class="fas fa-users"></i> Customers </a>
                        <a href="feedback.aspx" class="nav-link"><i class="fas fa-comments"></i> Feedback</a>
                        <a href="notifications.aspx" class="nav-link"><i class="fas fa-bullhorn"></i> Notifications</a>
                        <a href="analytics.aspx" class="nav-link"><i class="fas fa-chart-bar"></i> Analytics </a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <asp:HiddenField ID="hdnOrderId" runat="server" />
        <div class="content-container">
            <div class="container">
                <!-- Page Header -->
                <div class="page-header">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h2><i class="fas fa-file-alt"></i> Order Details</h2>
                            <p class="mb-0">
                                Complete information about this order
                            </p>
                        </div>
                        <div class="col-md-6 text-right">
                            <button class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-print"></i> Print Order
                            </button>
                            <button class="btn btn-outline-success btn-sm ml-2">
                                <i class="fas fa-envelope"></i> Email Customer
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Update Order Status Modal (same as orders list) -->
                <div class="modal fade" id="updateStatusModal" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"><i class="fas fa-edit"></i> Update Order Status</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label>Current Status</label>
                                    <asp:TextBox ID="txtCurrentStatus" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label>New Status *</label>
                                    <asp:DropDownList ID="ddlNewStatus" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="pending">Pending</asp:ListItem>
                                        <asp:ListItem Value="processing">Processing</asp:ListItem>
                                        <asp:ListItem Value="shipped">Shipped</asp:ListItem>
                                        <asp:ListItem Value="delivered">Delivered</asp:ListItem>
                                        <asp:ListItem Value="cancelled">Cancelled</asp:ListItem>
                                        <asp:ListItem Value="completed">Completed</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                <asp:Button ID="btnSaveStatus" runat="server" Text="Update Status" CssClass="btn btn-primary" OnClick="btnSaveStatus_Click" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Information -->
                <div class="order-info-card">
                    <div class="order-header">
                        <asp:Label ID="lblOrderId" runat="server" CssClass="order-id" Text="#ORD-000"></asp:Label>
                        <asp:Label ID="lblOrderStatus" runat="server" CssClass="order-status" Text="Status"></asp:Label>
                    </div>
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">Order Date</div>
                            <asp:Label ID="lblOrderDate" runat="server" CssClass="info-value"></asp:Label>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Payment Method</div>
                            <asp:Label ID="lblPaymentMethod" runat="server" CssClass="info-value"></asp:Label>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Payment Status</div>
                            <asp:Label ID="lblPaymentStatus" runat="server" CssClass="info-value">Paid</asp:Label>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Payment Amount</div>
                            <asp:Label ID="lblPaymentAmount" runat="server" CssClass="info-value"></asp:Label>
                        </div>
                    </div>
                </div>


                <!-- Products Ordered -->
                <div class="products-section">
                    <h3 class="section-title"><i class="fas fa-box"></i> Products Ordered</h3>
                    <asp:DataList ID="dlProducts" runat="server" Width="100%" RepeatLayout="Flow">
                        <ItemTemplate>
                            <div class="product-item">
                                <img src='<%# "../" + Eval("image_url") %>' alt='<%# Eval("product_name") %>' class="product-image" />
                                <div class="product-details">
                                    <div class="product-name"><%# Eval("product_name") %></div>
                                    <div class="product-price"><%# Eval("price_at_purchase", "{0:C}") %></div>
                                </div>
                                <div class="product-quantity">
                                    <span class="quantity-badge"><%# Eval("quantity") %></span>
                                </div>
                                <div class="product-total">
                                    <%# (Convert.ToDecimal(Eval("price_at_purchase")) * Convert.ToInt32(Eval("quantity"))).ToString("C") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                </div>

                <!-- Customer Information -->
                <div class="customer-section">
                    <h3 class="section-title"><i class="fas fa-user"></i> Customer Information</h3>
                    <div class="customer-info">
                        <div class="info-item">
                            <div class="info-label">Customer Name</div>
                            <asp:Label ID="lblCustomerName" runat="server" CssClass="info-value"></asp:Label>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Email</div>
                            <asp:Label ID="lblCustomerEmail" runat="server" CssClass="info-value"></asp:Label>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Gender</div>
                            <asp:Label ID="lblCustomerGender" runat="server" CssClass="info-value"></asp:Label>
                        </div>
                        <div class="info-item">
                            <div class="info-label">User ID</div>
                            <asp:Label ID="lblCustomerId" runat="server" CssClass="info-value"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- Billing Information -->
                <div class="shipping-section">
                    <h3 class="section-title"><i class="fas fa-file-invoice"></i> Billing Information</h3>
                    <div class="customer-info">
                        <div class="info-item">
                            <div class="info-label">Billing Address</div>
                            <asp:Label ID="lblBillingAddress" runat="server" CssClass="info-value"></asp:Label>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Mobile Number</div>
                            <asp:Label ID="lblMobileNumber" runat="server" CssClass="info-value" Text="n/a"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- Order Summary -->
                <div class="order-summary">
                    <h3 class="section-title"><i class="fas fa-calculator"></i> Order Summary</h3>
                    <div class="summary-row">
                        <span>Subtotal</span>
                        <asp:Label ID="lblSubtotal" runat="server"></asp:Label>
                    </div>
                    <div class="summary-row">
                        <span>Shipping</span>
                        <asp:Label ID="lblShipping" runat="server"></asp:Label>
                    </div>
                    <div class="summary-row">
                        <span>Total</span>
                        <asp:Label ID="lblTotal" runat="server"></asp:Label>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="action-buttons">
                    <h3 class="section-title"><i class="fas fa-cogs"></i> Actions</h3>
                    <div class="btn-group">
                        <asp:Button ID="btnUpdateStatus" runat="server" Text="Update Status" CssClass="btn btn-primary" OnClick="btnUpdateStatus_Click" />
                        <asp:Button ID="btnMarkShipped" runat="server" Text="Mark as Shipped" CssClass="btn btn-success" CommandName="Shipped" OnClick="btnQuickStatus_Click" />
                        <asp:Button ID="btnCancelOrder" runat="server" Text="Cancel Order" CssClass="btn btn-danger" CommandName="Cancelled" OnClick="btnQuickStatus_Click" OnClientClick="return confirm('are you sure you want to cancel this order?');" />
                        <a class="btn btn-info" href="orders.aspx"><i class="fas fa-list"></i> All Orders</a>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            // Get order ID from URL parameters
            const urlParams = new URLSearchParams(window.location.search);
            const orderId = urlParams.get('id');

            if (orderId) {
                loadOrderDetails(orderId);
            }

            function loadOrderDetails(id) {
                // This would typically make an API call to get order details
                // For now, we'll simulate loading data based on the order ID
                console.log('Loading order details for:', id);

                // Update page title and order ID
                document.getElementById('orderId').textContent = `#${id}`;
                document.getElementById('orderIdDisplay').textContent = `Viewing order ${id}`;

                // Simulate loading different order data based on ID
                if (id === 'ORD-002') {
                    loadOrderData({
                        status: 'Processing',
                        date: 'Dec 14, 2024 at 11:45 AM',
                        customer: 'Jane Smith',
                        email: 'jane.smith@email.com',
                        phone: '+1 (555) 987-6543',
                        userId: '12346',
                        products: [
                            {
                                name: 'Yellow Tulips',
                                category: 'Tulips, Seasonal',
                                price: 45.50,
                                quantity: 2,
                                image: '../img/340x420(tulip yellow).jpg'
                            }
                        ],
                        subtotal: 91.00,
                        shipping: 5.99,
                        tax: 7.28,
                        total: 104.27
                    });
                } else if (id === 'ORD-003') {
                    loadOrderData({
                        status: 'Shipped',
                        date: 'Dec 13, 2024 at 4:20 PM',
                        customer: 'Mike Johnson',
                        email: 'mike.j@email.com',
                        phone: '+1 (555) 456-7890',
                        userId: '12347',
                        products: [
                            {
                                name: 'Cottage Garden Mix',
                                category: 'Bouquets, Seasonal',
                                price: 67.25,
                                quantity: 1,
                                image: '../img/340x420(cottage).jpg'
                            }
                        ],
                        subtotal: 67.25,
                        shipping: 5.99,
                        tax: 5.38,
                        total: 78.62
                    });
                }
            }

            function loadOrderData(data) {
                // Update order status
                document.getElementById('orderStatus').textContent = data.status;
                document.getElementById('orderStatus').className = `order-status status-${data.status.toLowerCase()}`;

                // Update customer information
                document.getElementById('customerName').textContent = data.customer;
                document.getElementById('customerEmail').textContent = data.email;
                const genderEl = document.getElementById('customerGender');
                if (genderEl) genderEl.textContent = 'Male';
                document.getElementById('customerId').textContent = data.userId;

                // Update products list
                const productsList = document.getElementById('productsList');
                productsList.innerHTML = '';

                data.products.forEach(product => {
                    const productHtml = `
					<div class="product-item">
						<img src="${product.image}" alt="${product.name}" class="product-image">
						<div class="product-details">
							<div class="product-name">${product.name}</div>
							<div class="product-category">Category: ${product.category}</div>
							<div class="product-price">$${product.price.toFixed(2)}</div>
						</div>
						<div class="product-quantity">
							<span class="quantity-badge">${product.quantity}</span>
						</div>
						<div class="product-total">$${(product.price * product.quantity).toFixed(2)}</div>
					</div>
				`;
                    productsList.innerHTML += productHtml;
                });

                // Update order summary
                document.getElementById('subtotal').textContent = `$${data.subtotal.toFixed(2)}`;
                document.getElementById('shipping').textContent = `$${data.shipping.toFixed(2)}`;
                document.getElementById('total').textContent = `$${data.total.toFixed(2)}`;
            }

            function openUpdateStatusModal() {
                // Populate modal fields similar to orders list
                document.getElementById('modalOrderId').value = orderId || document.getElementById('orderId').textContent.replace('#', '');
                document.getElementById('currentStatus').value = document.getElementById('orderStatus').textContent;
                $('#updateStatusModal').modal('show');
            }

            function markAsShipped() {
                if (confirm('Mark this order as shipped?')) {
                    // Here you would make an API call to update the status
                    alert('Order marked as shipped successfully!');
                    location.reload();
                }
            }



            function cancelOrder() {
                if (confirm('Are you sure you want to cancel this order? This action cannot be undone.')) {
                    // Here you would make an API call to cancel the order
                    alert('Order cancelled successfully!');
                    location.reload();
                }
            }

            function viewCustomerHistory() {
                // Navigate to customer details page
                const customerId = document.getElementById('customerId').textContent;
                window.location.href = `customers.aspx?view=${customerId}`;
            }

            // Handle status update form submission (same behavior as orders list)
            document.getElementById('updateStatusForm').addEventListener('submit', function (e) {
                e.preventDefault();
                const formData = new FormData(this);
                const updateData = Object.fromEntries(formData);
                console.log('Updating order status:', updateData);
                alert('Order status updated successfully!');
                $('#updateStatusModal').modal('hide');
                location.reload();
            });
        </script>
    </body>
    </html>
</asp:Content>
