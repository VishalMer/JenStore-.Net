using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore.admin_panel
{
    public partial class add_edit_product1 : System.Web.UI.Page
    {
        string con_str = System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();

            if (Session["UserID"] == null)
            {
                Response.Redirect("../login_register.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    if (Request.QueryString["product_id"] != null)
                    {
                        int productId = Convert.ToInt32(Request.QueryString["product_id"]);
                        lblPageTitle.Text = "Edit Product";
                        lblPageSubtitle.Text = "Update the product information below";
                        hdnProductId.Value = Request.QueryString["id"];

                    }
                    else
                    {
                        lblPageTitle.Text = "Add Product";
                        lblPageSubtitle.Text = "Fill in the details below to create a new product";
                        hdnProductId.Value = "0";
                    }
                }

            }
            void getcon()
            {
                con = new SqlConnection(con_str);
                con.Open();
            }

            void bindCategories()
            {
                da = new SqlDataAdapter("select category_id, category_name from categories order by category_name", con);
                ds = new DataSet();
                da.Fill(ds);
                cblCategories.DataSource = ds;
                cblCategories.DataTextField = "category_name";
                cblCategories.DataValueField = "category_id";
                cblCategories.DataBind();
            }
        }
    }
}