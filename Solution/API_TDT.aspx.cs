using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class API_TDT : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //DATOS ENVIADOS POR WEB EXTERNA
        string terreno = HttpUtility.UrlDecode(HttpContext.Current.Request.QueryString["condicionesDeTerreno"]);
        string ganancia = HttpUtility.UrlDecode(HttpContext.Current.Request.QueryString["gananciaDeAntena"]);
        string factorPotencia = HttpUtility.UrlDecode(HttpContext.Current.Request.QueryString["factoresDePotencia"]);
        string altura = HttpUtility.UrlDecode(HttpContext.Current.Request.QueryString["altura"]);
        string id = HttpUtility.UrlDecode(HttpContext.Current.Request.QueryString["id"]);
        string consultId = HttpUtility.UrlDecode(HttpContext.Current.Request.QueryString["consultarId"]);

        if (!string.IsNullOrEmpty(consultId) && consultId != "all")
        {
            IList<Device> DevicesList = new List<Device>();
            DevicesList = ConsultDeviceById(consultId);
            if (DevicesList.Count > 0)
            {
                foreach (Device device in DevicesList)
                {
                    Label myLabel = this.FindControl("responseLabel") as Label;
                    myLabel.Text = "Id=" + device.Id + "; Nombre=" + device.Name + "; Descripción=" + device.Description + ";  Latitud=" + device.Latitude + "; Longitud=" + device.Longitude + "; Canal=" + device.Chanel + "; Modelo= " + device.Model + "; Patron= " + device.Pattern;

                    Label myLabelInfo = this.FindControl("responseOtherInfo") as Label;
                    myLabelInfo.Text = "Condiciones del Terreno= " + device.GroundConditions + "; Ganancia= " + device.Gain + "; Factor de Potencia= " + device.PowerFactor + "; Altura= " + device.High;

                }

            }
            else
            {
                Label myLabel = this.FindControl("responseLabel") as Label;
                myLabel.Text = "No existe el dispositivo con Id " + consultId + "por favor crearlo en la pagina.";

            }
        }
        else if(consultId == "all")
        {
            IList<Device> DevicesList = new List<Device>();
            DevicesList = ConsultAllDevices();
            if (DevicesList.Count > 0)
            {
                foreach (Device device in DevicesList)
                {
                    Label myLabel = this.FindControl("responseLabel") as Label;
                    myLabel.Text = myLabel.Text + "<br> Id=" + device.Id + "; Nombre=" + device.Name + "; Descripción=" + device.Description + ";  Latitud=" + device.Latitude + "; Longitud=" + device.Longitude + "; Canal=" + device.Chanel + "; Modelo= " + device.Model + "; Patron= " + device.Pattern +"Condiciones del Terreno= " + device.GroundConditions + "; Ganancia= " + device.Gain + "; Factor de Potencia= " + device.PowerFactor + "; Altura= " + device.High; 
                 
                }

            }
            else
            {
                Label myLabel = this.FindControl("responseLabel") as Label;
                myLabel.Text = "No existe el dispositivo con Id " + consultId + "por favor crearlo en la pagina.";

            }


        }

        if (!string.IsNullOrEmpty(id) && !string.IsNullOrEmpty(terreno) && !string.IsNullOrEmpty(ganancia) && !string.IsNullOrEmpty(factorPotencia) && !string.IsNullOrEmpty(altura))
        {
            bool idExist = VerifyId(id);
            if (idExist)
            {
                bool updateSuccesfull = UpdateId(id, terreno, ganancia, factorPotencia, altura);
                if (updateSuccesfull)
                {
                    Label myLabel = this.FindControl("responseLabel") as Label;
                    myLabel.Text = "DISPOSITIVO ACTUALIZADO CON EXITO!";

                }
                else
                {
                    Label myLabel = this.FindControl("responseLabel") as Label;
                    myLabel.Text = "ERROR NO FUE POSIBLE ACTUALIZAR EL DISPOSITIVO!";
                }


            }
            else
            {

                Label myLabel = this.FindControl("responseLabel") as Label;
                myLabel.Text = "ERROR DISPOSITIVO NO EXISTE POR FAVOR CREARLO ANTES DE ACTUALIZARLO!";

            }

        }
      
        
    
    }

    private IList<Device> ConsultAllDevices()
    {
        try
        {
            IList<Device> DevicesList = new List<Device>();
            var strDeviceList = string.Empty;
            DevicesList = DeviceController.GetDevice();

            return DevicesList;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private bool UpdateId(string id, string groundConditions , string gain , string powerFactor , string high)
    {
        try
        {

            bool updateSuccess = DeviceController.UpdateDeviceWithURL(id, groundConditions, gain, powerFactor, high);
            return updateSuccess;
          

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private IList<Device> ConsultDeviceById(string id)
    {
        try
        {
            IList<Device> DevicesList = new List<Device>();
            var strDeviceList = string.Empty;
            DevicesList = DeviceController.GetDeviceById(id);
            
           return DevicesList;       
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private bool VerifyId(string id)
    {
        try
        {
            IList<Device> DevicesList = new List<Device>();
            var strDeviceList = string.Empty;
            DevicesList = DeviceController.GetDeviceById(id);
            if (DevicesList.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
                        
        }
        catch(Exception ex)
        {

            throw ex;
        }
      
    }
}