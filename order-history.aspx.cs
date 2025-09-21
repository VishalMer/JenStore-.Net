using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq; // Add this using directive
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore
{
    public partial class order_history1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            if (!IsPostBack)
            {
                divOrderDetails.Visible = false;
                BindOrderHistoryGrid();
            }
        }

        private void BindOrderHistoryGrid()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            getcon();
            cmd = new SqlCommand("select order_id, order_date, order_status, total_amount, payment_method from Orders where user_id = " + userId + " order by order_date desc", con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            gvOrderHistory.DataSource = dt;
            gvOrderHistory.DataBind();

            con.Close();
        }

        private void BindOrderDetails(int orderId)
        {
            getcon();
            cmd = new SqlCommand("select order_date, order_status, payment_method, shipping_address, total_amount from Orders where order_id = " + orderId, con);
            SqlDataReader reader = cmd.ExecuteReader();
            decimal grandTotal = 0;

            if (reader.Read())
            {
                lblOrderID.Text = "#ORD-" + orderId;
                lblOrderDate.Text = Convert.ToDateTime(reader["order_date"]).ToString("MMMM dd, yyyy");
                lblOrderStatus.Text = reader["order_status"].ToString();
                lblPaymentMethod.Text = reader["payment_method"].ToString();
                lblShippingAddress.Text = reader["shipping_address"].ToString().Replace(", ", "<br />");
                grandTotal = Convert.ToDecimal(reader["total_amount"]);
            }
            reader.Close();

            SqlDataAdapter sda = new SqlDataAdapter("select od.quantity, od.price_at_purchase, p.product_name, p.image_url from OrderDetails od inner join Products p on od.product_id = p.product_id where od.order_id = " + orderId, con);
            DataTable dtItems = new DataTable();
            sda.Fill(dtItems);

            rptOrderItems.DataSource = dtItems;
            rptOrderItems.DataBind();

            decimal subTotal = 0;
            foreach (DataRow row in dtItems.Rows)
            {
                subTotal += Convert.ToDecimal(row["price_at_purchase"]) * Convert.ToInt32(row["quantity"]);
            }
            decimal shippingFee = grandTotal - subTotal;

            lblSubTotal.Text = subTotal.ToString("C");
            lblShipping.Text = shippingFee.ToString("C");
            lblGrandTotal.Text = grandTotal.ToString("C");

            con.Close();
        }

        // New event that fires after the GridView is bound
        protected void gvOrderHistory_DataBound(object sender, EventArgs e)
        {
            if (gvOrderHistory.PageCount > 1)
            {
                rptPager.DataSource = Enumerable.Range(0, gvOrderHistory.PageCount);
                rptPager.DataBind();
            }
        }

        // New event for clicks on the page numbers
        protected void rptPager_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            divOrderDetails.Visible = false;
            gvOrderHistory.PageIndex = Convert.ToInt32(e.CommandArgument);
            BindOrderHistoryGrid();
        }

        // New event for clicks on 'Previous' and 'Next'
        protected void lnkPage_Click(object sender, EventArgs e)
        {
            divOrderDetails.Visible = false;
            LinkButton lnk = (LinkButton)sender;
            string command = lnk.CommandArgument;

            if (command == "Prev" && gvOrderHistory.PageIndex > 0)
            {
                gvOrderHistory.PageIndex--;
            }
            else if (command == "Next" && gvOrderHistory.PageIndex < gvOrderHistory.PageCount - 1)
            {
                gvOrderHistory.PageIndex++;
            }
            BindOrderHistoryGrid();
        }

        protected void gvOrderHistory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);
                divOrderDetails.Visible = true;
                BindOrderDetails(orderId);
            }
        }

        protected string GetStatusClass(object status)
        {
            string statusStr = status.ToString().ToLower();
            switch (statusStr)
            {
                case "completed": return "status-completed";
                case "delivered": return "status-delivered";
                case "shipped": return "status-shipped";
                case "processing": return "status-processing";
                case "cancelled": return "status-cancelled";
                default: return "status-pending";
            }
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}