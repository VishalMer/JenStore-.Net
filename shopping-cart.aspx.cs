using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore
{
    public partial class shopping_cart1 : System.Web.UI.Page
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
                CartRepeater();
            }
        }

        private void CartRepeater()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            decimal subTotal = 0;

            getcon();

            string query = "select C.cart_item_id, C.product_id, C.quantity, P.product_name, P.price, P.image_url from Cart C " +
                           "inner join Products P on C.product_id = P.product_id where C.user_id = " + userId;

            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            foreach (DataRow row in dt.Rows)
            {
                subTotal += Convert.ToDecimal(row["price"]) * Convert.ToInt32(row["quantity"]);
            }

            rptCartProducts.DataSource = dt;
            rptCartProducts.DataBind();

            con.Close();

            lblSubTotal.Text = subTotal.ToString("C");
        }

        protected void btnIncrease_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int cartPId = Convert.ToInt32(btn.CommandArgument);

            getcon();
            cmd = new SqlCommand("update Cart set quantity = quantity + 1 where cart_item_id = " + cartPId, con);
            cmd.ExecuteNonQuery();
            con.Close();

            CartRepeater();
        }

        protected void btnDecrease_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int cartPId = Convert.ToInt32(btn.CommandArgument);

            getcon();

            cmd = new SqlCommand("select quantity from Cart where cart_item_id = " + cartPId, con);
            int currentQuantity = (int)cmd.ExecuteScalar();

            if (currentQuantity > 1)
            {
                cmd = new SqlCommand("update Cart set quantity = quantity - 1 where cart_item_id = " + cartPId, con);
                cmd.ExecuteNonQuery();
            }
            else
            {
                cmd = new SqlCommand("delete from Cart where cart_item_id = " + cartPId, con);
                cmd.ExecuteNonQuery();
            }

            con.Close();
            CartRepeater();
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int cartPId = Convert.ToInt32(btn.CommandArgument);

            getcon();
            cmd = new SqlCommand("delete from Cart where cart_item_id = " + cartPId, con);
            cmd.ExecuteNonQuery();
            con.Close();

            CartRepeater();
        }

        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            getcon();
            cmd = new SqlCommand("delete from Cart where user_id = " + userId, con);
            cmd.ExecuteNonQuery();
            con.Close();

            CartRepeater();
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}