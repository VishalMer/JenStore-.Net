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
            getcon();

            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }
            userId = Convert.ToInt32(Session["UserID"]);

            if (!IsPostBack)
            {
                fillWishlistGrid();
            }
        }

        void fillWishlistGrid()
        {
            cmd = new SqlCommand("select W.wishlist_item_id, P.product_id, P.product_name, P.price, P.image_url, P.stock_quantity from Wishlist W " +
                                 "inner join Products P on W.product_id = P.product_id where W.user_id = " + userId, con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            gvWishlist.DataSource = dt;
            gvWishlist.DataBind();
        }

        protected void gvWishlistCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                int productId = Convert.ToInt32(e.CommandArgument);
                AddToCart(userId, productId);
                fillWishlistGrid();
            }
            else if (e.CommandName == "Remove")
            {
                int wishlistItemId = Convert.ToInt32(e.CommandArgument);
                cmd = new SqlCommand("delete from Wishlist where wishlist_item_id = " + wishlistItemId, con);
                cmd.ExecuteNonQuery();
                fillWishlistGrid();
            }
        }


        protected void btnRemoveAll_Click(object sender, EventArgs e)
        {
            cmd = new SqlCommand("delete from Wishlist where user_id = " + userId, con);
            cmd.ExecuteNonQuery();

            fillWishlistGrid();
        }

        void AddToCart(int userId, int productId)
        {

            cmd = new SqlCommand("select stock_quantity from Products where product_id = " + productId, con);
            if ((int)cmd.ExecuteScalar() <= 0)
            {
                Response.Write("<script>alert('Sorry, this item is out of stock!');</script>");
                return;
            }

            cmd = new SqlCommand("select 1 from Cart where user_id = " + userId + " and product_id = " + productId, con);
            if (cmd.ExecuteScalar() != null)
            {
                Response.Write("<script>alert('This item is already in your cart.');</script>");
                return;
            }
            else
            {
                cmd = new SqlCommand("insert into Cart (user_id, product_id, quantity) values (" + userId + ", " + productId + ", 1)", con);
                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("delete from Wishlist where user_id = " + userId + " and product_id = " + productId, con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Product moved to cart!');</script>");
            }
        }

        protected void btnAddAllToCart_Click(object sender, EventArgs e)
        {

            cmd = new SqlCommand("select P.product_id from Wishlist W inner join Products P ON W.product_id = P.product_id " +
                                 "where W.user_id = " + userId + " and P.stock_quantity > 0 " +
                                 "and P.product_id not in (select product_id from Cart where user_id = " + userId + ")", con);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                Response.Write("<script>alert('No eligible items to move to the cart.');</script>");
                return;
            }

            //insert wishlist to cart
            foreach (DataRow row in dt.Rows)
            {
                int productId = Convert.ToInt32(row["product_id"]);
                cmd = new SqlCommand("insert into Cart (user_id, product_id, quantity) values (" + userId + ", " + productId + ", 1)", con);
                cmd.ExecuteNonQuery();
            }

            string idList = "";
            foreach (DataRow row in dt.Rows)
            {
                idList += row["product_id"].ToString() + ",";
            }
            idList = idList.TrimEnd(',');

            //delete from wishlist
            cmd = new SqlCommand("delete from Wishlist where user_id = " + userId + " and product_id in (" + idList + ")", con);
            cmd.ExecuteNonQuery();

            Response.Write("<script>alert('" + dt.Rows.Count + " items were successfully moved to your cart.');</script>");

            fillWishlistGrid();
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}