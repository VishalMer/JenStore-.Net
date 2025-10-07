using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore
{
    public partial class order1 : System.Web.UI.Page
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
                fillOrderDL();
            }
        }

        void fillOrderDL()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            int latestOrderId = 0;

            cmd = new SqlCommand("select top 1 order_id from Orders where user_id = " + userId + " order by order_id desc", con);
            object result = cmd.ExecuteScalar();

            if (result == null || result == DBNull.Value)
            {
                orderDetailsContainer.Visible = false;
                return;
            }

            latestOrderId = Convert.ToInt32(result);

            decimal grandTotal = 0;
            SqlDataAdapter da = new SqlDataAdapter("select order_date, order_status, payment_method, shipping_address, total_amount from Orders where order_id = " + latestOrderId, con);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataRow orRow = ds.Tables[0].Rows[0];

                lblOrderID.Text = "#ORD-" + latestOrderId;
                lblOrderDate.Text = Convert.ToDateTime(orRow["order_date"]).ToString("MMMM dd, yyyy");
                lblOrderStatus.Text = orRow["order_status"].ToString();
                lblPaymentMethod.Text = orRow["payment_method"].ToString();
                lblShippingAddress.Text = orRow["shipping_address"].ToString().Replace(", ", "<br />");
                grandTotal = Convert.ToDecimal(orRow["total_amount"]);
            }

            // Fetch the items 
            SqlDataAdapter sda = new SqlDataAdapter("select od.quantity, od.price_at_purchase, p.product_name, p.image_url from OrderDetails od inner join Products p on od.product_id = p.product_id where od.order_id = " + latestOrderId, con);

            DataTable dtItems = new DataTable();
            sda.Fill(dtItems);

            dlOrderItems.DataSource = dtItems;
            dlOrderItems.DataBind();

            // Calculate totals
            decimal subTotal = 0;
            foreach (DataRow row in dtItems.Rows)
            {
                subTotal += Convert.ToDecimal(row["price_at_purchase"]) * Convert.ToInt32(row["quantity"]);
            }
            decimal shippingFee = grandTotal - subTotal;

            // Display totals
            lblSubTotal.Text = subTotal.ToString("C");
            lblShipping.Text = shippingFee.ToString("C");
            lblGrandTotal.Text = grandTotal.ToString("C");

        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}