using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore.admin_panel
{
    public partial class orders1 : System.Web.UI.Page
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
                Response.Redirect("../login_register.aspx");
                return;
            }

            if (Session["UserRole"].ToString().ToLower() != "admin")
            {
                Response.Redirect("../home.aspx");
            }
            if (!IsPostBack)
            {
                BindOrders();
            }
        }

        void getcon()
        {
            
                con = new SqlConnection(con_str);
                con.Open();
            
        }

        void BindOrders()
        {
            string query = "select o.order_id, o.user_id, o.order_date, o.total_amount, o.order_status, u.uname, u.email, " +
                "(select count(distinct od.product_id) from orderdetails od where od.order_id = o.order_id) as product_count, " +
                "(select sum(od.quantity) from orderdetails od where od.order_id = o.order_id) as total_quantity from orders o inner join users u " +
                "on o.user_id = u.id order by o.order_date desc";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            gvOrders.DataSource = ds;
            gvOrders.DataBind();
        }

        public string GetStatusClass(object statusObj)
        {
            string status = statusObj.ToString().ToLower();
            switch (status)
            {
                case "pending":
                    return "status-pending";
                case "processing":
                    return "status-processing";
                case "shipped":
                    return "status-shipped";
                case "delivered":
                    return "status-delivered";
                case "cancelled":
                    return "status-cancelled";
                case "completed":
                    return "status-completed";
                default:
                    return "status-pending";
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewOrder")
            {
                string orderId = e.CommandArgument.ToString();
                Response.Redirect("order-details.aspx?id=" + orderId);
            }
            else if (e.CommandName == "OpenUpdateModal")
            {
                string[] args = e.CommandArgument.ToString().Split(',');
                string orderId = args[0];
                string currentStatus = args[1];

                hdnOrderId.Value = orderId;
                txtCurrentStatus.Text = currentStatus;
                ddlNewStatus.SelectedValue = currentStatus;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#updateStatusModal').modal('show');", true);
            }
        }
        protected void btnSaveStatus_Click(object sender, EventArgs e)
        {
            string orderId = hdnOrderId.Value;
            string newStatus = ddlNewStatus.SelectedValue;
            //string adminId = Session["admin_id"]?.ToString() ?? "null";

            // Update the order status in the database
            cmd = new SqlCommand("update orders set order_status = '" + newStatus + "' where order_id = " + orderId, con);
            cmd.ExecuteNonQuery();

            // Send a notification to the user
            string message = "The status of your #ORD-" + orderId + " has been updated to: " + newStatus;
            string link = "~/user-dashboard.aspx?view=orders&id=" + orderId;

            // Get the user_id for this order
            cmd = new SqlCommand("select user_id from orders where order_id = " + orderId, con);
            string userId = cmd.ExecuteScalar().ToString();

            string query = "insert into notifications (user_id, message, notification_type, link_url) values (" + userId + ", '" + message + "', 'order', '" + link + "')";
            cmd = new SqlCommand(query, con);
            cmd.ExecuteNonQuery();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "HideModal", "$('#updateStatusModal').modal('hide');", true);

            BindOrders();
        }
    }
}