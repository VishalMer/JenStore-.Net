using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore
{
    public partial class notifications1 : System.Web.UI.Page
    {
        string con_str = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            if (!IsPostBack)
            {
                BindAllData();
            }
        }

        void getcon()
        {
              con = new SqlConnection(con_str);
                con.Open();
            
        }

        void BindAllData()
        {
            string userId = Session["UserID"].ToString();

            // Get all notifications
            string query = "select * from notifications where user_id = " + userId + " order by created_date desc";
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            // Separate data into two views
            DataView orderUpdates = new DataView(ds.Tables[0]);
            orderUpdates.RowFilter = "notification_type = 'order'";

            DataView generalUpdates = new DataView(ds.Tables[0]);
            generalUpdates.RowFilter = "notification_type <> 'order'";

            // Bind Order Updates
            dlOrderUpdates.DataSource = orderUpdates;
            dlOrderUpdates.DataBind();
            pnlNoOrders.Visible = (orderUpdates.Count == 0);

            // Bind General Updates
            dlGeneralNotifications.DataSource = generalUpdates;
            dlGeneralNotifications.DataBind();
            pnlNoGeneral.Visible = (generalUpdates.Count == 0);

            // Update badge counts
            int orderUnread = 0;
            int generalUnread = 0;
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                if (Convert.ToBoolean(row["is_read"]) == false)
                {
                    if (row["notification_type"].ToString() == "order")
                        orderUnread++;
                    else
                        generalUnread++;
                }
            }

            lblOrderBadge.Text = orderUnread.ToString();
            lblOrderBadge.Visible = (orderUnread > 0);

            lblGeneralBadge.Text = generalUnread.ToString();
            lblGeneralBadge.Visible = (generalUnread > 0);
        }

        // --- Tab Switching Logic ---
        protected void tab_Click(object sender, EventArgs e)
        {
            LinkButton clickedTab = (LinkButton)sender;

            // Reset all tabs
            tabOrders.CssClass = "tab-button";
            tabGeneral.CssClass = "tab-button";
            pnlOrders.CssClass = "tab-content";
            pnlGeneral.CssClass = "tab-content";

            // Set the active tab
            if (clickedTab.CommandName == "Orders")
            {
                tabOrders.CssClass = "tab-button active";
                pnlOrders.CssClass = "tab-content active";
            }
            else
            {
                tabGeneral.CssClass = "tab-button active";
                pnlGeneral.CssClass = "tab-content active";
            }
        }

        // --- Notification Actions ---
        protected void dlNotifications_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string notificationId = e.CommandArgument.ToString();
            string userId = Session["UserID"].ToString();

            if (e.CommandName == "MarkRead")
            {
                cmd = new SqlCommand("update notifications set is_read = 1 where notification_id = " + notificationId + " and user_id = " + userId, con);
                cmd.ExecuteNonQuery();
            }
            else if (e.CommandName == "Delete")
            {
                cmd = new SqlCommand("delete from notifications where notification_id = " + notificationId + " and user_id = " + userId, con);
                cmd.ExecuteNonQuery();
            }

            BindAllData(); // Refresh the list
        }

        protected void btnMarkAllRead_Click(object sender, EventArgs e)
        {
            string userId = Session["UserID"].ToString();
            cmd = new SqlCommand("update notifications set is_read = 1 where user_id = " + userId + " and is_read = 0", con);
            cmd.ExecuteNonQuery();

            BindAllData(); // Refresh the list
        }

        // --- Helper Methods for Display ---
        public string GetUnreadClass(object isRead)
        {
            return Convert.ToBoolean(isRead) ? "" : "unread";
        }

        public string GetTypeClass(object type)
        {
            switch (type.ToString().ToLower())
            {
                case "order": return "order-update";
                case "feedback_reply": return "feedback";
                case "admin": return "admin-message";
                case "general": return "general";
                case "promotional": return "admin-message";
                default: return "general";
            }
        }

        public string GetIconForType(object type)
        {
            // This is a special case for the order tab
            if (type.ToString().Contains("shipped")) return "fas fa-truck";
            if (type.ToString().Contains("delivered")) return "fas fa-check-circle";
            if (type.ToString().Contains("processing")) return "fas fa-clock";

            // This is for the general tab
            switch (type.ToString().ToLower())
            {
                case "feedback_reply": return "fas fa-reply";
                case "admin": return "fas fa-bullhorn";
                case "promotional": return "fas fa-gift";
                default: return "fas fa-info-circle";
            }
        }

        public string GetTitleForType(object type)
        {
            switch (type.ToString().ToLower())
            {
                case "feedback_reply": return "Reply to Your Feedback";
                case "admin": return "Message from Admin";
                case "promotional": return "A Special Offer for You!";
                case "general": return "General Update";
                default: return "Notification";
            }
        }

        public string GetTitleForOrder(object message)
        {
            string msg = message.ToString().ToLower();
            if (msg.Contains("shipped")) return "Order Shipped";
            if (msg.Contains("delivered")) return "Order Delivered";
            if (msg.Contains("processing")) return "Order Processing";
            if (msg.Contains("cancelled")) return "Order Cancelled";
            return "Order Update";
        }
    }
}