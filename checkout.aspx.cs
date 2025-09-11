using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace JenStore
{
    public partial class checkout1 : System.Web.UI.Page
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
                rptOrderDetails();
            }
        }

        private void rptOrderDetails()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            decimal subTotal = 0;
            decimal shippingFee = 0;

            getcon();

            string query = @"
                SELECT C.quantity, P.product_name, P.price 
                FROM Cart C
                INNER JOIN Products P ON C.product_id = P.product_id
                WHERE C.user_id = " + userId + " AND P.stock_quantity > 0";

            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                con.Close();
                Response.Write("<script>alert('Your cart has no items eligible for checkout.'); window.location='shopping-cart.aspx';</script>");
                return;
            }

            rptOrderSummary.DataSource = dt;
            rptOrderSummary.DataBind();

            foreach (DataRow row in dt.Rows)
            {
                subTotal += Convert.ToDecimal(row["price"]) * Convert.ToInt32(row["quantity"]);
            }

            con.Close();

            if (subTotal > 0 && subTotal < 1000)
            {
                shippingFee = 40;
            }
            decimal grandTotal = subTotal + shippingFee;

            lblSubTotal.Text = subTotal.ToString("C");
            lblShipping.Text = shippingFee.ToString("C");
            lblOrderTotal.Text = grandTotal.ToString("C");
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            // get cart products
            getcon();
            string cartQuery = "SELECT C.product_id, C.quantity, P.price, P.stock_quantity FROM Cart C INNER JOIN Products P ON C.product_id = P.product_id WHERE C.user_id = " + userId;
            SqlDataAdapter sda = new SqlDataAdapter(cartQuery, con);
            DataTable pOrder = new DataTable();
            sda.Fill(pOrder);
            con.Close();

            if (pOrder.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Your cart is empty!');", true);
                return;
            }

            decimal subTotal = 0;
            foreach (DataRow row in pOrder.Rows)
            {
                if (Convert.ToInt32(row["quantity"]) > Convert.ToInt32(row["stock_quantity"]))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Not enough stock for one of your product. Please re-check your cart.');", true);
                    return;
                }
                subTotal += Convert.ToDecimal(row["price"]) * Convert.ToInt32(row["quantity"]);
            }

            decimal shippingCost = (subTotal > 0 && subTotal < 1000) ? 40 : 0;
            decimal orderTotal = subTotal + shippingCost;

            // save address and payment method in var
            string shippingAddress = txtFullName.Text + ", " + txtAddress.Text + ", " + txtTownCity.Text + ", " + txtPostcode.Text + ", Phone: " + txtPhone.Text;
            string paymentMethod = rblPaymentMethod.SelectedValue;

            getcon();
            string orderQuery = "INSERT INTO Orders (user_id, total_amount, shipping_address, payment_method) VALUES (" + userId + ", " + orderTotal + ", '" + shippingAddress.Replace("'", "''") + "', '" + paymentMethod + "'); SELECT SCOPE_IDENTITY();";
            cmd = new SqlCommand(orderQuery, con);
            int newOrderId = Convert.ToInt32(cmd.ExecuteScalar());
            con.Close();

            // insert order and updaet stock and delete products from cart
            getcon();
            foreach (DataRow item in pOrder.Rows)
            {
                int productId = Convert.ToInt32(item["product_id"]);
                int quantity = Convert.ToInt32(item["quantity"]);
                decimal price = Convert.ToDecimal(item["price"]);

                cmd = new SqlCommand("INSERT INTO OrderDetails (order_id, product_id, quantity, price_at_purchase) VALUES (" + newOrderId + ", " + productId + ", " + quantity + ", " + price + ")", con);
                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("UPDATE Products SET stock_quantity = stock_quantity - " + quantity + " WHERE product_id = " + productId, con);
                cmd.ExecuteNonQuery();
            }
            con.Close();

            getcon();
            cmd = new SqlCommand("DELETE FROM Cart WHERE user_id = " + userId, con);
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect("order.aspx");
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}