using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore.admin_panel
{
    public partial class add_edit_product1 : System.Web.UI.Page
    {
        string con_str = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string img_file_name;
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
        }
        void getcon()
        {
            con = new SqlConnection(con_str);
            con.Open();
        }

        void img_upload()
        {
            if (fileUploadImage.HasFile)
            {
                img_file_name = "img/product_img/" + fileUploadImage.FileName;

                fileUploadImage.SaveAs(Server.MapPath("~/" + img_file_name));
            }
            else
            {
                img_file_name = hdnExistingImage.Value;
            }
        }

        void clear()
        {
            txtProductName.Text = "";
            txtDescription.Text = "";
            txtPrice.Text = "";
            txtOldPrice.Text = "";
            txtStock.Text = "";
            ddlBadge.SelectedIndex = 0;
            ddlCategories.SelectedIndex = 0;
        }
        void fillCategory()
        {
            getcon();
            da = new SqlDataAdapter("select * from categories", con);
            ds = new DataSet();
            da.Fill(ds);

            ddlCategories.Items.Clear();
            ddlCategories.Items.Add("-- select category --");

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                ddlCategories.Items.Add(ds.Tables[0].Rows[i][1].ToString());
            }
        }

        
    }
}