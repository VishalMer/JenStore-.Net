using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic; 

namespace JenStore
{
    public partial class wishlist1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        int userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }
            userId = Convert.ToInt32(Session["UserID"]);
            if (!IsPostBack)
            {
                WishlistRepeater();
            }
        }

        private void WishlistRepeater()
        {
            getcon();
            cmd = new SqlCommand("select W.wishlist_item_id, P.product_id, P.product_name, P.price, P.image_url, P.stock_quantity from Wishlist W " +
                                 "inner join Products P ON W.product_id = P.product_id where W.user_id = " + userId, con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            rptWishlist.DataSource = dt;
            rptWishlist.DataBind();
            con.Close();
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int wishlistPId = Convert.ToInt32(btn.CommandArgument);

            getcon();
            cmd = new SqlCommand("delete from Wishlist where wishlist_item_id = " + wishlistPId, con);
            cmd.ExecuteNonQuery();
            con.Close();

            WishlistRepeater();
        }

        protected void btnRemoveAllFromWishlist_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("delete from Wishlist where user_id = " + userId, con);
            cmd.ExecuteNonQuery();
            con.Close();

            WishlistRepeater();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);
            AddToCart(userId, productId);
            WishlistRepeater();
        }

        private void AddToCart(int userId, int productId)
        {
            getcon();

            cmd = new SqlCommand("select stock_quantity from Products where product_id = " + productId, con);
            if ((int)cmd.ExecuteScalar() <= 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Sorry, this item is out of stock!');", true);
                con.Close();
                return;
            }

            cmd = new SqlCommand("select 1 from Cart where user_id = " + userId + " and product_id = " + productId, con);
            if (cmd.ExecuteScalar() != null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('This item is already in your cart.');", true);
                con.Close();
                return;
            }
            else
            {
                cmd = new SqlCommand("insert into Cart (user_id, product_id, quantity) values (" + userId + ", " + productId + ", 1)", con);
                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("delete from Wishlist where user_id = " + userId + " and product_id = " + productId, con);
                cmd.ExecuteNonQuery();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product moved to cart!');", true);
            }
            con.Close();
        }

        protected void btnAddAllToCart_Click(object sender, EventArgs e)
        {
            getcon();

            //select all which is not in cart and is in stock
            cmd = new SqlCommand("select P.product_id from Wishlist W inner join Products P ON W.product_id = P.product_id " +
                                 "where W.user_id = " + userId + " and P.stock_quantity > 0 " +
                                 "and P.product_id NOT IN (select product_id from Cart where user_id = " + userId + ")", con);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No eligible items to move to the cart.');", true);
                con.Close();
                return;
            }

            //insert wishlist to cart
            foreach (DataRow row in dt.Rows)
            {
                int productId = Convert.ToInt32(row["product_id"]);
                cmd = new SqlCommand("insert into Cart (user_id, product_id, quantity) values (" + userId + ", " + productId + ", 1)", con);
                cmd.ExecuteNonQuery();
            }

            //remove all which moved from wishlist
            List<string> PIdRemove = new List<string>();
            foreach (DataRow row in dt.Rows)
            {
                PIdRemove.Add(row["product_id"].ToString());
            }
            string idList = string.Join(",", PIdRemove);

            cmd = new SqlCommand("delete from Wishlist where user_id = " + userId + " and product_id in (" + idList + ")", con);
            cmd.ExecuteNonQuery();

            con.Close();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + dt.Rows.Count + " items were successfully moved to your cart.');", true);

            WishlistRepeater();
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}