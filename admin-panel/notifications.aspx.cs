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
    public class NotificationTemplate
    {
        public string TemplateName { get; set; }
        public string PreviewText { get; set; }
        public string MessageType { get; set; }
        public string MessageBody { get; set; }
    }
    public partial class notifications1 : System.Web.UI.Page
    {
        string con_str = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        List<NotificationTemplate> templates = new List<NotificationTemplate>();

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
            // check for admin
            if (Session["UserID"] == null)
            {
                Response.Redirect("../login_register.aspx");
                return;
            }
            if (Session["UserRole"].ToString().ToLower() != "admin")
            {
                Response.Redirect("../home.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadStats();
                BindHistory();
                BindTemplates();
                BindRecipients();
            }
        }

        void getcon()
        {
            if (con == null || con.State == ConnectionState.Closed)
            {
                con = new SqlConnection(con_str);
                con.Open();
            }
        }

        void LoadStats()
        {
            cmd = new SqlCommand("select count(*) from notifications", con);
            lblTotalSent.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select count(*) from notifications where cast(created_date as date) = cast(getdate() as date)", con);
            lblTodaySent.Text = cmd.ExecuteScalar().ToString();

            lblPending.Text = "0";
            lblDeliveryRate.Text = "100%";
        }

        void BindHistory()
        {
            // load last 10 admin/general notifications sent
            string query = "select top 10 * from notifications where notification_type in ('announcement', 'offer', 'system') order by created_date desc";
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            rptHistory.DataSource = ds;
            rptHistory.DataBind();
        }

        void BindRecipients()
        {
            da = new SqlDataAdapter("select id, uname, email from users where role = 'customer' and is_active = 1 order by uname", con);
            ds = new DataSet();
            da.Fill(ds);

            cblRecipients.DataSource = ds;
            cblRecipients.DataTextField = "uname";
            cblRecipients.DataValueField = "id";
            cblRecipients.DataBind();
        }

        void BindTemplates()
        {
            templates.Add(new NotificationTemplate { TemplateName = "Welcome Message", MessageType = "announcement", PreviewText = "welcome to jenstore! thank you for joining...", MessageBody = "welcome to jenstore! thank you for joining us. explore our beautiful collection of fresh flowers and let us help you make every occasion special. we're excited to serve you!" });
            templates.Add(new NotificationTemplate { TemplateName = "Promotion Offer", MessageType = "offer", PreviewText = "special offer just for you! get 20% off...", MessageBody = "special offer just for you! get 20% off your next order with code save20. valid until the end of this month. don't miss out on this amazing deal!" });
            templates.Add(new NotificationTemplate { TemplateName = "Maintenance Notice", MessageType = "system", PreviewText = "we'll be performing scheduled maintenance...", MessageBody = "we'll be performing scheduled maintenance on our website on sunday from 2:00 am to 4:00 am est. during this time, some features may be temporarily unavailable." });

            rptTemplates.DataSource = templates;
            rptTemplates.DataBind();
        }

        protected void tab_Click(object sender, EventArgs e)
        {
            LinkButton clickedTab = (LinkButton)sender;

            // reset all
            pnlSend.CssClass = "tab-content";
            pnlTemplates.CssClass = "tab-content";
            pnlHistory.CssClass = "tab-content";
            tabSend.CssClass = "tab-button";
            tabTemplates.CssClass = "tab-button";
            tabHistory.CssClass = "tab-button";

            // set active
            if (clickedTab.CommandName == "Send")
            {
                pnlSend.CssClass = "tab-content active";
                tabSend.CssClass = "tab-button active";
            }
            else if (clickedTab.CommandName == "Templates")
            {
                pnlTemplates.CssClass = "tab-content active";
                tabTemplates.CssClass = "tab-button active";
            }
            else if (clickedTab.CommandName == "History")
            {
                pnlHistory.CssClass = "tab-content active";
                tabHistory.CssClass = "tab-button active";
            }
        }

        protected void ddlRecipientType_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlCustomRecipients.Visible = (ddlRecipientType.SelectedValue == "custom");
        }

        protected void rptTemplates_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "LoadTemplate")
            {
                // THIS IS THE FIX:
                // we must re-populate the templates list on postback
                // so the .find() method has data to search.
                BindTemplates();

                string templateName = e.CommandArgument.ToString();
                NotificationTemplate template = templates.Find(t => t.TemplateName == templateName);

                if (template != null)
                {
                    ddlNotificationType.SelectedValue = template.MessageType;
                    txtMessage.Text = template.MessageBody;
                }

                // switch to the 'send' tab
                tab_Click(tabSend, null);
            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            string message = txtMessage.Text.Replace("'", "''");
            string type = ddlNotificationType.SelectedValue;
            List<string> userIds = new List<string>();

            if (ddlRecipientType.SelectedValue == "all")
            {
                // get all customer ids
                da = new SqlDataAdapter("select id from users where role = 'customer' and is_active = 1", con);
                ds = new DataSet();
                da.Fill(ds);
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    userIds.Add(row["id"].ToString());
                }
            }
            else // custom
            {
                foreach (ListItem item in cblRecipients.Items)
                {
                    if (item.Selected)
                    {
                        userIds.Add(item.Value);
                    }
                }
            }

            // insert notifications in a loop
            foreach (string userId in userIds)
            {
                string query = "insert into notifications (user_id, message, notification_type) values (" + userId + ", '" + message + "', '" + type + "')";
                cmd = new SqlCommand(query, con);
                cmd.ExecuteNonQuery();
            }

            lblStatus.Text = "successfully sent notification to " + userIds.Count + " user(s).";
            lblStatus.CssClass = "alert alert-success";
            lblStatus.Visible = true;

            txtMessage.Text = "";
            cblRecipients.ClearSelection();

            LoadStats();
            BindHistory();
        }

        public string GetHistoryTitle(object message)
        {
            string msg = message.ToString();
            if (msg.Length > 30)
                return msg.Substring(0, 30) + "...";
            return msg;
        }
    }
}