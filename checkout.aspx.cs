using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
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
            getcon();

            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            if (!IsPostBack)
            {
                fillDL();
            }
        }

        void fillDL()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            decimal subTotal = 0;
            decimal shippingFee = 0;

            SqlDataAdapter sda = new SqlDataAdapter("select c.quantity, p.product_name, p.price from Cart c inner join Products p on c.product_id = p.product_id where c.user_id = " + userId + " and p.stock_quantity > 0", con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                con.Close();
                Response.Write("<script>alert('Your cart has no items eligible for checkout.'); window.location='shopping-cart.aspx';</script>");
                return;
            }

            dlOrderSummary.DataSource = dt;
            dlOrderSummary.DataBind();

            foreach (DataRow row in dt.Rows)
            {
                subTotal += Convert.ToDecimal(row["price"]) * Convert.ToInt32(row["quantity"]);
            }

            if (subTotal > 0 && subTotal < 1000)
            {
                shippingFee = 40;
            }
            decimal grandTotal = subTotal + shippingFee;

            lblSubTotal.Text = subTotal.ToString();
            lblShipping.Text = shippingFee.ToString();
            lblOrderTotal.Text = grandTotal.ToString();
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if (!validation())
            {
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            SqlDataAdapter da = new SqlDataAdapter("select c.product_id, c.quantity, p.price, p.stock_quantity from Cart c inner join Products p on c.product_id = p.product_id where c.user_id = " + userId, con);
            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                Response.Write("<script>alert('Your cart is empty!');</script>");
                return;
            }

            decimal subTotal = 0;
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                if (Convert.ToInt32(row["quantity"]) > Convert.ToInt32(row["stock_quantity"]))
                {
                    Response.Write("<script>alert('Not enough stock for one of your product. Please re-check your cart.');</script>");
                    return;
                }
                subTotal += Convert.ToDecimal(row["price"]) * Convert.ToInt32(row["quantity"]);
            }

            decimal shippingCost = (subTotal > 0 && subTotal < 1000) ? 40 : 0;
            decimal orderTotal = subTotal + shippingCost;
            string shippingAddress = txtFullName.Text + ", " + txtAddress.Text + ", " + txtTownCity.Text + ", " + txtPostcode.Text + ", Phone: " + txtPhone.Text;
            string paymentMethod = rblPaymentMethod.SelectedValue;

            cmd = new SqlCommand("insert into Orders (user_id, total_amount, shipping_address, payment_method) values (" + userId + ", " + orderTotal + ", '" + shippingAddress.Replace("'", "''") + "', '" + paymentMethod + "'); select scope_identity();", con);
            int newOrderId = Convert.ToInt32(cmd.ExecuteScalar());

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                int productId = Convert.ToInt32(dr["product_id"]);
                int quantity = Convert.ToInt32(dr["quantity"]);
                decimal price = Convert.ToDecimal(dr["price"]);

                cmd = new SqlCommand("insert into OrderDetails (order_id, product_id, quantity, price_at_purchase) values (" + newOrderId + ", " + productId + ", " + quantity + ", " + price + ")", con);
                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("update Products set stock_quantity = stock_quantity - " + quantity + " where product_id = " + productId, con);
                cmd.ExecuteNonQuery();
            }

            cmd = new SqlCommand("delete from Cart where user_id = " + userId, con);
            cmd.ExecuteNonQuery();

            Response.Redirect("order.aspx");


        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }

         void Clear()
        {
            nameErr.Text = "";
            addErr.Text = "";
            cityErr.Text = "";
            postErr.Text = "";
            phoneErr.Text = "";
            payErr.Text = "";
        }

        private bool validation()
        {
            Clear(); 

            if (string.IsNullOrWhiteSpace(txtFullName.Text))
            {
                nameErr.Text = "Full Name is required!";
                return false;
            }
            if (!Regex.IsMatch(txtFullName.Text, @"^[a-zA-Z\s]+$"))
            {
                nameErr.Text = "Full Name can only contain letters and spaces.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtPhone.Text))
            {
                phoneErr.Text = "Phone Number is required!";
                return false;
            }
            if (!Regex.IsMatch(txtPhone.Text, @"^\d{10}$"))
            {
                phoneErr.Text = "Phone Number must be exactly 10 digits.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtAddress.Text))
            {
                addErr.Text = "Address is required!";
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtTownCity.Text))
            {
                cityErr.Text = "Town/City is required!";
                return false;
            }
            if (!Regex.IsMatch(txtTownCity.Text, @"^[a-zA-Z\s]+$"))
            {
                cityErr.Text = "Town/City can only contain letters and spaces.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtPostcode.Text))
            {
                postErr.Text = "Postcode is required!";
                return false;
            }
            if (!Regex.IsMatch(txtPostcode.Text, @"^\d{6}$"))
            {
                postErr.Text = "Postcode must be exactly 6 digits.";
                return false;
            }

            if (rblPaymentMethod.SelectedValue == "")
            {
                payErr.Text = "Please select a payment method!";
                return false;
            }

            return true;
        }
    }
}