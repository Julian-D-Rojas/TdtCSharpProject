using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Services;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Data;

using System.Configuration;
using System.Collections;
using System.Xml;

using System.IO;
using System.Web.Script.Services;
using System.Web.Script.Serialization;

using Newtonsoft.Json;

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HttpContext.Current.Session["DeviceName"] = "";
        }
    }


    #region Get Devices
    [WebMethod(EnableSession = true)]
    public static object GetDevices()
    {

        IList<Device> DevicesList = new List<Device>();
        var strDeviceList = string.Empty;
        DevicesList = DeviceController.GetDevice();

        var serializer = new JavaScriptSerializer();
        HttpContext.Current.Session["DeviceList"] = DevicesList;


        var devices = serializer.Serialize(HttpContext.Current.Session["DeviceList"]);
        return devices;

      
    }
    #endregion

    #region Get Device By Id
    [WebMethod(EnableSession = true)]
    public static object GetDeviceById(string id)
    {

        IList<Device> DevicesList = new List<Device>();
        var strDeviceList = string.Empty;
        DevicesList = DeviceController.GetDeviceById(id);
        var serializer = new JavaScriptSerializer();
        HttpContext.Current.Session["DeviceInFo"] = DevicesList;
        HttpContext.Current.Session["DeviceName"] = id;


        var device = serializer.Serialize(HttpContext.Current.Session["DeviceInFo"]);
        return device;
    }
    #endregion

    #region Insert Device By URL
    [WebMethod(EnableSession = true)]
    public static object InsertDevice(string id , string name , string descrption , string latitud , string longitud , string canales , string Antena , string terreno , string ganancia)
    {

        IList<Device> DevicesList = new List<Device>();
        var strDeviceList = string.Empty;
        DevicesList = DeviceController.GetDeviceById(id);
        var serializer = new JavaScriptSerializer();
        HttpContext.Current.Session["DeviceInFo"] = DevicesList;
        HttpContext.Current.Session["DeviceName"] = id;


        var device = serializer.Serialize(HttpContext.Current.Session["DeviceInFo"]);
        return device;
    }
    #endregion

   




}