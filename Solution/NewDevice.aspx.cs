using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Serialization;

public partial class NewDevice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HttpContext.Current.Session["DeviceName"] = "";
        }
    }
  
    #region Insert new device
    [WebMethod(EnableSession = true)]
    public static object InsertDevice(string name, string description, string channel, string model, string pattern, string longitude, string latitude)
    {
        try
        {
            bool response = false;

            if (name.Contains("ANTENA") || name.Contains("antena") || name.Contains("Antena"))
                channel = "NA";


            response = DeviceController.CreateDevice(name, description, channel,latitude, longitude ,model , pattern);

            if (response == true)
            {
                return new { res = "OK", Message = "Dispositivo actualizado éxitosamente." };
            }
            else
            {
                return new { res = "ERROR", Message = "No fue posible actualizar el dispositivo." };
            }

        }
        catch (Exception ex)
        {
            return new { res = "ERROR", Message = ex.Message };
        }

    }
    #endregion
        
    
}