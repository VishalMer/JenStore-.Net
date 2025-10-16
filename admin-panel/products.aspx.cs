using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore.admin_panel
{
    public partial class products1 : System.Web.UI.Page
    {
        string con_str = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        PagedDataSource pg;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();

            if (Session["UserID"] == null)
            {
                Response.Redirect("../login_register.aspx");
            }

            if (!IsPostBack)
            {
                ViewState["Id"] = 0;
                getcon();
                fillGVProducts();
            }
        }

        void getcon()
        {
                con = new SqlConnection(con_str);
                con.Open();
            
        }

         void fillGVProducts()
        {
            string query = "select p.product_id, p.product_name, p.description, p.price, p.old_price, p.image_url, p.stock_quantity, stuff((select top 2 ', ' + c.category_name from categories c inner join product_categories pc on c.category_id = pc.category_id where pc.product_id = p.product_id order by c.category_name for xml path('')), 1, 2, '') as category_names from products p order by p.product_id desc";
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataSet ds = new DataSet();
            da.Fill(ds);

            PagedDataSource pg = new PagedDataSource();
            pg.DataSource = ds.Tables[0].DefaultView;
            pg.AllowPaging = true;
            pg.PageSize = 5;
            pg.CurrentPageIndex = Convert.ToInt32(ViewState["Id"]);

            lnkPrev.Enabled = !pg.IsFirstPage;
            lnkNext.Enabled = !pg.IsLastPage;

            var pages = new List<ListItem>();
            for (int i = 0; i < pg.PageCount; i++)
            {
                pages.Add(new ListItem((i + 1).ToString(), i.ToString(), i == pg.CurrentPageIndex));
            }
            rptPager.DataSource = pages;
            rptPager.DataBind();

            gvProducts.DataSource = pg;
            gvProducts.DataBind();
        }

        protected void lnkPrev_Click(object sender, EventArgs e)
        {
            int currentPage = Convert.ToInt32(ViewState["Id"]);
            if (currentPage > 0)
            {
                currentPage--;
                ViewState["Id"] = currentPage;
                fillGVProducts();
            }
        }

        protected void lnkNext_Click(object sender, EventArgs e)
        {
            int currentPage = Convert.ToInt32(ViewState["Id"]);
            currentPage++;
            ViewState["Id"] = currentPage;
            fillGVProducts();
        }

        protected void rptPager_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                ViewState["Id"] = Convert.ToInt32(e.CommandArgument);
                fillGVProducts();
            }
        }

        protected void gv_Command(object sender, GridViewCommandEventArgs e)
        {
            string productId = e.CommandArgument.ToString();

            if (e.CommandName == "EditProduct")
            {
                Response.Redirect("add-edit-product.aspx?id=" + productId);
            }
            else if (e.CommandName == "DeleteProduct")
            {
                SqlCommand cmd = new SqlCommand("delete from Products where product_id = " + productId, con);
                cmd.ExecuteNonQuery();
                fillGVProducts();
            }
        }

        public string GetStockStatus(object st)
        {
            if (st == DBNull.Value) return "stock-out-of-stock";

            int stock = Convert.ToInt32(st);
            if (stock <= 0)
            {
                return "stock-out-of-stock";
            }
            if (stock <= 10) 
            {
                return "stock-low";
            }
            return "stock-ok";
        }
    }
}