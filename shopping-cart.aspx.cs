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
            getcon();

            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            if (!IsPostBack)
            {
                fillCartGrid();
            }
        }

        void fillCartGrid()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            decimal subTotal = 0;

            string query = "select C.cart_item_id, C.product_id, C.quantity, P.product_name, P.price, P.image_url, P.stock_quantity from Cart C " +
                           "inner join Products P on C.product_id = P.product_id where C.user_id = " + userId;

            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            foreach (DataRow row in dt.Rows)
            {
                subTotal += Convert.ToDecimal(row["price"]) * Convert.ToInt32(row["quantity"]);
            }

            gvCartProducts.DataSource = dt;
            gvCartProducts.DataBind();

            lblSubTotal.Text = subTotal.ToString("C");
        }

        protected void gvCartCommand(object sender, GridViewCommandEventArgs e)
        {
            int cartItemId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Increase")
            {
                cmd = new SqlCommand("update Cart set quantity = quantity + 1 where cart_item_id = " + cartItemId, con);
                cmd.ExecuteNonQuery();
            }
            else if (e.CommandName == "Decrease")
            {
                cmd = new SqlCommand("select quantity from Cart where cart_item_id = " + cartItemId, con);
                int currentQuantity = (int)cmd.ExecuteScalar();

                if (currentQuantity > 1)
                {
                    cmd = new SqlCommand("update Cart set quantity = quantity - 1 where cart_item_id = " + cartItemId, con);
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    cmd = new SqlCommand("delete from Cart where cart_item_id = " + cartItemId, con);
                    cmd.ExecuteNonQuery();
                }
            }
            else if (e.CommandName == "RemoveItem")
            {
                cmd = new SqlCommand("delete from Cart where cart_item_id = " + cartItemId, con);
                cmd.ExecuteNonQuery();
            }

            fillCartGrid();
        }

        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            cmd = new SqlCommand("delete from Cart where user_id = " + userId, con);
            cmd.ExecuteNonQuery();
            con.Close();

        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}