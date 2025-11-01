using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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

            getcon();

            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            if (!IsPostBack)
            {
                orDetailsDiv.Visible = false;
                fillOrderHis();
            }
        }

        void fillOrderHis()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            cmd = new SqlCommand("select order_id, order_date, order_status, total_amount, payment_method from Orders where user_id = " + userId + " order by order_date desc", con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            gvOrderHistory.DataSource = dt;
            gvOrderHistory.DataBind();
        }

        void showOrdDetails(int orderId)
        {
            decimal grandTotal = 0;

            SqlDataAdapter da = new SqlDataAdapter("select order_date, order_status, payment_method, shipping_address, total_amount from Orders where order_id = " + orderId, con);
            DataSet ds = new DataSet();
            da.Fill(ds);

            // Check for return order
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                lblOrderID.Text = "#ORD-" + orderId;
                lblOrderDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0][0]).ToString("MMMM dd, yyyy");
                lblOrderStatus.Text = ds.Tables[0].Rows[0][1].ToString();
                lblPaymentMethod.Text = ds.Tables[0].Rows[0][2].ToString();
                lblShippingAddress.Text = ds.Tables[0].Rows[0][3].ToString().Replace(", ", "<br />");
                grandTotal = Convert.ToDecimal(ds.Tables[0].Rows[0][4]);
            }

            SqlDataAdapter sda = new SqlDataAdapter("select od.quantity, od.price_at_purchase, p.product_name, p.image_url from OrderDetails od inner join Products p on od.product_id = p.product_id where od.order_id = " + orderId, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            dlorderItems.DataSource = dt;
            dlorderItems.DataBind();

            // Calculate total
            decimal subTotal = 0;
            foreach (DataRow dr in dt.Rows)
            {
                subTotal += Convert.ToDecimal(dr["price_at_purchase"]) * Convert.ToInt32(dr["quantity"]);
            }
            decimal shippingFee = grandTotal - subTotal;

            lblSubTotal.Text = subTotal.ToString("C");
            lblShipping.Text = shippingFee.ToString("C");
            lblGrandTotal.Text = grandTotal.ToString("C");

        }

        protected void viewDetails(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);
                orDetailsDiv.Visible = true;
                showOrdDetails(orderId);
            }
        }

        protected string GetStatusClass(object status)
        {

            string statusStr = status.ToString().ToLower();
            switch (statusStr)
            {
                case "delivered":
                    return "status-delivered";
                case "shipped":
                    return "status-shipped";
                case "processing":
                    return "status-processing";
                case "cancelled":
                    return "status-cancelled";
                default:
                    return "status-pending";
            }
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}