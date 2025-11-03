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
    public partial class order_details1 : System.Web.UI.Page
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
                return;
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    string orderId = Request.QueryString["id"].ToString();
                    hdnOrderId.Value = orderId; 
                    fillOrderDetails(orderId);
                }
                else
                {
                    Response.Redirect("orders.aspx"); 
                }
            }
        }

        void getcon()
        {
           
                con = new SqlConnection(con_str);
                con.Open();
            
        }

        void fillOrderDetails(string orderId)
        {
            // get main order and customer info
            string query = "select * from orders o inner join users u on o.user_id = u.id where o.order_id = " + orderId;
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];

                // Order Info Card
                lblOrderId.Text = "#ord-" + row["order_id"].ToString();
                string status = row["order_status"].ToString();
                lblOrderStatus.Text = status;
                lblOrderStatus.CssClass = "order-status " + GetStatusClass(status);
                lblOrderDate.Text = Convert.ToDateTime(row["order_date"]).ToString("MMM dd, yyyy 'at' h:mm tt");
                lblPaymentMethod.Text = row["payment_method"].ToString();
                lblPaymentAmount.Text = Convert.ToDecimal(row["total_amount"]).ToString("c");

                // Customer Info 
                lblCustomerName.Text = row["uname"].ToString();
                lblCustomerEmail.Text = row["email"].ToString();
                lblCustomerGender.Text = row["gender"].ToString();
                lblCustomerId.Text = row["user_id"].ToString();

                // --- Populate Shipping Info ---
                lblBillingAddress.Text = row["shipping_address"].ToString();
               

                // Order Summary 
                decimal total = Convert.ToDecimal(row["total_amount"]);
                
                lblSubtotal.Text = total.ToString("c");
                lblShipping.Text = "$0.00";
                lblTotal.Text = total.ToString("c");

                // list of products for this order
                string productQuery = "select * from orderdetails od inner join products p on od.product_id = p.product_id where od.order_id = " + orderId;
                da = new SqlDataAdapter(productQuery, con);
                ds = new DataSet();
                da.Fill(ds);

                dlProducts.DataSource = ds;
                dlProducts.DataBind();
            }
        }

        public string GetStatusClass(object statusObj)
        {
            string status = statusObj.ToString().ToLower();
            switch (status)
            {
                case "pending": return "status-pending";
                case "processing": return "status-processing";
                case "shipped": return "status-shipped";
                case "delivered": return "status-delivered";
                case "cancelled": return "status-cancelled";
                case "completed": return "status-completed";
                default: return "status-pending";
            }
        }

        // Update Status button 
        protected void btnSaveStatus_Click(object sender, EventArgs e)
        {
            string orderId = hdnOrderId.Value;
            string newStatus = ddlNewStatus.SelectedValue;
            UpdateOrderStatus(orderId, newStatus);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "HideModal", "$('#updateStatusModal').modal('hide');", true);
            fillOrderDetails(orderId);
        }

        // main Update Status button
        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            txtCurrentStatus.Text = lblOrderStatus.Text;
            ddlNewStatus.SelectedValue = lblOrderStatus.Text.ToLower();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#updateStatusModal').modal('show');", true);
        }

        // Mark as Shipped and Cancel Order buttons
        protected void btnQuickStatus_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string newStatus = btn.CommandName; 
            string orderId = hdnOrderId.Value;
            UpdateOrderStatus(orderId, newStatus);
            fillOrderDetails(orderId);
        }

        //updates the DB and sends  notification
        void UpdateOrderStatus(string orderId, string newStatus)
        {
            cmd = new SqlCommand("update orders set order_status = '" + newStatus + "' where order_id = " + orderId, con);
            cmd.ExecuteNonQuery();

            // notification
            cmd = new SqlCommand("select user_id from orders where order_id = " + orderId, con);
            string userId = cmd.ExecuteScalar().ToString();
            string message = "The status of your #ORD-" + orderId + " has been updated to: " + newStatus;
            string link = "~/user-dashboard.aspx?view=orders&id=" + orderId;
            string query = "insert into notifications (user_id, message, notification_type, link_url) values (" + userId + ", '" + message + "', 'order', '" + link + "')";
            cmd = new SqlCommand(query, con);
            cmd.ExecuteNonQuery();
        }
    }
}