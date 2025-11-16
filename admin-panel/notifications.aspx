<%@ Page Title="" Language="C#" MasterPageFile="~/admin-panel/notifications.Master" AutoEventWireup="true" CodeBehind="notifications.aspx.cs" Inherits="JenStore.admin_panel.notifications1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Notification Management - JenStore Admin</title>
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
                padding: 22px 0 !important;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .admin-nav {
                background: white;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 10px 0 !important;
            }

                .admin-nav .nav-link {
                    color: #333;
                    font-weight: 600;
                    padding: 10px 18px;
                    margin: 4px 6px !important;
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
                box-shadow: 0 6px 18px rgba(0, 114, 255, 0.35);
                transition: transform .2s ease, box-shadow .2s ease, opacity .2s ease;
            }

                .btn-store:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 24px rgba(0, 114, 255, 0.45);
                    text-decoration: none;
                    opacity: .95;
                }

            .btn-logout {
                background: linear-gradient(135deg, #ff5858 0%, #f857a6 100%);
                color: #fff !important;
                border: 0;
                border-radius: 30px;
                padding: 8px 16px;
                box-shadow: 0 6px 18px rgba(248, 87, 166, 0.35);
                transition: transform .2s ease, box-shadow .2s ease, opacity .2s ease;
            }

                .btn-logout:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 24px rgba(248, 87, 166, 0.45);
                    text-decoration: none;
                    opacity: .95;
                }

            .notification-container {
                padding: 40px 0;
            }

            .notification-tabs {
                background: white;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
                overflow: hidden;
            }

            .tab-buttons {
                display: flex;
                border-bottom: 1px solid #f0f0f0;
            }

            .tab-button {
                flex: 1;
                padding: 20px;
                background: none;
                border: none;
                font-size: 16px;
                font-weight: 500;
                color: #666;
                cursor: pointer;
                transition: all 0.3s ease;
                position: relative;
            }

                .tab-button.active {
                    color: #667eea;
                    background: #f8f9ff;
                }

                    .tab-button.active::after {
                        content: '';
                        position: absolute;
                        bottom: 0;
                        left: 0;
                        right: 0;
                        height: 3px;
                        background: #667eea;
                    }

            .tab-content {
                display: none;
                padding: 30px;
            }

                .tab-content.active {
                    display: block;
                }

            .form-section {
                background: white;
                border-radius: 10px;
                padding: 30px;
                margin-bottom: 30px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .form-group {
                margin-bottom: 20px;
            }

                .form-group label {
                    font-weight: 600;
                    color: #333;
                    margin-bottom: 8px;
                    display: block;
                }

            .form-control {
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 12px 15px;
                font-size: 14px;
                transition: border-color 0.3s ease;
            }

                .form-control:focus {
                    border-color: #667eea;
                    box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
                }

            .btn-send {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                color: white;
                border: none;
                padding: 12px 30px;
                border-radius: 5px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
            }

                .btn-send:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
                }

            .btn-preview {
                background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
                color: white;
                border: none;
                padding: 12px 30px;
                border-radius: 5px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-right: 10px;
            }

                .btn-preview:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(108, 117, 125, 0.4);
                }

            .recipient-list {
                max-height: 200px;
                overflow-y: auto;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 10px;
                background: #f8f9fa;
            }

            .recipient-item {
                display: flex;
                align-items: center;
                padding: 8px;
                border-radius: 3px;
                margin-bottom: 5px;
                background: white;
                border: 1px solid #e9ecef;
            }

                .recipient-item:hover {
                    background: #e9ecef;
                }

            .recipient-checkbox {
                margin-right: 10px;
            }

            .recipient-info {
                flex: 1;
            }

            .recipient-name {
                font-weight: 500;
                color: #333;
            }

            .recipient-email {
                font-size: 12px;
                color: #666;
            }

            .notification-history {
                background: white;
                border-radius: 10px;
                padding: 30px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .history-item {
                border-bottom: 1px solid #f0f0f0;
                padding: 20px 0;
            }

                .history-item:last-child {
                    border-bottom: none;
                }

            .history-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
            }

            .history-title {
                font-weight: 600;
                color: #333;
            }

            .history-time {
                color: #999;
                font-size: 12px;
            }

            .history-message {
                color: #666;
                margin-bottom: 10px;
            }

            .history-meta {
                display: flex;
                gap: 15px;
                font-size: 12px;
                color: #999;
            }

            .recipient-count {
                background: #667eea;
                color: white;
                padding: 2px 8px;
                border-radius: 12px;
                font-size: 11px;
            }

            .notification-type {
                background: #28a745;
                color: white;
                padding: 2px 8px;
                border-radius: 12px;
                font-size: 11px;
            }

            .template-section {
                background: white;
                border-radius: 10px;
                padding: 30px;
                margin-bottom: 30px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .template-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 20px;
                margin-top: 20px;
            }

            .template-card {
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 20px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

                .template-card:hover {
                    border-color: #667eea;
                    box-shadow: 0 3px 10px rgba(102, 126, 234, 0.2);
                }

                .template-card.selected {
                    border-color: #667eea;
                    background: #f8f9ff;
                }

            .template-title {
                font-weight: 600;
                color: #333;
                margin-bottom: 10px;
            }

            .template-preview {
                color: #666;
                font-size: 14px;
                line-height: 1.4;
            }

            .stats-cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                border-radius: 10px;
                padding: 20px;
                text-align: center;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                transition: transform 0.3s ease;
            }

                .stat-card:hover {
                    transform: translateY(-2px);
                }

            .stat-number {
                font-size: 28px;
                font-weight: 700;
                margin-bottom: 5px;
            }

            .stat-label {
                color: #666;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .total-sent {
                border-left: 4px solid #007bff;
            }

            .today-sent {
                border-left: 4px solid #28a745;
            }

            .pending-sent {
                border-left: 4px solid #ffc107;
            }

            .delivery-rate {
                border-left: 4px solid #dc3545;
            }

            .alert {
                background: none !important;
                border: none !important;
            }

            .DDlist {
                padding: 1px 15px !important;
            }

            .recipient-list label {
                display: inline-block; /* Overrides 'display: block' */
                font-weight: 500; /* Makes the text match your screenshot */
                margin-left: 8px; /* Adds a little space after the checkbox */
                vertical-align: middle;
            }
        </style>
    </head>
    <body>
        <!-- Admin Header -->
        <header class="admin-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h1><i class="fas fa-bullhorn"></i>Notification </h1>
                        <p class="mb-0">
                            Send notifications and manage user communications
                        </p>
                    </div>
                    <div class="col-md-6 text-right">
                        <a href="../home.aspx" class="btn btn-store btn-sm"><i class="fas fa-home"></i>Back to Store </a><a href="../login_register.aspx" class="btn btn-logout btn-sm ml-2"><i class="fas fa-sign-out-alt"></i>Logout </a>
                    </div>
                </div>
            </div>
        </header>

        <!-- Admin Navigation -->
        <nav class="admin-nav">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="col-12">
                            <a href="index.aspx" class="nav-link"><i class="fas fa-tachometer-alt"></i>Dashboard </a>
                            <a href="products.aspx" class="nav-link"><i class="fas fa-box"></i>Products </a>
                            <a href="categories.aspx" class="nav-link"><i class="fas fa-tags"></i>Categories </a>
                            <a href="orders.aspx" class="nav-link"><i class="fas fa-shopping-cart"></i>Orders </a>
                            <a href="customers.aspx" class="nav-link"><i class="fas fa-users"></i>Customers </a>
                            <a href="feedback.aspx" class="nav-link"><i class="fas fa-comments"></i>Feedback</a>
                            <a href="notifications.aspx" class="nav-link active"><i class="fas fa-bullhorn"></i>Notifications</a>
                            <a href="analytics.aspx" class="nav-link"><i class="fas fa-chart-bar"></i>Analytics </a>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="notification-container">
            <div class="container">
                <div class="stats-cards">
                    <div class="stat-card total-sent">
                        <div class="stat-number">
                            <asp:Label ID="lblTotalSent" runat="server">0</asp:Label>
                        </div>
                        <div class="stat-label">Total Sent</div>
                    </div>
                    <div class="stat-card today-sent">
                        <div class="stat-number">
                            <asp:Label ID="lblTodaySent" runat="server">0</asp:Label>
                        </div>
                        <div class="stat-label">Today</div>
                    </div>
                    <div class="stat-card pending-sent">
                        <div class="stat-number">
                            <asp:Label ID="lblPending" runat="server">0</asp:Label>
                        </div>
                        <div class="stat-label">Pending</div>
                    </div>
                    <div class="stat-card delivery-rate">
                        <div class="stat-number">
                            <asp:Label ID="lblDeliveryRate" runat="server">0%</asp:Label>
                        </div>
                        <div class="stat-label">Delivery Rate</div>
                    </div>
                </div>

                <div class="notification-tabs">
                    <div class="tab-buttons">
                        <asp:LinkButton ID="tabSend" runat="server" CssClass="tab-button active" OnClick="tab_Click" CommandName="Send">
                        <i class="fas fa-paper-plane"></i> Send Notification
                    </asp:LinkButton>
                        <asp:LinkButton ID="tabTemplates" runat="server" CssClass="tab-button" OnClick="tab_Click" CommandName="Templates">
                        <i class="fas fa-file-alt"></i> Templates
                    </asp:LinkButton>
                        <asp:LinkButton ID="tabHistory" runat="server" CssClass="tab-button" OnClick="tab_Click" CommandName="History">
                        <i class="fas fa-history"></i> History
                    </asp:LinkButton>
                    </div>

                    <asp:Panel ID="pnlSend" runat="server" CssClass="tab-content active">
                        <div class="form-section">
                            <h3><i class="fas fa-paper-plane"></i>Send New Notification</h3>
                            <asp:Label ID="lblStatus" runat="server" Visible="false" />
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Notification Type</label>
                                        <asp:DropDownList ID="ddlNotificationType" runat="server" CssClass="form-control DDlist">
                                            <asp:ListItem Value="announcement">General Message</asp:ListItem>
                                            <asp:ListItem Value="offer">Promotion/Offer</asp:ListItem>
                                            <asp:ListItem Value="system">Maintenance Notice</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Recipients</label>
                                <asp:DropDownList ID="ddlRecipientType" runat="server" CssClass="form-control DDlist" AutoPostBack="true" OnSelectedIndexChanged="ddlRecipientType_SelectedIndexChanged">
                                    <asp:ListItem Value="all">All Customers</asp:ListItem>
                                    <asp:ListItem Value="custom">Custom Selection</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <asp:Panel ID="pnlCustomRecipients" runat="server" CssClass="form-group" Visible="false">
                                <label>Select Recipients</label>
                                <div class="recipient-list">
                                    <asp:CheckBoxList ID="cblRecipients" runat="server">
                                        <%-- This will be filled from C# --%>
                                    </asp:CheckBoxList>
                                </div>
                            </asp:Panel>
                            <div class="form-group">
                                <label>Message</label>
                                <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="6" placeholder="enter your notification message" required="true"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Button ID="btnSend" runat="server" CssClass="btn-send" Text="Send Notification" OnClick="btnSend_Click" />
                            </div>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlTemplates" runat="server" CssClass="tab-content">
                        <div class="template-section">
                            <h3><i class="fas fa-file-alt"></i>Notification Templates</h3>
                            <p>Select a template to quickly create notifications</p>
                            <div class="template-grid">
                                <%-- This Repeater will load your templates --%>
                                <asp:Repeater ID="rptTemplates" runat="server" OnItemCommand="rptTemplates_ItemCommand">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnTemplate" runat="server" CssClass="template-card"
                                            CommandName="LoadTemplate" CommandArgument='<%# Eval("TemplateName") %>'>
                                        <div class="template-title"><%# Eval("TemplateName") %></div>
                                        <div class="template-preview"><%# Eval("PreviewText") %></div>
                                    </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlHistory" runat="server" CssClass="tab-content">
                        <div class="notification-history">
                            <h3><i class="fas fa-history"></i>Notification History</h3>
                            <asp:Repeater ID="rptHistory" runat="server">
                                <ItemTemplate>
                                    <div class="history-item">
                                        <div class="history-header">
                                            <div class="history-title"><%# GetHistoryTitle(Eval("message")) %></div>
                                            <div class="history-time"><%# Eval("created_date", "{0:MMM dd, yyyy h:mm tt}") %></div>
                                        </div>
                                        <div class="history-message"><%# Eval("message") %></div>
                                        <div class="history-meta">
                                            <span class="notification-type"><%# Eval("notification_type") %></span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>


        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            // Tab switching functionality
            function switchTab(tabName) {
                // Remove active class from all tabs and buttons
                document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active'));
                document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));

                // Add active class to selected tab
                document.querySelector(`[onclick="switchTab('${tabName}')"]`).classList.add('active');
                document.getElementById(tabName + 'Tab').classList.add('active');
            }

            // Update recipients based on selection
            function updateRecipients() {
                const recipientType = document.getElementById('recipientType').value;
                const customRecipients = document.getElementById('customRecipients');

                if (recipientType === 'custom') {
                    customRecipients.style.display = 'block';
                } else {
                    customRecipients.style.display = 'none';
                }
            }

            // Show/hide schedule time
            document.getElementById('sendTime').addEventListener('change', function () {
                const scheduleTime = document.getElementById('scheduleTime');
                if (this.value === 'scheduled') {
                    scheduleTime.style.display = 'block';
                } else {
                    scheduleTime.style.display = 'none';
                }
            });

            // Template selection
            function selectTemplate(templateType) {
                // Remove previous selection
                document.querySelectorAll('.template-card').forEach(card => card.classList.remove('selected'));

                // Add selection to clicked template
                event.currentTarget.classList.add('selected');

                // Switch to send tab
                switchTab('send');

                // Fill form with template data
                const templates = {
                    welcome: {
                        type: 'general',
                        subject: 'Welcome to JenStore!',
                        message: 'Welcome to JenStore! Thank you for joining us. Explore our beautiful collection of fresh flowers and let us help you make every occasion special. We\'re excited to serve you!'
                    },
                    promotion: {
                        type: 'promotion',
                        subject: 'Special Offer Just for You!',
                        message: 'Special offer just for you! Get 20% off your next order with code SAVE20. Valid until the end of this month. Don\'t miss out on this amazing deal!'
                    },
                    maintenance: {
                        type: 'maintenance',
                        subject: 'Scheduled Website Maintenance',
                        message: 'We\'ll be performing scheduled maintenance on our website on Sunday, March 15th from 2:00 AM to 4:00 AM EST. During this time, some features may be temporarily unavailable. We apologize for any inconvenience.'
                    },
                    order_shipped: {
                        type: 'order_update',
                        subject: 'Your Order Has Been Shipped!',
                        message: 'Great news! Your order has been shipped and is on its way. Track your package with tracking number: TRK123456789. Expected delivery: Tomorrow by 6 PM.'
                    },
                    feedback_reply: {
                        type: 'feedback_reply',
                        subject: 'Thank You for Your Feedback',
                        message: 'Thank you for your feedback! We appreciate your input and have taken your suggestions seriously. We\'re constantly working to improve our service and your feedback helps us do that.'
                    },
                    seasonal: {
                        type: 'promotion',
                        subject: 'Spring Collection is Here!',
                        message: 'Spring is here! Check out our beautiful new spring flower collection with fresh seasonal blooms. Get 15% off your first order with code SPRING15. Valid until March 31st.'
                    }
                };

                const template = templates[templateType];
                if (template) {
                    document.getElementById('notificationType').value = template.type;
                    document.getElementById('subject').value = template.subject;
                    document.getElementById('message').value = template.message;
                }
            }

            // Preview notification
            function previewNotification() {
                const subject = document.getElementById('subject').value;
                const message = document.getElementById('message').value;
                const type = document.getElementById('notificationType').value;

                if (!subject || !message) {
                    alert('Please fill in the subject and message fields.');
                    return;
                }

                const preview = `
				Notification Preview:
				
				Type: ${type}
				Subject: ${subject}
				
				Message:
				${message}
				
				Recipients: ${getRecipientCount()} users
			`;

                alert(preview);
            }

            // Get recipient count
            function getRecipientCount() {
                const recipientType = document.getElementById('recipientType').value;
                const counts = {
                    'all': 1247,
                    'customers': 1200,
                    'vip': 89,
                    'recent': 156,
                    'custom': document.querySelectorAll('.recipient-checkbox:checked').length
                };
                return counts[recipientType] || 0;
            }

            // Form submission
            document.getElementById('notificationForm').addEventListener('submit', function (e) {
                e.preventDefault();

                const formData = {
                    type: document.getElementById('notificationType').value,
                    priority: document.getElementById('priority').value,
                    recipients: document.getElementById('recipientType').value,
                    subject: document.getElementById('subject').value,
                    message: document.getElementById('message').value,
                    sendTime: document.getElementById('sendTime').value,
                    scheduledTime: document.getElementById('scheduledTime').value
                };

                // Validate form
                if (!formData.type || !formData.subject || !formData.message) {
                    alert('Please fill in all required fields.');
                    return;
                }

                // Simulate sending notification
                alert(`Notification sent successfully to ${getRecipientCount()} recipients!`);

                // Reset form
                this.reset();
                document.getElementById('customRecipients').style.display = 'none';
                document.getElementById('scheduleTime').style.display = 'none';
            });

            // Initialize page
            document.addEventListener('DOMContentLoaded', function () {
                // Set default scheduled time to tomorrow
                const tomorrow = new Date();
                tomorrow.setDate(tomorrow.getDate() + 1);
                tomorrow.setHours(9, 0, 0, 0);
                document.getElementById('scheduledTime').value = tomorrow.toISOString().slice(0, 16);
            });
        </script>
    </body>
    </html>
</asp:Content>
