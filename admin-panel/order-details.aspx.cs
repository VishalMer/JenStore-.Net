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
            string query = "select o.order_id, o.order_status, o.order_date, o.payment_method, o.total_amount, u.uname, " +
                "u.email, u.gender, o.user_id, o.shipping_address from orders o inner join users u on o.user_id = u.id where o.order_id = " + orderId;

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                // Order Info Card
                lblOrderId.Text = "#ord-" + ds.Tables[0].Rows[0][0].ToString();
                string status = ds.Tables[0].Rows[0][1].ToString();
                lblOrderStatus.Text = status;
                lblOrderStatus.CssClass = "order-status " + GetStatusClass(status);
                lblOrderDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0][2]).ToString("MMM dd, yyyy 'at' h:mm tt");
                lblPaymentMethod.Text = ds.Tables[0].Rows[0][3].ToString();
                lblPaymentAmount.Text = Convert.ToDecimal(ds.Tables[0].Rows[0][4]).ToString("c");

                // Customer Info 
                lblCustomerName.Text = ds.Tables[0].Rows[0][5].ToString();
                lblCustomerEmail.Text = ds.Tables[0].Rows[0][6].ToString();
                lblCustomerGender.Text = ds.Tables[0].Rows[0][7].ToString();
                lblCustomerId.Text = ds.Tables[0].Rows[0][8].ToString();

                // Billing Info
                string fullAddress = ds.Tables[0].Rows[0][9].ToString();

                if (fullAddress.Contains("Phone:"))
                {
                    string[] addressParts = fullAddress.Split(new[] { "Phone:" }, StringSplitOptions.None);

                    lblBillingAddress.Text = addressParts[0].Trim().TrimEnd(',');
                    lblMobileNumber.Text = addressParts[1].Trim();
                }
                else
                {
                    lblBillingAddress.Text = fullAddress;
                    lblMobileNumber.Text = "n/a";
                }


                // Order Summary 
                decimal total = Convert.ToDecimal(ds.Tables[0].Rows[0][4]);
                decimal shipping = 0;
                decimal subtotal = 0;

                if (total < 1000)
                {
                    shipping = 40;
                    subtotal = total - shipping;
                }
                else
                {
                    shipping = 0;
                    subtotal = total;
                }

                lblSubtotal.Text = subtotal.ToString("c");
                lblShipping.Text = shipping.ToString("c");
                lblTotal.Text = total.ToString("c");

                // list of products
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