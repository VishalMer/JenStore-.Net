using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore
{
    public partial class checkout1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            if (!IsPostBack)
            {
                BindOrderSummary();
            }
        }

        private void BindOrderSummary()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            decimal subTotal = 0;
            decimal shippingCost = 0; 

            using (SqlConnection con = new SqlConnection(connect))
            {
                const string query = @"
                    SELECT C.quantity, P.product_name, P.price 
                    FROM Cart C
                    INNER JOIN Products P ON C.product_id = P.product_id
                    WHERE C.user_id = @user_id AND P.stock_quantity > 0";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@user_id", userId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count == 0)
                        {
                            Response.Write("<script>alert('Your cart has no items eligible for checkout.'); window.location='shopping-cart.aspx';</script>");
                            return;
                        }

                        rptOrderSummary.DataSource = dt;
                        rptOrderSummary.DataBind();

                        foreach (DataRow row in dt.Rows)
                        {
                            subTotal += Convert.ToDecimal(row["price"]) * Convert.ToInt32(row["quantity"]);
                        }
                    }
                }
            }

            if (subTotal > 0 && subTotal < 1000)
            {
                shippingCost = 40;
            }

            decimal grandTotal = subTotal + shippingCost;

            lblSubTotal.Text = subTotal.ToString("C");
            lblShipping.Text = shippingCost.ToString("C");
            lblOrderTotal.Text = grandTotal.ToString("C");
        }


        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {

            int userId = Convert.ToInt32(Session["UserID"]);

            var addressBuilder = new StringBuilder();
            addressBuilder.AppendLine(txtFullName.Text);
            addressBuilder.AppendLine(txtAddress.Text);
            addressBuilder.AppendLine($"{txtTownCity.Text}, {txtPostcode.Text}");
            addressBuilder.AppendLine($"Phone: {txtPhone.Text}");
            string shippingAddress = addressBuilder.ToString();
            string paymentMethod = rblPaymentMethod.SelectedValue;

            using (SqlConnection con = new SqlConnection(connect))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();
                try
                {
                    var (itemsToOrder, orderTotal) = GetOrderItemsAndTotal(userId, con, transaction);

                    int newOrderId = CreateOrderRecord(userId, orderTotal, shippingAddress, paymentMethod, con, transaction);

                    CreateOrderDetailRecordsAndUpdateStock(newOrderId, itemsToOrder, con, transaction);

                    ClearUserCart(userId, con, transaction);

                    transaction.Commit(); 
                    Response.Redirect("order.aspx"); 
                }
                catch (Exception ex)
                {
                    //transaction.Rollback(); 
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error placing order: " + ex.Message.Replace("'", "\\'") + "');", true);
                }
            }
        }


        private (List<Tuple<int, int, decimal>> items, decimal total) GetOrderItemsAndTotal(int userId, SqlConnection con, SqlTransaction transaction)
        {
            var itemsToOrder = new List<Tuple<int, int, decimal>>(); 
            decimal subTotal = 0;
            const string cartQuery = @"SELECT C.product_id, C.quantity, P.price, P.stock_quantity FROM Cart C INNER JOIN Products P ON C.product_id = P.product_id WHERE C.user_id = @user_id AND P.stock_quantity > 0";

            using (SqlCommand cartCmd = new SqlCommand(cartQuery, con, transaction))
            {
                cartCmd.Parameters.AddWithValue("@user_id", userId);
                using (SqlDataReader reader = cartCmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        int productId = reader.GetInt32(0);
                        int quantity = reader.GetInt32(1);
                        decimal price = reader.GetDecimal(2);
                        int stock = reader.GetInt32(3);

                        if (quantity > stock) throw new Exception("Not enough stock for one of your items. Please review your cart.");

                        itemsToOrder.Add(new Tuple<int, int, decimal>(productId, quantity, price));
                        subTotal += price * quantity;
                    }
                }
            }

            if (itemsToOrder.Count == 0) throw new Exception("Your cart has no items in stock.");

            decimal shippingCost = (subTotal > 0 && subTotal < 1000) ? 40 : 0;
            return (itemsToOrder, subTotal + shippingCost);
        }

        private int CreateOrderRecord(int userId, decimal totalAmount, string address, string payment, SqlConnection con, SqlTransaction transaction)
        {
            const string query = "INSERT INTO Orders (user_id, total_amount, shipping_address, payment_method) VALUES (@user_id, @total, @address, @payment); SELECT SCOPE_IDENTITY();";
            using (SqlCommand cmd = new SqlCommand(query, con, transaction))
            {
                cmd.Parameters.AddWithValue("@user_id", userId);
                cmd.Parameters.AddWithValue("@total", totalAmount);
                cmd.Parameters.AddWithValue("@address", address);
                cmd.Parameters.AddWithValue("@payment", payment);
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        private void CreateOrderDetailRecordsAndUpdateStock(int orderId, List<Tuple<int, int, decimal>> items, SqlConnection con, SqlTransaction transaction)
        {
            foreach (var item in items)
            {
                int productId = item.Item1;
                int quantity = item.Item2;
                decimal price = item.Item3;

                const string detailsQuery = "INSERT INTO OrderDetails (order_id, product_id, quantity, price_at_purchase) VALUES (@order_id, @p_id, @qty, @price)";
                using (SqlCommand cmd = new SqlCommand(detailsQuery, con, transaction))
                {
                    cmd.Parameters.AddWithValue("@order_id", orderId);
                    cmd.Parameters.AddWithValue("@p_id", productId);
                    cmd.Parameters.AddWithValue("@qty", quantity);
                    cmd.Parameters.AddWithValue("@price", price);
                    cmd.ExecuteNonQuery();
                }

                const string stockQuery = "UPDATE Products SET stock_quantity = stock_quantity - @qty WHERE product_id = @p_id";
                using (SqlCommand cmd = new SqlCommand(stockQuery, con, transaction))
                {
                    cmd.Parameters.AddWithValue("@qty", quantity);
                    cmd.Parameters.AddWithValue("@p_id", productId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void ClearUserCart(int userId, SqlConnection con, SqlTransaction transaction)
        {
            const string query = "DELETE FROM Cart WHERE user_id = @user_id";
            using (SqlCommand cmd = new SqlCommand(query, con, transaction))
            {
                cmd.Parameters.AddWithValue("@user_id", userId);
                cmd.ExecuteNonQuery();
            }
        }
    }
}

