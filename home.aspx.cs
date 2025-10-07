using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore
{
    public partial class home1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
            productRepeaters();
        }

        void productRepeaters()
        {
            int userId = (Session["UserID"] != null) ? Convert.ToInt32(Session["UserID"]) : -1;

            fillReProd(rptCollection, 4, userId);
            fillReProd(rptWedding, 4, userId);
            fillReProd(rptHoliday, 4, userId);
        }

        void fillReProd(Repeater repeater, int count, int userId)
        {
            DataTable dt = new DataTable();
            string query = "select top " + count + " p.product_id, p.product_name, p.description, p.price, p.old_price, p.stock_quantity, " +
                "p.image_url, p.badge, p.rating_count, case when w.user_id is not null then 1 else 0 end as isinwishlist from Products p left join " +
                "Wishlist w on p.product_id = w.product_id and w.user_id = " + userId + " where p.stock_quantity > 0 order by p.product_id desc";

            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            sda.Fill(dt);

            repeater.DataSource = dt;
            repeater.DataBind();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }
            int userId = Convert.ToInt32(Session["UserID"]);
            LinkButton btn = (LinkButton)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);
            addToCart(userId, productId);
        }

        protected void btnAddToWishlist_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }
            int userId = Convert.ToInt32(Session["UserID"]);
            LinkButton btn = (LinkButton)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            toggleWishlist(userId, productId);

            productRepeaters();
        }

        void addToCart(int userId, int productId)
        {
            cmd = new SqlCommand("select stock_quantity from Products where product_id = " + productId, con);
            int stock = (int)cmd.ExecuteScalar();
            if (stock <= 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Sorry, this product is out of stock!');", true);
                return;
            }

            cmd = new SqlCommand("select 1 from Cart where user_id = " + userId + " and product_id = " + productId, con);
            if (cmd.ExecuteScalar() != null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('This product is already in your cart.');", true);
            }
            else
            {
                cmd = new SqlCommand("insert into Cart (user_id, product_id, quantity) values (" + userId + ", " + productId + ", 1)", con);
                cmd.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product added to cart!');", true);
            }

        }

        void toggleWishlist(int userId, int productId)
        {
            cmd = new SqlCommand("select 1 from Wishlist where user_id = " + userId + " and product_id = " + productId, con);

            if (cmd.ExecuteScalar() != null)
            {
                cmd = new SqlCommand("delete from Wishlist where user_id = " + userId + " and product_id = " + productId, con);
                cmd.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product removed from wishlist.');", true);
            }
            else
            {
                cmd = new SqlCommand("insert into Wishlist (user_id, product_id) values (" + userId + ", " + productId + ")", con);
                cmd.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product added to wishlist!');", true);
            }
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}