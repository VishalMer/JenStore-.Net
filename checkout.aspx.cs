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

         bool validation()
        {
            Clear();

            if (string.IsNullOrWhiteSpace(txtFullName.Text))
            {
                nameErr.Text = "Full Name is required!";
                return false;
            }
            if (string.IsNullOrWhiteSpace(txtPhone.Text))
            {   
                phoneErr.Text = "Phone Number is required!";
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
            if (string.IsNullOrWhiteSpace(txtPostcode.Text))
            {
                postErr.Text = "Postcode is required!";
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