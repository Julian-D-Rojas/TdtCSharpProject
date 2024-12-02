using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Serialization;

public partial class EditLocation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region Update Location
    [WebMethod(EnableSession = true)]
    public static object UpdateLocation(string id, string latitud, string longitud)
    {
        try
        {



            // Aqui deberia ir el codigo para determinar si en la zona el canal asigando esta siendo utilizado.


            ////
            bool response = false;
            response = DeviceController.UpdateLocation(id, latitud, longitud);

            if (response == true)
            {
                return new { res = "OK", Message = "Locación actualizada éxitosamente." };
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