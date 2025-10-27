<%@ Page Title="" Language="C#" MasterPageFile="~/admin-panel/feedback.Master" AutoEventWireup="true" CodeBehind="feedback.aspx.cs" Inherits="JenStore.admin_panel.feedback1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Customer Feedback - JenStore Admin</title>
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

            .feedback-container {
                padding: 40px 0;
            }

            .feedback-card {
                background: white;
                border-radius: 10px;
                padding: 25px;
                margin-bottom: 20px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                transition: transform 0.3s ease;
            }

                .feedback-card:hover {
                    transform: translateY(-2px);
                }

            .feedback-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
                padding-bottom: 15px;
                border-bottom: 1px solid #f0f0f0;
            }

            .feedback-meta {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .feedback-name {
                font-weight: 600;
                color: #333;
                font-size: 16px;
            }

            .feedback-email {
                color: #666;
                font-size: 14px;
            }

            .feedback-date {
                color: #999;
                font-size: 12px;
            }

            .feedback-message {
                color: #555;
                line-height: 1.6;
                margin-bottom: 15px;
            }

            .feedback-actions {
                display: flex;
                gap: 10px;
            }

            .btn-reply {
                background: #28a745;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 5px;
                font-size: 12px;
                transition: all 0.3s ease;
            }

                .btn-reply:hover {
                    background: #218838;
                    transform: translateY(-1px);
                }

            .btn-delete {
                background: #dc3545;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 5px;
                font-size: 12px;
                transition: all 0.3s ease;
            }

                .btn-delete:hover {
                    background: #c82333;
                    transform: translateY(-1px);
                }

            .btn-mark-read {
                background: #007bff;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 5px;
                font-size: 12px;
                transition: all 0.3s ease;
            }

                .btn-mark-read:hover {
                    background: #0056b3;
                    transform: translateY(-1px);
                }

            .feedback-status {
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: 600;
                text-transform: uppercase;
            }

            .status-new {
                background: #d1ecf1;
                color: #0c5460;
            }

            .status-read {
                background: #d4edda;
                color: #155724;
            }

            .status-replied {
                background: #fff3cd;
                color: #856404;
            }

            .filters-section {
                background: white;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 30px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .filter-group {
                display: flex;
                gap: 15px;
                align-items: center;
                flex-wrap: wrap;
            }

            .filter-select {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
            }

            .search-input {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
                min-width: 200px;
            }

            .stats-row {
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

            .total-feedback {
                border-left: 4px solid #007bff;
            }

            .new-feedback {
                border-left: 4px solid #28a745;
            }

            .replied-feedback {
                border-left: 4px solid #ffc107;
            }

            .read-feedback {
                border-left: 4px solid #6c757d;
            }

            .feedback-header .feedback-date{
                margin-top:-2.5em;
            }
        </style>
    </head>
    <body>
        <!-- Admin Header -->
        <header class="admin-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h1><i class="fas fa-comments"></i>Customer Feedback</h1>
                        <p class="mb-0">
                            Manage customer feedback and inquiries
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
                        <a href="index.aspx" class="nav-link"><i class="fas fa-tachometer-alt"></i>Dashboard </a><a href="products.aspx" class="nav-link"><i class="fas fa-box"></i>Products </a><a href="categories.aspx" class="nav-link"><i class="fas fa-tags"></i>Categories </a><a href="orders.aspx" class="nav-link"><i class="fas fa-shopping-cart"></i>Orders </a><a href="customers.aspx" class="nav-link"><i class="fas fa-users"></i>Customers </a><a href="feedback.aspx" class="nav-link active"><i class="fas fa-comments"></i>Feedback </a><a href="analytics.aspx" class="nav-link"><i class="fas fa-chart-bar"></i>Analytics </a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="feedback-container">
            <div class="container">
                <div class="row stats-row">
                    <div class="col-md-3 col-sm-6">
                        <div class="stat-card total-feedback">
                            <div class="stat-number">
                                <asp:Label ID="lblTotalFeedback" runat="server">0</asp:Label>
                            </div>
                            <div class="stat-label">Total Feedback</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stat-card new-feedback">
                            <div class="stat-number">
                                <asp:Label ID="lblNewFeedback" runat="server">0</asp:Label>
                            </div>
                            <div class="stat-label">New Messages</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stat-card replied-feedback">
                            <div class="stat-number">
                                <asp:Label ID="lblRepliedFeedback" runat="server">0</asp:Label>
                            </div>
                            <div class="stat-label">Replied</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stat-card read-feedback">
                            <div class="stat-number">
                                <asp:Label ID="lblReadFeedback" runat="server">0</asp:Label>
                            </div>
                            <div class="stat-label">Read</div>
                        </div>
                    </div>
                </div>

                <!-- Filters -->
                <div class="filters-section">
                    <div class="filter-group">
                        <select class="filter-select">
                            <option value="all">All Status</option>
                            <option value="new">New</option>
                            <option value="read">Read</option>
                            <option value="replied">Replied</option>
                        </select>
                        <select class="filter-select">
                            <option value="all">All Time</option>
                            <option value="today">Today</option>
                            <option value="week">This Week</option>
                            <option value="month">This Month</option>
                        </select>
                        <input type="text" class="search-input" placeholder="Search by name or email...">
                        <button class="btn btn-primary">
                            Filter
                        </button>
                    </div>
                </div>

                <!-- Feedback List -->
                <div class="row">
                    <div class="col-12">
                        <%-- Changed Repeater to DataList --%>
                        <asp:DataList ID="dlFeedback" runat="server" OnItemCommand="dlFeedback_ItemCommand" Width="100%" RepeatLayout="Flow">
                            <ItemTemplate>
                                <div class="feedback-card">
                                    <div class="feedback-header">
                                        <div class="feedback-meta">
                                            <div>
                                                <div class="feedback-name"><%# Eval("uname") %></div>
                                                <div class="feedback-email"><%# Eval("email") %></div>
                                            </div>
                                            <div class="feedback-date"><%# Eval("feedback_date", "{0:MMM dd, yyyy h:mm tt}") %></div>
                                        </div>
                                        <div>
                                            <span class='feedback-status <%# GetStatusClass(Eval("status")) %>'><%# Eval("status") %></span>
                                        </div>
                                    </div>
                                    <div class="feedback-message"><%# Eval("message") %></div>
                                    <div class="feedback-actions">
                                        <%--                                        <asp:Button ID="btnReply" runat="server" Text="Reply" CssClass="btn-reply" CommandName="Reply" CommandArgument='<%# Eval("feedback_id") %>' />--%>
                                        <button type="button" class="btn-reply" onclick="openReplyModal('<%# Eval("feedback_id") %>')">
                                            <i class="fas fa-reply"></i>Reply
                                        </button>
                                        <asp:Button ID="btnMarkRead" runat="server" Text="Mark as Read" CssClass="btn-mark-read" CommandName="MarkRead" CommandArgument='<%# Eval("feedback_id") %>' Visible='<%# Eval("status").ToString().ToLower() != "read" && Eval("status").ToString().ToLower() != "replied" %>' />
                                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn-delete" CommandName="DeleteFeedback" CommandArgument='<%# Eval("feedback_id") %>' OnClientClick="return confirm('are you sure you want to delete this feedback?');" />
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                </div>

                <!-- Pagination -->
                <div class="row">
                    <div class="col-12 text-center">
                        <nav aria-label="Feedback pagination">
                            <ul class="pagination">
                                <li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                                <li class="active"><a href="#">1</a></li>
                                <li><a href="#">2</a></li>
                                <li><a href="#">3</a></li>
                                <li><a href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="replyModal" tabindex="-1" role="dialog" aria-labelledby="replyModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="replyModalLabel">Reply to Feedback</h4>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="hdnReplyFeedbackId" runat="server" />
                        <div class="form-group">
                            <label for="txtReplyMessage">Your Reply:</label>
                            <asp:TextBox ID="txtReplyMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button ID="btnSendReply" runat="server" Text="Send Reply" CssClass="btn btn-primary" OnClick="btnSendReply_Click" />
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script type="text/javascript">
            function openReplyModal(feedbackId) {
                // Set the hidden field value
                document.getElementById('<%= hdnReplyFeedbackId.ClientID %>').value = feedbackId;
                // Clear previous message
                document.getElementById('<%= txtReplyMessage.ClientID %>').value = '';
                // Show the modal
                $('#replyModal').modal('show');
            }
        </script>
        <script>
            // Simple feedback management functionality
            $(document).ready(function () {
                // Mark as read functionality
                $('.btn-mark-read').click(function () {
                    var card = $(this).closest('.feedback-card');
                    var status = card.find('.feedback-status');
                    status.removeClass('status-new status-replied').addClass('status-read').text('Read');
                    $(this).hide();
                });

                // Delete functionality
                $('.btn-delete').click(function () {
                    if (confirm('Are you sure you want to delete this feedback?')) {
                        $(this).closest('.feedback-card').fadeOut(300, function () {
                            $(this).remove();
                        });
                    }
                });

                // Reply functionality (placeholder)
                //$('.btn-reply').click(function () {
                //    alert('Reply functionality would open an email client or reply form here.');
                //});

                // Filter functionality
                $('.filter-select').change(function () {
                    // Filter logic would be implemented here
                    console.log('Filter changed:', $(this).val());
                });

                // Search functionality
                $('.search-input').on('input', function () {
                    var searchTerm = $(this).val().toLowerCase();
                    $('.feedback-card').each(function () {
                        var name = $(this).find('.feedback-name').text().toLowerCase();
                        var email = $(this).find('.feedback-email').text().toLowerCase();
                        var message = $(this).find('.feedback-message').text().toLowerCase();

                        if (name.includes(searchTerm) || email.includes(searchTerm) || message.includes(searchTerm)) {
                            $(this).show();
                        } else {
                            $(this).hide();
                        }
                    });
                });
            });
        </script>
    </body>
    </html>
</asp:Content>
