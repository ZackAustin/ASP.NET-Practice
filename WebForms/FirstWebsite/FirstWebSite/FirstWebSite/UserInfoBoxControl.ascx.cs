using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FirstWebSite
{
    public partial class UserInfoBoxControl : System.Web.UI.UserControl
    {
        private string userName;
        private int userAge;
        private string userCountry;

        public string UserName { get; set; }
        public int UserAge { get; set; }
        public string UserCountry { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}