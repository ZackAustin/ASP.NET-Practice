using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Net.Mail;
using System.Net;
using System.IO;
using System.Globalization;
using System.Threading;
using System.Data.Odbc;
using System.Configuration;

namespace FirstWebSite
{
    public partial class Default : System.Web.UI.Page
    {
        public static string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }
        public static string Base64Decode(string base64EncodedData)
        {
            var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
            return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            HelloWorldLabel.Text = "Hello, World";

            // Caching

            ArrayList datestamps;

            UserInfoBoxControl userInfoBoxControl = 
                (UserInfoBoxControl)LoadControl("~/UserInfoBoxControl.ascx");
            userInfoBoxControl.UserName = "John Doe";
            userInfoBoxControl.UserAge = 78;
            userInfoBoxControl.UserCountry = "Spain";
            phUserInfoBox.Controls.Add(userInfoBoxControl);

            if (Cache["datestamps"] == null)
            {
                datestamps = new ArrayList();
                datestamps.Add(DateTime.Now);
                datestamps.Add(DateTime.Now);
                datestamps.Add(DateTime.Now);

                Cache.Add("datestamps", datestamps, null,
                    System.Web.Caching.Cache.NoAbsoluteExpiration,
                    new TimeSpan(0, 0, 60),
                    System.Web.Caching.CacheItemPriority.Default, null);
            }
            else
                datestamps = (ArrayList)Cache["datestamps"];

            // To work with update panel postback.

            if(!IsPostBack)
            {
                foreach (DateTime dt in datestamps)
                    Response.Write(dt.ToString() + "<br />");
            }
            

            // State
            
            if (Session["BackgroundColor"] != null && !this.IsPostBack)
            {
                ColorSelector.SelectedValue = Session["BackgroundColor"].ToString();
                div_Sessions.Style["background-color"] = ColorSelector.SelectedValue;
            }
            
            if (ViewState["NameOfUser"] != null)
            {
                NameLabel.Text = ViewState["NameOfUser"].ToString();
            }
            else
            {
                NameLabel.Text = "Not set yet...";
            }

            // Localization

            var currentUICulture = Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName;

            if (currentUICulture.Equals("en", StringComparison.OrdinalIgnoreCase))
            {
                // Direct Access
                lblHelloWorldGlobal.Text = Resources.MyGlobalResources.HelloWorldLabel_Text;
            }
            else if (currentUICulture.Equals("de", StringComparison.OrdinalIgnoreCase))
            {
                // Local Resource Object
                lblHelloWorldGlobal.Text = GetLocalResourceObject("lblHelloWorld.Text").ToString();
            }
            else if (currentUICulture.Equals("es", StringComparison.OrdinalIgnoreCase))
            {
                // Global Resource Object
                lblHelloWorldGlobal.Text =
                    GetGlobalResourceObject("MyGlobalResources_es", "HelloWorldLabel.Text").ToString();
            }
            else // default to en
                lblHelloWorldGlobal.Text = Resources.MyGlobalResources.HelloWorldLabel_Text;

            // MySQL

            try
            {
                var connString = Base64Decode(ConfigurationManager.ConnectionStrings["MySQLConnStr"].ConnectionString);

                using (OdbcConnection connection =
                    new OdbcConnection(connString))
                {
                    connection.Open();
                    using (OdbcCommand command =
                        new OdbcCommand("SELECT id, name FROM test_users", connection))
                    using (OdbcDataReader dr = command.ExecuteReader())
                    {
                        ddlUsers.DataSource = dr;
                        ddlUsers.DataBind();
                        dr.Close();
                    }
                    connection.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write("An error occured:" + ex.Message);
            }
        }

        protected void GreetButton_Click(object sender, EventArgs e)
        {
            HelloWorldLabel.Text = "Hello, " + TextInput.Text;
        }

        protected void GreetList_SelectedIndexChanged(object sender, EventArgs e)
        {
            HelloWorldLabel.Text = "Hello, " + GreetList.SelectedValue;
        }
        protected void btnHelloWorld_Click(object sender, EventArgs e)
        {
            lblHelloAJAXWorld.Text = "Hello, world - this is a fresh message from "
                + "ASP.NET AJAX! The time right now is: "
                + DateTime.Now.ToLongTimeString();
        }

        protected void MyEventUserControl_PageTitleUpdated(object sender, EventArgs e)
        {
            this.Title = this.MyEventUserControl.PageTitle;
        }

        protected void btnSubmitForm_Click(object sender, EventArgs e)
        {
            if(Page.IsValid)
            {
                btnSubmitForm.Text = "My form is valid!";
            }
        }

        protected void lenCustom_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (args.Value.Length == 8)
                args.IsValid = true;
            else
                args.IsValid = false;
        }

        protected static string GetFreshDateTime(HttpContext context)
        {
            return DateTime.Now.ToString();
        }

        protected void ColorSelector_SelectedIndexChanged(object sender, EventArgs e)
        {
            div_Sessions.Style["background-color"] = ColorSelector.SelectedValue;
            Session["BackgroundColor"] = ColorSelector.SelectedValue;
        }

        protected void SubmitForm_Click(object sender, EventArgs e)
        {
            ViewState["NameOfUser"] = NameField.Text;
            NameLabel.Text = NameField.Text;
        }

        protected void MailButton_Click(object sender, EventArgs e)
        {
            try
            {
                /*
                var basicCredential =
                    //Lookup password. Do not commit.
                    new NetworkCredential("zack_austin@comcast.net", "");
                var mailMessage = new MailMessage();
                mailMessage.To.Add("zacksaustin@gmail.com");
                mailMessage.From = new MailAddress("zack_austin@comcast.net");
                mailMessage.Subject = "ASP.NET e-mail test";
                mailMessage.Body = "Hello world,\n\nThis is an ASP.NET test email!";

                var smtpClient = new SmtpClient("smtp.comcast.net");
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = basicCredential;
                smtpClient.Port = 587;
                smtpClient.Send(mailMessage);
                Response.Write("Email Sent.");
                */
            }
            catch (Exception ex)
            {
                Response.Write("Could not send the email - error"
                    + ex.Message);
            }
        }

        protected void UploadButton_Click(object sender, EventArgs e)
        {
            if (FileUploadControl.HasFile)
            {
                try
                {
                    if (FileUploadControl.PostedFile.ContentType == "image/jpeg")
                    {
                        if (FileUploadControl.PostedFile.ContentLength < 102400)
                        {
                            string filename = Path.GetFileName(FileUploadControl.FileName);
                            FileUploadControl.SaveAs(Server.MapPath("~/" + filename));
                            StatusLabel.Text = "Upload status: File uploaded.";
                        }
                        else
                            StatusLabel.Text = "Upload status: The file has to be less than 100 kb!";
                    }
                    else
                        StatusLabel.Text = "Upload status: Only JPEG files are accepted!";
                }
                catch (Exception ex)
                {
                    StatusLabel.Text = "Upload status: File could not be" +
                        "uploaded. The following error has occured: "
                        + ex.Message;
                }
            }
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            DateTimeLabel1.Text = DateTime.Now.ToString();
            DateTimeLabel2.Text = DateTime.Now.ToString();
        }
    }
}

