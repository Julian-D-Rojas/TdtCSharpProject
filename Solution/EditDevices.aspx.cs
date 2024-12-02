using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Globalization;
using Newtonsoft.Json;

public partial class EditDevices : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    #region ConsultRange
    [WebMethod(EnableSession = true)]
    public static object ConsultRange(string latitud, string longitud, string method , string patternDrop)
    {
        try
        {

            IList<Device> deviceList = new List<Device>();
            IList<Device> InterferenceDevice = new List<Device>();
            IList<string> listChannelsAvailables = new List<string>();
  

            string anntenaName = string.Empty;
            //Get Devices List 
            deviceList = GetDevices();

            foreach (Device dev in deviceList)
            {
                string lat = dev.Latitude;
                string lng = dev.Longitude;

                    switch (method)
                    {

                       
                        case "1":
                            anntenaName = ValidationZoneModel1(lat, lng, latitud, longitud,dev.Name,dev.Pattern, patternDrop, dev.Gain, dev.PowerFactor, dev.High);

                            break;
                        case "2":
                            anntenaName = ValidationZoneModel2(lat, lng, latitud, longitud, dev.Name, dev.Pattern, patternDrop, dev.Gain, dev.PowerFactor, dev.High);

                            break;
                        case "3":
                            anntenaName = ValidationZoneModel3(lat, lng, latitud, longitud, dev.Name, dev.Pattern, patternDrop, dev.Gain, dev.PowerFactor, dev.High);
                            
                            
                            break;

                        default:
                            anntenaName = ValidationZoneWithoutModel(lat, lng, latitud, longitud);

                            break;

                    }

                    if (anntenaName == "dentro")
                    {
                        InterferenceDevice.Add(dev);
                        
                    }

                   
                  listChannelsAvailables =  ConsultAvailableChannels(listChannelsAvailables,InterferenceDevice);
                   
            }

              
                var serializer = new JavaScriptSerializer();
                HttpContext.Current.Session["InterferenceDevice"] = listChannelsAvailables;
                var devices = serializer.Serialize(HttpContext.Current.Session["InterferenceDevice"]);
                return devices;   


        }
        catch (Exception ex)
        {
            return new { res = "ERROR", Message = ex.Message };
        }

    }

    private static IList<string> ConsultAvailableChannels(IList<string> lastList ,IList<Device> InterferenceDevice)
    {
        IList<string> channels = new List<string>();
        channels = lastList;

        try
        {
            for (int n = 14; n < 52; n++)
            {
                if(!channels.Contains(n.ToString())) // Si no existe en la lista  agregar
                    channels.Add(n.ToString());

            }
            foreach (Device dev in InterferenceDevice)
            {

                if (dev.Name.Contains("ESTACION"))
                {
                    for (int i = 14; i < 22; i++)
                    {
                        if (channels.Contains(i.ToString())) // si no esta en la lista no remover 
                            channels.Remove(i.ToString());
                    }
                    for (int i = 27; i < 31; i++)
                    {
                        if (channels.Contains(i.ToString())) //si no esta en la lista no remover 
                            channels.Remove(i.ToString());
                    }

                    if (channels.Contains("37")) //si no esta en la lista no remover 
                        channels.Remove("37");

                    for (int i = 41; i < 48; i++)
                    {
                        if (channels.Contains(i.ToString())) //si no esta en la lista no remover 
                            channels.Remove(i.ToString());
                    }
                    if (channels.Contains("49")) //si no esta en la lista no remover 
                        channels.Remove("49");

                    if (channels.Contains("51")) //si no esta en la lista no remover 
                        channels.Remove("51");

                }
                else
                {
                    if (channels.Contains(dev.Chanel))
                        channels.Remove(dev.Chanel);

                }

            }

            return channels;



        }
        catch(Exception ex)
        {
            return channels;
        }
        
    }
    #endregion

    #region Get Devices

    public static IList<Device> GetDevices()
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
    #endregion

    #region Get Available Channels
    [WebMethod(EnableSession = true)]
    public static object GetAvailableChannels(string antena)
    {
        try
        {
            IList<string> channelList = new List<string>();
            var strDeviceList = string.Empty;
            channelList = DeviceController.GetAvailableChannels(antena);


            var serializer = new JavaScriptSerializer();
            HttpContext.Current.Session["ChannelList"] = channelList;

            var channels = serializer.Serialize(HttpContext.Current.Session["ChannelList"]);
            return channels;

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    #endregion

    #region Update by Name
    [WebMethod(EnableSession = true)]
    public static object UpdateDevice(string id, string name, string description, string channel, string model, string pattern, string latitude, string longitude)
    {
        try
        {
            bool response = false;

            if (name.Contains("ANTENA") || name.Contains("antena") || name.Contains("Antena"))
                channel = "NA";


            response = DeviceController.UpdateDevice(id, name, description, channel, latitude, longitude,model,pattern);

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

    #region  Validation Zone Model 1
      [WebMethod(EnableSession = true)]
    public static string ValidationZoneModel1(string latAnntena, string lngAnntena, string latDevice, string lngDevice , string fixedDevice , string patternDb , string patternDrop, string gain, string powerFactor, string high)
    {
        try
        {
            string LatAnntena = latAnntena.Replace(".", ",");
            string LngAnntena = lngAnntena.Replace(".", ",");
            string LatDevice = latDevice.Replace(".", ",");
            string LngDevice = lngDevice.Replace(".", ",");
            string Gain = gain.Replace(".", ",");
            string PowerFactor = powerFactor.Replace(".", ",");
            string High = high.Replace(".", ",");

            double AntsubE = Convert.ToDouble(LatAnntena);
            double AntsubN = Convert.ToDouble(LngAnntena);
            double PuntsubE = Convert.ToDouble(LatDevice);
            double PuntsubN = Convert.ToDouble(LngDevice);

            //double AntsubE = Convert.ToDouble(LatAnntena, CultureInfo.CreateSpecificCulture("es-ES"));
            //double AntsubN = Convert.ToDouble(LngAnntena, CultureInfo.CreateSpecificCulture("es-ES"));
            //double PuntsubE = Convert.ToDouble(LatDevice, CultureInfo.CreateSpecificCulture("es-ES"));
            //double PuntsubN = Convert.ToDouble(LngDevice, CultureInfo.CreateSpecificCulture("es-ES"));

            double AsubE = 0;
            double AsubN = 0;
            double PsubE = 0;
            double PsubN = 0;

            string[] coordenadasAnntena = ConvertGPSToUTM(AntsubE, AntsubN);
            string[] coordenadasDevice = ConvertGPSToUTM(PuntsubE, PuntsubN);

            if (coordenadasAnntena.Count() == 2)
            {
                foreach (string coord in coordenadasAnntena)
                {
                    if (AsubE == 0)
                    {
                        AsubE = Convert.ToDouble(coord);
                    }
                    else if (AsubN == 0)
                    {
                        AsubN = Convert.ToDouble(coord);
                    }
                }
            }

            if (coordenadasDevice.Count() == 2)
            {
                foreach (string coord in coordenadasDevice)
                {
                    if (PsubE == 0)
                    {
                        PsubE = Convert.ToDouble(coord);
                    }
                    else if (PsubN == 0)
                    {
                        PsubN = Convert.ToDouble(coord);
                    }
                }
            }

            //MODELO 1 OKUMURA HATA

            string dispFijo = fixedDevice;//Dispositivo a comparar 
            string patronDataB = patternDb;//Patron guardado en la BD
            string patronDropdown = patternDrop;

            double[] RA = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            double[] RB = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

            if (dispFijo == "ESTACION SUBA")
            {
                RA = new double[] { 14208, 14116, 13855, 13454, 12962, 12441, 11952, 11554, 11295, 11205, 11296, 11555, 11954, 12443, 12964, 13455, 13856, 14118, 14208, 14117, 13855, 13454, 12962, 12441, 11952, 11554, 11295, 11205, 11296, 11555, 11954, 12443, 12964, 13455, 13856, 14118, 14208, 14117, 13855, 13454, 12962, 12441, 11952, 11554, 11295, 11205, 11296, 11555, 11954, 12443, 12964, 13455, 13856, 14118, 14208, 14117, 13855, 13454, 12962, 12441, 11952, 11554, 11295, 11205, 11296, 11555, 11954, 12443, 12964, 13455, 13856, 14118, 14208 }; //Modelo 1 SUBA
            }
            else if (dispFijo == "ESTACION SANTA LIBRADA")
            {
                RA = new double[] { 14208, 14117, 13855, 13454, 12962, 12441, 11952, 11554, 11295, 11205, 11296, 11555, 11954, 12443, 12964, 13455, 13856, 14118, 14208, 14117, 13855, 13454, 12962, 12441, 11952, 11554, 11295, 11205, 11296, 11555, 11954, 12443, 12964, 13455, 13856, 14118, 14208, 14117, 13855, 13454, 12962, 12441, 11952, 11554, 11295, 11205, 11296, 11555, 11954, 12443, 12964, 13455, 13856, 14118, 14208, 14117, 13855, 13455, 12962, 12441, 11952, 11554, 11295, 11205, 11296, 11555, 11953, 12443, 12964, 13455, 13856, 14118, 14208 }; //depende del modelo y del patron de rad del dispositivo fijo
            }
            else
            {
                //Estos valores pueden cambiar segun el dispositivo ?

                if (patronDataB == "1")
                {
                    RA = new double[] { 1, 0.988876986, 0.956124372, 0.903545477, 0.83399558, 0.751167281, 0.659312559, 0.562925357, 0.466414596, 0.373800259, 0.288462966, 0.212969978, 0.148989113, 0.097289178, 0.057814075, 0.029810266, 0.011984724, 0.002672707, 0, 0.002030789, 0.006897836, 0.012914845, 0.018671195, 0.023106928, 0.025562491, 0.025794892, 0.023951897, 0.020499874, 0.016109123, 0.011511359, 0.007354108, 0.00408219, 0.001873848, 0.000647423, 0.000136138, 8.83289E-06, 3.75247E-33, 8.83289E-06, 0.000136138, 0.000647423, 0.001873848, 0.00408219, 0.007354108, 0.011511359, 0.016109123, 0.020499874, 0.023951897, 0.025794892, 0.025562491, 0.023106928, 0.018671195, 0.012914845, 0.006897836, 0.002030789, 0, 0.002672707, 0.011984724, 0.029810266, 0.057814075, 0.097289178, 0.148989113, 0.212969978, 0.288462966, 0.373800259, 0.466414596, 0.562925357, 0.659312559, 0.751167281, 0.83399558, 0.903545477, 0.956124372, 0.988876986, 1 };
                }
                else if (patronDataB == "2")
                {
                    RA = new double[] { 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.947001689, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841286599, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1 };

                }
                //
            }

            if (patronDropdown == "1")
            {
                RB = new double[] { 1, 0.988876986, 0.956124372, 0.903545477, 0.83399558, 0.751167281, 0.659312559, 0.562925357, 0.466414596, 0.373800259, 0.288462966, 0.212969978, 0.148989113, 0.097289178, 0.057814075, 0.029810266, 0.011984724, 0.002672707, 0, 0.002030789, 0.006897836, 0.012914845, 0.018671195, 0.023106928, 0.025562491, 0.025794892, 0.023951897, 0.020499874, 0.016109123, 0.011511359, 0.007354108, 0.00408219, 0.001873848, 0.000647423, 0.000136138, 8.83289E-06, 3.75247E-33, 8.83289E-06, 0.000136138, 0.000647423, 0.001873848, 0.00408219, 0.007354108, 0.011511359, 0.016109123, 0.020499874, 0.023951897, 0.025794892, 0.025562491, 0.023106928, 0.018671195, 0.012914845, 0.006897836, 0.002030789, 0, 0.002672707, 0.011984724, 0.029810266, 0.057814075, 0.097289178, 0.148989113, 0.212969978, 0.288462966, 0.373800259, 0.466414596, 0.562925357, 0.659312559, 0.751167281, 0.83399558, 0.903545477, 0.956124372, 0.988876986, 1 };
            }
            else if (patronDropdown == "2")
            {
                RB = new double[] { 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.947001689, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841286599, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1 };
            }


            double[] g = { 0, 0.087266463, 0.174532925, 0.261799388, 0.34906585, 0.436332313, 0.523598776, 0.610865238, 0.698131701, 0.785398163, 0.872664626, 0.959931089, 1.047197551, 1.134464014, 1.221730476, 1.308996939, 1.396263402, 1.483529864, 1.570796327, 1.658062789, 1.745329252, 1.832595715, 1.919862177, 2.00712864, 2.094395102, 2.181661565, 2.268928028, 2.35619449, 2.443460953, 2.530727415, 2.617993878, 2.705260341, 2.792526803, 2.879793266, 2.967059728, 3.054326191, 3.141592654, 3.228859116, 3.316125579, 3.403392041, 3.490658504, 3.577924967, 3.665191429, 3.752457892, 3.839724354, 3.926990817, 4.01425728, 4.101523742, 4.188790205, 4.276056667, 4.36332313, 4.450589593, 4.537856055, 4.625122518, 4.71238898, 4.799655443, 4.886921906, 4.974188368, 5.061454831, 5.148721293, 5.235987756, 5.323254219, 5.410520681, 5.497787144, 5.585053606, 5.672320069, 5.759586532, 5.846852994, 5.934119457, 6.021385919, 6.108652382, 6.195918845, 0 }; //grados a los que se evalua el RAn y RBn

            //inicio calculo amplitud de patron de radiacion
            

            double cons;
            double fc = 470; // 
            const double hr = 17.625;    //11.75*1.5 fijo
            double aHre; // factor de correcion de altura no cambia
            double hre; // no cambia
            double loH;
            double prxOH;
            double PotRX = -70;  //---- > sensibilidad wifi fija
            double grx = 5; //----> 5 fija
            double d;
            bool pot = false;
            double gtx=0;
            double hte = 0;
            double ptx = 0;



            if (Gain == "")
            {  gtx = 14; }//----> la da el mono dejar predet 3 
            else {  gtx = Convert.ToDouble(Gain, CultureInfo.CreateSpecificCulture("es-ES")); }

            if (High == "")
            { hte = 50; }// Altura Estacion  -----> la da el mono dejar predet 50
            else { hte = Convert.ToDouble(High, CultureInfo.CreateSpecificCulture("es-ES")); }

            if (PowerFactor == "")
            { ptx = 12.6; }//----> la da el mono dejar predet 12.6
            else { ptx = Convert.ToDouble(PowerFactor, CultureInfo.CreateSpecificCulture("es-ES")); }
            


            hre = Math.Log10(hr);
            aHre = (3.2 * Math.Pow(hre, 2)) - 4.97;


            for (d = 0; d <= 80 && !pot; d = d + 0.001)
            {
                loH = (69.55 + 26.16 * Math.Log10(fc) - 13.82 * Math.Log10(hte) - aHre + (44.9 - 6.55 * Math.Log10(hte)) * Math.Log10(d));
                prxOH = ptx + gtx + grx - loH;
                if (prxOH <= PotRX)
                {
                    pot = true;

                }

            }
             cons=d*1000;

            //fin calculo amplitud de patron de radiacion

            double sol_2 = 0;
            int k = 0;
            int kA = 0;

            double PcAsubE = AsubE;//punto central dispositivo fijo en coordenadas UTM
            double PcAsubN = AsubN;//punto central dispositivo fijo en coordenadasUTM

            double PcBsubE = PsubE;//punto central dispositivo a ajustar en coordenadas UTM
            double PcBsubN = PsubN;//punto central dispositivo a ajustar en coordenadas UTM

            double PAx1 = PcAsubE + (RA[0] * Cos(g[0]));
            double PAy1 = PcAsubN + (RA[0] * Sin(g[0]));

            if (dispFijo == "ESTACION SUBA" || dispFijo == "ESTACION SANTA LIBRADA")
            {
                 PAx1 = PcAsubE + (RA[0] * Cos(g[0]));
                 PAy1 = PcAsubN + (RA[0] * Sin(g[0]));
            }
            else
            {
                 PAx1 = PcAsubE + (RA[0] *cons* Cos(g[0]));
                 PAy1 = PcAsubN + (RA[0] *cons* Sin(g[0]));
            }

            double PBx1 = PcBsubE + (RB[0] * cons * Cos(g[0]));
            double PBy1 = PcBsubN + (RB[0] * cons * Sin(g[0]));

            double pasoB = 0.1;

            for (int n = 1; n < 73; n = n + 1)
            {
                double PAx2 = PcAsubE + RA[n] * Cos(g[n]);
                double PAy2 = PcAsubN + RA[n] * Sin(g[n]);

                if (dispFijo == "ESTACION SUBA" || dispFijo == "ESTACION SANTA LIBRADA")
            {
                     PAx2 = PcAsubE + RA[n] * Cos(g[n]);
                     PAy2 = PcAsubN + RA[n] * Sin(g[n]);
                }
            else
            {
                     PAx2 = PcAsubE + RA[n] *cons* Cos(g[n]);
                     PAy2 = PcAsubN + RA[n] *cons* Sin(g[n]);
                }
                

                if (PAx1 > PAx2) { kA = 0; }
                if (PAx1 < PAx2) { kA = 1; }

                for (int m = 1; m < 73; m = m + 1)
                {

                    double PBx2 = PcBsubE + RB[m] *cons* Cos(g[m]);
                    double PBy2 = PcBsubN + RB[m] *cons* Sin(g[m]);


                    if (PBx1 > PBx2 && pasoB > 0)
                    {
                        pasoB = -pasoB;

                    }
                    if (PBx1 < PBx2 && pasoB < 0)
                    {
                        pasoB = -pasoB;
                    }


                    if (pasoB < 0)
                    {
                        for (double xj = PBx1; xj >= PBx2; xj = xj + pasoB)
                        {
                            double cA = PAx2 - PAx1;
                            double cB = PBx2 - PBx1;

                            if (cA == 0)
                            { cA = 0.00001; }
                            if (cB == 0)
                            { cB = 0.00001; }

                            double sol_1 = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1) - (((xj - PBx1) * (PBy2 - PBy1) / (cB)) + PBy1);

                            if (sol_1 * sol_2 < 0)
                            {
                                if (xj >= PAx1 && xj <= PAx2 && kA == 1)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("dentro:id de dispoditivo A, " + "xj=" + xj + ", yj:" + yj);

                                    k = 1;
                                    return "dentro";

                                }
                                if (xj <= PAx1 && xj >= PAx2 && kA == 0)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);

                                    Console.WriteLine("dentro: id de dispoditivo A, " + "xj=" + xj + " yj:" + yj);
                                    k = 1;
                                    return "dentro";
                                }

                            }

                            sol_2 = sol_1;
                        }

                    }
                    if (pasoB > 0)
                    {
                        for (double xj = PBx1; xj <= PBx2; xj = xj + pasoB)
                        {
                            double cA = PAx2 - PAx1;
                            double cB = PBx2 - PBx1;

                            if (cA == 0)
                            { cA = 0.00001; }
                            if (cB == 0)
                            { cB = 0.00001; }

                            double sol_1 = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1) - (((xj - PBx1) * (PBy2 - PBy1) / (cB)) + PBy1);

                            if (sol_1 * sol_2 < 0)
                            {
                                if (xj >= PAx1 && xj <= PAx2 && kA == 1)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("dentro: id de dispoditivo A, " + "xj=" + xj + " yj:" + yj);
                                    k = 1;
                                    return "dentro";
                                }
                                if (xj <= PAx1 && xj >= PAx2 && kA == 0)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("dentro: id de dispoditivo A, " + "xj=" + xj + " yj:" + yj);
                                    k = 1;
                                    return "dentro";
                                }
                            }

                            sol_2 = sol_1;
                        }
                    }

                    PBx1 = PBx2;
                    PBy1 = PBy2;
                    if (k == 1)//cambiar k por 1 para salir al primer cruce
                    {
                        m = 6;
                    }
                }

                PAx1 = PAx2;
                PAy1 = PAy2;
                if (k == 1)//cambiar k por 1 para salir al primer cruce
                {
                    n = 6;
                }
            }

            if (k == 0)
            {
                PAx1 = PcAsubE + (RA[0] * Cos(g[0]));
                PAy1 = PcAsubN + (RA[0] * Sin(g[0]));

                PBy1 = PcBsubN + (RB[0] * Sin(g[0]));

                sol_2 = 0;
                int c = 0;

                for (int n = 1; n < 73; n = n + 1)
                {
                    double PAx2 = PcAsubE + RA[n] * Cos(g[n]);
                    double PAy2 = PcAsubN + RA[n] * Sin(g[n]);

                    if (PAx1 > PAx2 && pasoB > 0) { pasoB = -pasoB; kA = 0; }
                    if (PAx1 < PAx2 && pasoB < 0) { pasoB = -pasoB; kA = 1; }

                    if (pasoB < 0)
                    {
                        for (double xj = PAx1; xj >= PAx2; xj = xj + pasoB)
                        {
                            double cA = PAx2 - PAx1;


                            if (cA == 0)
                            { cA = 0.00001; }


                            double sol_1 = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1) - (xj - PcBsubE + PcBsubN);

                            if (sol_1 * sol_2 < 0)
                            {
                                if (xj >= PcBsubE)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("corte id de dispoditivo A recta, " + "xj=" + xj + ", yj:" + yj);
                                    c = c + 1;
                                }
                            }

                            sol_2 = sol_1;
                        }


                    }
                    if (pasoB > 0)
                    {
                        for (double xj = PAx1; xj <= PAx2; xj = xj + pasoB)
                        {
                            double cA = PAx2 - PAx1;


                            if (cA == 0)
                            { cA = 0.00001; }


                            double sol_1 = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1) - (xj - PcBsubE + PcBsubN);

                            if (sol_1 * sol_2 < 0)
                            {
                                if (xj >= PcBsubE)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("corte id de dispoditivo A RECTA, " + "xj=" + xj + " yj:" + yj);
                                    c = c + 1;
                                }

                            }

                            sol_2 = sol_1;
                        }
                    }

                    PAx1 = PAx2;
                    PAy1 = PAy2;
                }
                if (c % 2 == 0)
                {
                    //Console.WriteLine("fuera: id de dispoditivo A RECTA, " + "c= " + c);
                    //return "fuera";
                }
                else
                {
                    Console.WriteLine("dentro: id de dispoditivo A RECTA, " + "c= " + c);
                    return "dentro";
                }
            }

            return "fuera";



        }
        catch (Exception ex)
        {
            throw ex;
        }

        

    }

    #endregion

    #region  Validation Zone Model 2
    [WebMethod(EnableSession = true)]
    public static string ValidationZoneModel2(string latAnntena, string lngAnntena, string latDevice, string lngDevice, string fixedDevice, string patternDb, string patternDrop, string gain, string powerFactor, string high)
    {
        try
        {
            string LatAnntena = latAnntena.Replace(".", ",");
            string LngAnntena = lngAnntena.Replace(".", ",");
            string LatDevice = latDevice.Replace(".", ",");
            string LngDevice = lngDevice.Replace(".", ",");
            string Gain = gain.Replace(".", ",");
            string PowerFactor = powerFactor.Replace(".", ",");
            string High = high.Replace(".", ",");

            double AntsubE = Convert.ToDouble(LatAnntena);
            double AntsubN = Convert.ToDouble(LngAnntena);
            double PuntsubE = Convert.ToDouble(LatDevice);
            double PuntsubN = Convert.ToDouble(LngDevice);

            //double AntsubE = Convert.ToDouble(LatAnntena, CultureInfo.CreateSpecificCulture("es-ES"));
            //double AntsubN = Convert.ToDouble(LngAnntena, CultureInfo.CreateSpecificCulture("es-ES"));
            //double PuntsubE = Convert.ToDouble(LatDevice, CultureInfo.CreateSpecificCulture("es-ES"));
            //double PuntsubN = Convert.ToDouble(LngDevice, CultureInfo.CreateSpecificCulture("es-ES"));

            double AsubE = 0;
            double AsubN = 0;
            double PsubE = 0;
            double PsubN = 0;

            string[] coordenadasAnntena = ConvertGPSToUTM(AntsubE, AntsubN);
            string[] coordenadasDevice = ConvertGPSToUTM(PuntsubE, PuntsubN);

            if (coordenadasAnntena.Count() == 2)
            {
                foreach (string coord in coordenadasAnntena)
                {
                    if (AsubE == 0)
                    {
                        AsubE = Convert.ToDouble(coord);
                    }
                    else if (AsubN == 0)
                    {
                        AsubN = Convert.ToDouble(coord);
                    }
                }
            }

            if (coordenadasDevice.Count() == 2)
            {
                foreach (string coord in coordenadasDevice)
                {
                    if (PsubE == 0)
                    {
                        PsubE = Convert.ToDouble(coord);
                    }
                    else if (PsubN == 0)
                    {
                        PsubN = Convert.ToDouble(coord);
                    }
                }
            }

            //MODELO 2 W

            string dispFijo = fixedDevice;//Dispositivo a comparar 
            string patronDataB = patternDb;//Patron guardado en la BD
            string patronDropdown = patternDrop;

            double[] RA = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            double[] RB = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

            if (dispFijo == "ESTACION SUBA")
        {
            RA = new double[] { 9017, 8955, 8773, 8498, 8163, 7811, 7484, 7220, 7048, 9797, 9877, 10105, 10455, 10884, 11343, 11775, 12127, 12358, 12753, 12672, 12437, 12077, 11636, 11168, 10729, 10372, 10139, 7218, 7642, 7456, 8111, 8066, 8839, 8774, 9492, 9244, 9999, 9932, 9734, 9433, 8428, 8461, 8109, 7825, 7641, 7777, 7843, 8032, 8323, 8213, 8582, 8932, 8593, 8771, 9751, 9684, 8427, 8161, 7119, 7079, 6780, 6854, 6691, 6989, 7049, 7221, 7485, 8112, 8475, 8820, 9103, 9290, 9017 };
        }
        else if (dispFijo == "ESTACION SANTA LIBRADA")
        {
           RA = new double[] { 9474, 9409, 9220, 9728, 9352, 8955, 8586, 7592, 7412, 7350, 6762, 6927, 6519, 6808, 7454, 7763, 8018, 10101, 10168, 10494, 11092, 10760, 11341, 10883, 11722, 8832, 8628, 8558, 8582, 8786, 9100, 9487, 9068, 9434, 9735, 9932, 9999, 11387, 11167, 10832, 10423, 9990, 8586, 8287, 8093, 7350, 7544, 8786, 9100, 9487, 9901, 9434, 9735, 9568, 9999, 12056, 11828, 11479, 11053, 9485, 9098, 8785, 8581, 8511, 8614, 8818, 9133, 9121, 9523, 10329, 10651, 10863, 9474 };
        }
            else
            {
                //Estos valores pueden cambiar segun el dispositivo ?

                if (patronDataB == "1")
                {
                    RA = new double[] { 1, 0.988876986, 0.956124372, 0.903545477, 0.83399558, 0.751167281, 0.659312559, 0.562925357, 0.466414596, 0.373800259, 0.288462966, 0.212969978, 0.148989113, 0.097289178, 0.057814075, 0.029810266, 0.011984724, 0.002672707, 0, 0.002030789, 0.006897836, 0.012914845, 0.018671195, 0.023106928, 0.025562491, 0.025794892, 0.023951897, 0.020499874, 0.016109123, 0.011511359, 0.007354108, 0.00408219, 0.001873848, 0.000647423, 0.000136138, 8.83289E-06, 3.75247E-33, 8.83289E-06, 0.000136138, 0.000647423, 0.001873848, 0.00408219, 0.007354108, 0.011511359, 0.016109123, 0.020499874, 0.023951897, 0.025794892, 0.025562491, 0.023106928, 0.018671195, 0.012914845, 0.006897836, 0.002030789, 0, 0.002672707, 0.011984724, 0.029810266, 0.057814075, 0.097289178, 0.148989113, 0.212969978, 0.288462966, 0.373800259, 0.466414596, 0.562925357, 0.659312559, 0.751167281, 0.83399558, 0.903545477, 0.956124372, 0.988876986, 1 };
                }
                else if (patronDataB == "2")
                {
                    RA = new double[] { 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.947001689, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841286599, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1 };

                }
                //
            }

            if (patronDropdown == "1")
            {
                RB = new double[] { 1, 0.988876986, 0.956124372, 0.903545477, 0.83399558, 0.751167281, 0.659312559, 0.562925357, 0.466414596, 0.373800259, 0.288462966, 0.212969978, 0.148989113, 0.097289178, 0.057814075, 0.029810266, 0.011984724, 0.002672707, 0, 0.002030789, 0.006897836, 0.012914845, 0.018671195, 0.023106928, 0.025562491, 0.025794892, 0.023951897, 0.020499874, 0.016109123, 0.011511359, 0.007354108, 0.00408219, 0.001873848, 0.000647423, 0.000136138, 8.83289E-06, 3.75247E-33, 8.83289E-06, 0.000136138, 0.000647423, 0.001873848, 0.00408219, 0.007354108, 0.011511359, 0.016109123, 0.020499874, 0.023951897, 0.025794892, 0.025562491, 0.023106928, 0.018671195, 0.012914845, 0.006897836, 0.002030789, 0, 0.002672707, 0.011984724, 0.029810266, 0.057814075, 0.097289178, 0.148989113, 0.212969978, 0.288462966, 0.373800259, 0.466414596, 0.562925357, 0.659312559, 0.751167281, 0.83399558, 0.903545477, 0.956124372, 0.988876986, 1 };
            }
            else if (patronDropdown == "2")
            {
                RB = new double[] { 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.947001689, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841286599, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1 };
            }


            double[] g = { 0, 0.087266463, 0.174532925, 0.261799388, 0.34906585, 0.436332313, 0.523598776, 0.610865238, 0.698131701, 0.785398163, 0.872664626, 0.959931089, 1.047197551, 1.134464014, 1.221730476, 1.308996939, 1.396263402, 1.483529864, 1.570796327, 1.658062789, 1.745329252, 1.832595715, 1.919862177, 2.00712864, 2.094395102, 2.181661565, 2.268928028, 2.35619449, 2.443460953, 2.530727415, 2.617993878, 2.705260341, 2.792526803, 2.879793266, 2.967059728, 3.054326191, 3.141592654, 3.228859116, 3.316125579, 3.403392041, 3.490658504, 3.577924967, 3.665191429, 3.752457892, 3.839724354, 3.926990817, 4.01425728, 4.101523742, 4.188790205, 4.276056667, 4.36332313, 4.450589593, 4.537856055, 4.625122518, 4.71238898, 4.799655443, 4.886921906, 4.974188368, 5.061454831, 5.148721293, 5.235987756, 5.323254219, 5.410520681, 5.497787144, 5.585053606, 5.672320069, 5.759586532, 5.846852994, 5.934119457, 6.021385919, 6.108652382, 6.195918845, 0 }; //grados a los que se evalua el RAn y RBn

            //inicio calculo amplitud de patron de radiacion


            double cons;
            double fc = 470; // 
            const double hr = 17.625;    //11.75*1.5 fijo
            double aHre; // factor de correcion de altura no cambia
            double hre; // no cambia
            double loH;
            double prxOH;
            double PotRX = -70;  //---- > sensibilidad wifi fija
            double grx = 5; //----> 5 fija
            double d;
            bool pot = false;
            double gtx = 0;
            double hte = 0;
            double ptx = 0;



            if (Gain == "")
            { gtx = 14; }//----> la da el mono dejar predet 3 
            else { gtx = Convert.ToDouble(Gain, CultureInfo.CreateSpecificCulture("es-ES")); }

            if (High == "")
            { hte = 50; }// Altura Estacion  -----> la da el mono dejar predet 50
            else { hte = Convert.ToDouble(High, CultureInfo.CreateSpecificCulture("es-ES")); }

            if (PowerFactor == "")
            { ptx = 12.6; }//----> la da el mono dejar predet 12.6
            else { ptx = Convert.ToDouble(PowerFactor, CultureInfo.CreateSpecificCulture("es-ES")); }



            hre = Math.Log10(hr);
            aHre = (3.2 * Math.Pow(hre, 2)) - 4.97;


            for (d = 0; d <= 80 && !pot; d = d + 0.001)
            {
                loH = (69.55 + 26.16 * Math.Log10(fc) - 13.82 * Math.Log10(hte) - aHre + (44.9 - 6.55 * Math.Log10(hte)) * Math.Log10(d));
                prxOH = ptx + gtx + grx - loH;
                if (prxOH <= PotRX)
                {
                    pot = true;

                }

            }
            cons = d * 1000;

            //fin calculo amplitud de patron de radiacion

            double sol_2 = 0;
            int k = 0;
            int kA = 0;

            double PcAsubE = AsubE;//punto central dispositivo fijo en coordenadas UTM
            double PcAsubN = AsubN;//punto central dispositivo fijo en coordenadasUTM

            double PcBsubE = PsubE;//punto central dispositivo a ajustar en coordenadas UTM
            double PcBsubN = PsubN;//punto central dispositivo a ajustar en coordenadas UTM

            double PAx1 = PcAsubE + (RA[0] * Cos(g[0]));
            double PAy1 = PcAsubN + (RA[0] * Sin(g[0]));

            if (dispFijo == "ESTACION SUBA" || dispFijo == "ESTACION SANTA LIBRADA")
            {
                PAx1 = PcAsubE + (RA[0] * Cos(g[0]));
                PAy1 = PcAsubN + (RA[0] * Sin(g[0]));
            }
            else
            {
                PAx1 = PcAsubE + (RA[0] * cons * Cos(g[0]));
                PAy1 = PcAsubN + (RA[0] * cons * Sin(g[0]));
            }

            double PBx1 = PcBsubE + (RB[0] * cons * Cos(g[0]));
            double PBy1 = PcBsubN + (RB[0] * cons * Sin(g[0]));


            double pasoB = 0.1;

            for (int n = 1; n < 73; n = n + 1)
            {
                double PAx2 = PcAsubE + RA[n] * Cos(g[n]);
                double PAy2 = PcAsubN + RA[n] * Sin(g[n]);

                if (dispFijo == "ESTACION SUBA" || dispFijo == "ESTACION SANTA LIBRADA")
                {
                    PAx2 = PcAsubE + RA[n] * Cos(g[n]);
                    PAy2 = PcAsubN + RA[n] * Sin(g[n]);
                }
                else
                {
                    PAx2 = PcAsubE + RA[n] * cons * Cos(g[n]);
                    PAy2 = PcAsubN + RA[n] * cons * Sin(g[n]);
                }

                if (PAx1 > PAx2) { kA = 0; }
                if (PAx1 < PAx2) { kA = 1; }

                for (int m = 1; m < 73; m = m + 1)
                {

                    double PBx2 = PcBsubE + RB[m] *cons* Cos(g[m]);
                    double PBy2 = PcBsubN + RB[m] *cons* Sin(g[m]);


                    if (PBx1 > PBx2 && pasoB > 0)
                    {
                        pasoB = -pasoB;

                    }
                    if (PBx1 < PBx2 && pasoB < 0)
                    {
                        pasoB = -pasoB;
                    }


                    if (pasoB < 0)
                    {
                        for (double xj = PBx1; xj >= PBx2; xj = xj + pasoB)
                        {
                            double cA = PAx2 - PAx1;
                            double cB = PBx2 - PBx1;

                            if (cA == 0)
                            { cA = 0.00001; }
                            if (cB == 0)
                            { cB = 0.00001; }

                            double sol_1 = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1) - (((xj - PBx1) * (PBy2 - PBy1) / (cB)) + PBy1);

                            if (sol_1 * sol_2 < 0)
                            {
                                if (xj >= PAx1 && xj <= PAx2 && kA == 1)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("dentro:id de dispoditivo A, " + "xj=" + xj + ", yj:" + yj);

                                    k = 1;
                                    return "dentro";

                                }
                                if (xj <= PAx1 && xj >= PAx2 && kA == 0)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);

                                    Console.WriteLine("dentro: id de dispoditivo A, " + "xj=" + xj + " yj:" + yj);
                                    k = 1;
                                    return "dentro";
                                }

                            }

                            sol_2 = sol_1;
                        }

                    }
                    if (pasoB > 0)
                    {
                        for (double xj = PBx1; xj <= PBx2; xj = xj + pasoB)
                        {
                            double cA = PAx2 - PAx1;
                            double cB = PBx2 - PBx1;

                            if (cA == 0)
                            { cA = 0.00001; }
                            if (cB == 0)
                            { cB = 0.00001; }

                            double sol_1 = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1) - (((xj - PBx1) * (PBy2 - PBy1) / (cB)) + PBy1);

                            if (sol_1 * sol_2 < 0)
                            {
                                if (xj >= PAx1 && xj <= PAx2 && kA == 1)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("dentro: id de dispoditivo A, " + "xj=" + xj + " yj:" + yj);
                                    k = 1;
                                    return "dentro";
                                }
                                if (xj <= PAx1 && xj >= PAx2 && kA == 0)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("dentro: id de dispoditivo A, " + "xj=" + xj + " yj:" + yj);
                                    k = 1;
                                    return "dentro";
                                }
                            }

                            sol_2 = sol_1;
                        }
                    }

                    PBx1 = PBx2;
                    PBy1 = PBy2;
                    if (k == 1)//cambiar k por 1 para salir al primer cruce
                    {
                        m = 6;
                    }
                }

                PAx1 = PAx2;
                PAy1 = PAy2;
                if (k == 1)//cambiar k por 1 para salir al primer cruce
                {
                    n = 6;
                }
            }

            if (k == 0)
            {
                PAx1 = PcAsubE + (RA[0] * Cos(g[0]));
                PAy1 = PcAsubN + (RA[0] * Sin(g[0]));

                PBy1 = PcBsubN + (RB[0] * Sin(g[0]));

                sol_2 = 0;
                int c = 0;

                for (int n = 1; n < 73; n = n + 1)
                {
                    double PAx2 = PcAsubE + RA[n] * Cos(g[n]);
                    double PAy2 = PcAsubN + RA[n] * Sin(g[n]);

                    if (PAx1 > PAx2 && pasoB > 0) { pasoB = -pasoB; kA = 0; }
                    if (PAx1 < PAx2 && pasoB < 0) { pasoB = -pasoB; kA = 1; }

                    if (pasoB < 0)
                    {
                        for (double xj = PAx1; xj >= PAx2; xj = xj + pasoB)
                        {
                            double cA = PAx2 - PAx1;


                            if (cA == 0)
                            { cA = 0.00001; }


                            double sol_1 = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1) - (xj - PcBsubE + PcBsubN);

                            if (sol_1 * sol_2 < 0)
                            {
                                if (xj >= PcBsubE)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("corte id de dispoditivo A recta, " + "xj=" + xj + ", yj:" + yj);
                                    c = c + 1;
                                }
                            }

                            sol_2 = sol_1;
                        }


                    }
                    if (pasoB > 0)
                    {
                        for (double xj = PAx1; xj <= PAx2; xj = xj + pasoB)
                        {
                            double cA = PAx2 - PAx1;


                            if (cA == 0)
                            { cA = 0.00001; }


                            double sol_1 = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1) - (xj - PcBsubE + PcBsubN);

                            if (sol_1 * sol_2 < 0)
                            {
                                if (xj >= PcBsubE)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("corte id de dispoditivo A RECTA, " + "xj=" + xj + " yj:" + yj);
                                    c = c + 1;
                                }

                            }

                            sol_2 = sol_1;
                        }
                    }

                    PAx1 = PAx2;
                    PAy1 = PAy2;
                }
                if (c % 2 == 0)
                {
                    //Console.WriteLine("fuera: id de dispoditivo A RECTA, " + "c= " + c);
                    //return "fuera";
                }
                else
                {
                    Console.WriteLine("dentro: id de dispoditivo A RECTA, " + "c= " + c);
                    return "dentro";
                }
            }

            return "fuera";



        }
        catch (Exception ex)
        {
            throw ex;
        }



    }

    #endregion

    #region  Validation Zone Model 3
    [WebMethod(EnableSession = true)]
    public static string ValidationZoneModel3(string latAnntena, string lngAnntena, string latDevice, string lngDevice, string fixedDevice, string patternDb, string patternDrop, string gain, string powerFactor, string high)
    {
        try
        {
            string LatAnntena = latAnntena.Replace(".", ",");
            string LngAnntena = lngAnntena.Replace(".", ",");
            string LatDevice = latDevice.Replace(".", ",");
            string LngDevice = lngDevice.Replace(".", ",");
            string Gain = gain.Replace(".", ",");
            string PowerFactor = powerFactor.Replace(".", ",");
            string High = high.Replace(".", ",");

            double AntsubE = Convert.ToDouble(LatAnntena);
            double AntsubN = Convert.ToDouble(LngAnntena);
            double PuntsubE = Convert.ToDouble(LatDevice);
            double PuntsubN = Convert.ToDouble(LngDevice);

            //double AntsubE = Convert.ToDouble(LatAnntena, CultureInfo.CreateSpecificCulture("es-ES"));
            //double AntsubN = Convert.ToDouble(LngAnntena, CultureInfo.CreateSpecificCulture("es-ES"));
            //double PuntsubE = Convert.ToDouble(LatDevice, CultureInfo.CreateSpecificCulture("es-ES"));
            //double PuntsubN = Convert.ToDouble(LngDevice, CultureInfo.CreateSpecificCulture("es-ES"));

            double AsubE = 0;
            double AsubN = 0;
            double PsubE = 0;
            double PsubN = 0;

            string[] coordenadasAnntena = ConvertGPSToUTM(AntsubE, AntsubN);
            string[] coordenadasDevice = ConvertGPSToUTM(PuntsubE, PuntsubN);

            if (coordenadasAnntena.Count() == 2)
            {
                foreach (string coord in coordenadasAnntena)
                {
                    if (AsubE == 0)
                    {
                        AsubE = Convert.ToDouble(coord);
                    }
                    else if (AsubN == 0)
                    {
                        AsubN = Convert.ToDouble(coord);
                    }
                }
            }

            if (coordenadasDevice.Count() == 2)
            {
                foreach (string coord in coordenadasDevice)
                {
                    if (PsubE == 0)
                    {
                        PsubE = Convert.ToDouble(coord);
                    }
                    else if (PsubN == 0)
                    {
                        PsubN = Convert.ToDouble(coord);
                    }
                }
            }

            //MODELO 3 CW

            string dispFijo = fixedDevice;//Dispositivo a comparar 
            string patronDataB = patternDb;//Patron guardado en la BD
            string patronDropdown = patternDrop;

            double[] RA = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            double[] RB = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

            if (dispFijo == "ESTACION SUBA")
        {
            RA = new double[] { 12172, 12093, 11869, 11525, 11104, 10657, 10238, 9898, 9676, 13707, 13817, 14135, 14622, 15221, 15859, 16459, 16950, 17267, 18095, 17979, 17645, 17134, 16508, 15844, 15221, 14715, 14384, 10193, 10605, 10511, 11223, 11319, 12172, 12240, 13009, 12842, 14833, 14737, 14463, 14044, 12279, 12164, 11686, 11297, 11044, 11232, 11323, 11583, 11983, 12026, 12530, 13004, 12152, 12382, 14389, 14297, 11955, 11609, 9812, 9684, 9303, 9575, 9360, 9599, 9676, 9899, 10240, 10928, 11385, 11818, 12170, 12399, 12172 };
        }
        else if (dispFijo == "ESTACION SANTA LIBRADA")
        {
            RA = new double[] { 13089, 13005, 12763, 13899, 13391, 12853, 12347, 10644, 10405, 10322, 9747, 9970, 9049, 9419, 10448, 10844, 11167, 14702, 14796, 13973, 15112, 14675, 15856, 15218, 16836, 12292, 12016, 11921, 12103, 12382, 12808, 13333, 12387, 12856, 13239, 13489, 13576, 18350, 18008, 17487, 16849, 16171, 13491, 13041, 12749, 11278, 10767, 12990, 13438, 13988, 14574, 13488, 13890, 13457, 14243, 19032, 18678, 18137, 17475, 14565, 13992, 12380, 12103, 12007, 11765, 12036, 12451, 12271, 12785, 14704, 15142, 14705, 13089 };
        }
            else
            {
                //Estos valores pueden cambiar segun el dispositivo ?

                if (patronDataB == "1")
                {
                    RA = new double[] { 1, 0.988876986, 0.956124372, 0.903545477, 0.83399558, 0.751167281, 0.659312559, 0.562925357, 0.466414596, 0.373800259, 0.288462966, 0.212969978, 0.148989113, 0.097289178, 0.057814075, 0.029810266, 0.011984724, 0.002672707, 0, 0.002030789, 0.006897836, 0.012914845, 0.018671195, 0.023106928, 0.025562491, 0.025794892, 0.023951897, 0.020499874, 0.016109123, 0.011511359, 0.007354108, 0.00408219, 0.001873848, 0.000647423, 0.000136138, 8.83289E-06, 3.75247E-33, 8.83289E-06, 0.000136138, 0.000647423, 0.001873848, 0.00408219, 0.007354108, 0.011511359, 0.016109123, 0.020499874, 0.023951897, 0.025794892, 0.025562491, 0.023106928, 0.018671195, 0.012914845, 0.006897836, 0.002030789, 0, 0.002672707, 0.011984724, 0.029810266, 0.057814075, 0.097289178, 0.148989113, 0.212969978, 0.288462966, 0.373800259, 0.466414596, 0.562925357, 0.659312559, 0.751167281, 0.83399558, 0.903545477, 0.956124372, 0.988876986, 1 };
                }
                else if (patronDataB == "2")
                {
                    RA = new double[] { 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.947001689, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841286599, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1 };

                }
                //
            }

            if (patronDropdown == "1")
            {
                RB = new double[] { 1, 0.988876986, 0.956124372, 0.903545477, 0.83399558, 0.751167281, 0.659312559, 0.562925357, 0.466414596, 0.373800259, 0.288462966, 0.212969978, 0.148989113, 0.097289178, 0.057814075, 0.029810266, 0.011984724, 0.002672707, 0, 0.002030789, 0.006897836, 0.012914845, 0.018671195, 0.023106928, 0.025562491, 0.025794892, 0.023951897, 0.020499874, 0.016109123, 0.011511359, 0.007354108, 0.00408219, 0.001873848, 0.000647423, 0.000136138, 8.83289E-06, 3.75247E-33, 8.83289E-06, 0.000136138, 0.000647423, 0.001873848, 0.00408219, 0.007354108, 0.011511359, 0.016109123, 0.020499874, 0.023951897, 0.025794892, 0.025562491, 0.023106928, 0.018671195, 0.012914845, 0.006897836, 0.002030789, 0, 0.002672707, 0.011984724, 0.029810266, 0.057814075, 0.097289178, 0.148989113, 0.212969978, 0.288462966, 0.373800259, 0.466414596, 0.562925357, 0.659312559, 0.751167281, 0.83399558, 0.903545477, 0.956124372, 0.988876986, 1 };
            }
            else if (patronDropdown == "2")
            {
                RB = new double[] { 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.947001689, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841286599, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1 };
            }


            double[] g = { 0, 0.087266463, 0.174532925, 0.261799388, 0.34906585, 0.436332313, 0.523598776, 0.610865238, 0.698131701, 0.785398163, 0.872664626, 0.959931089, 1.047197551, 1.134464014, 1.221730476, 1.308996939, 1.396263402, 1.483529864, 1.570796327, 1.658062789, 1.745329252, 1.832595715, 1.919862177, 2.00712864, 2.094395102, 2.181661565, 2.268928028, 2.35619449, 2.443460953, 2.530727415, 2.617993878, 2.705260341, 2.792526803, 2.879793266, 2.967059728, 3.054326191, 3.141592654, 3.228859116, 3.316125579, 3.403392041, 3.490658504, 3.577924967, 3.665191429, 3.752457892, 3.839724354, 3.926990817, 4.01425728, 4.101523742, 4.188790205, 4.276056667, 4.36332313, 4.450589593, 4.537856055, 4.625122518, 4.71238898, 4.799655443, 4.886921906, 4.974188368, 5.061454831, 5.148721293, 5.235987756, 5.323254219, 5.410520681, 5.497787144, 5.585053606, 5.672320069, 5.759586532, 5.846852994, 5.934119457, 6.021385919, 6.108652382, 6.195918845, 0 }; //grados a los que se evalua el RAn y RBn

            //inicio calculo amplitud de patron de radiacion


            double cons;
            double fc = 470; // 
            const double hr = 17.625;    //11.75*1.5 fijo
            double aHre; // factor de correcion de altura no cambia
            double hre; // no cambia
            double loH;
            double prxOH;
            double PotRX = -70;  //---- > sensibilidad wifi fija
            double grx = 5; //----> 5 fija
            double d;
            bool pot = false;
            double gtx = 0;
            double hte = 0;
            double ptx = 0;



            if (Gain == "")
            { gtx = 14; }//----> la da el mono dejar predet 3 
            else { gtx = Convert.ToDouble(Gain, CultureInfo.CreateSpecificCulture("es-ES")); }

            if (High == "")
            { hte = 50; }// Altura Estacion  -----> la da el mono dejar predet 50
            else { hte = Convert.ToDouble(High, CultureInfo.CreateSpecificCulture("es-ES")); }

            if (PowerFactor == "")
            { ptx = 12.6; }//----> la da el mono dejar predet 12.6
            else { ptx = Convert.ToDouble(PowerFactor, CultureInfo.CreateSpecificCulture("es-ES")); }



            hre = Math.Log10(hr);
            aHre = (3.2 * Math.Pow(hre, 2)) - 4.97;


            for (d = 0; d <= 80 && !pot; d = d + 0.001)
            {
                loH = (69.55 + 26.16 * Math.Log10(fc) - 13.82 * Math.Log10(hte) - aHre + (44.9 - 6.55 * Math.Log10(hte)) * Math.Log10(d));
                prxOH = ptx + gtx + grx - loH;
                if (prxOH <= PotRX)
                {
                    pot = true;

                }

            }
            cons = d * 1000;

            //fin calculo amplitud de patron de radiacion

            double sol_2 = 0;
            int k = 0;
            int kA = 0;

            double PcAsubE = AsubE;//punto central dispositivo fijo en coordenadas UTM
            double PcAsubN = AsubN;//punto central dispositivo fijo en coordenadasUTM

            double PcBsubE = PsubE;//punto central dispositivo a ajustar en coordenadas UTM
            double PcBsubN = PsubN;//punto central dispositivo a ajustar en coordenadas UTM

            double PAx1 = PcAsubE + (RA[0] * Cos(g[0]));
            double PAy1 = PcAsubN + (RA[0] * Sin(g[0]));

            if (dispFijo == "ESTACION SUBA" || dispFijo == "ESTACION SANTA LIBRADA")
            {
                PAx1 = PcAsubE + (RA[0] * Cos(g[0]));
                PAy1 = PcAsubN + (RA[0] * Sin(g[0]));
            }
            else
            {
                PAx1 = PcAsubE + (RA[0] * cons * Cos(g[0]));
                PAy1 = PcAsubN + (RA[0] * cons * Sin(g[0]));
            }

            double PBx1 = PcBsubE + (RB[0] * cons * Cos(g[0]));
            double PBy1 = PcBsubN + (RB[0] * cons * Sin(g[0]));


            double pasoB = 0.1;

            for (int n = 1; n < 73; n = n + 1)
            {
                double PAx2 = PcAsubE + RA[n] * Cos(g[n]);
                double PAy2 = PcAsubN + RA[n] * Sin(g[n]);

                if (dispFijo == "ESTACION SUBA" || dispFijo == "ESTACION SANTA LIBRADA")
                {
                    PAx2 = PcAsubE + RA[n] * Cos(g[n]);
                    PAy2 = PcAsubN + RA[n] * Sin(g[n]);
                }
                else
                {
                    PAx2 = PcAsubE + RA[n] * cons * Cos(g[n]);
                    PAy2 = PcAsubN + RA[n] * cons * Sin(g[n]);
                }

                if (PAx1 > PAx2) { kA = 0; }
                if (PAx1 < PAx2) { kA = 1; }

                for (int m = 1; m < 73; m = m + 1)
                {

                    double PBx2 = PcBsubE + RB[m] *cons* Cos(g[m]);
                    double PBy2 = PcBsubN + RB[m] *cons* Sin(g[m]);


                    if (PBx1 > PBx2 && pasoB > 0)
                    {
                        pasoB = -pasoB;

                    }
                    if (PBx1 < PBx2 && pasoB < 0)
                    {
                        pasoB = -pasoB;
                    }


                    if (pasoB < 0)
                    {
                        for (double xj = PBx1; xj >= PBx2; xj = xj + pasoB)
                        {
                            double cA = PAx2 - PAx1;
                            double cB = PBx2 - PBx1;

                            if (cA == 0)
                            { cA = 0.00001; }
                            if (cB == 0)
                            { cB = 0.00001; }

                            double sol_1 = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1) - (((xj - PBx1) * (PBy2 - PBy1) / (cB)) + PBy1);

                            if (sol_1 * sol_2 < 0)
                            {
                                if (xj >= PAx1 && xj <= PAx2 && kA == 1)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("dentro:id de dispoditivo A, " + "xj=" + xj + ", yj:" + yj);

                                    k = 1;
                                    return "dentro";

                                }
                                if (xj <= PAx1 && xj >= PAx2 && kA == 0)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);

                                    Console.WriteLine("dentro: id de dispoditivo A, " + "xj=" + xj + " yj:" + yj);
                                    k = 1;
                                    return "dentro";
                                }

                            }

                            sol_2 = sol_1;
                        }

                    }
                    if (pasoB > 0)
                    {
                        for (double xj = PBx1; xj <= PBx2; xj = xj + pasoB)
                        {
                            double cA = PAx2 - PAx1;
                            double cB = PBx2 - PBx1;

                            if (cA == 0)
                            { cA = 0.00001; }
                            if (cB == 0)
                            { cB = 0.00001; }

                            double sol_1 = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1) - (((xj - PBx1) * (PBy2 - PBy1) / (cB)) + PBy1);

                            if (sol_1 * sol_2 < 0)
                            {
                                if (xj >= PAx1 && xj <= PAx2 && kA == 1)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("dentro: id de dispoditivo A, " + "xj=" + xj + " yj:" + yj);
                                    k = 1;
                                    return "dentro";
                                }
                                if (xj <= PAx1 && xj >= PAx2 && kA == 0)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("dentro: id de dispoditivo A, " + "xj=" + xj + " yj:" + yj);
                                    k = 1;
                                    return "dentro";
                                }
                            }

                            sol_2 = sol_1;
                        }
                    }

                    PBx1 = PBx2;
                    PBy1 = PBy2;
                    if (k == 1)//cambiar k por 1 para salir al primer cruce
                    {
                        m = 6;
                    }
                }

                PAx1 = PAx2;
                PAy1 = PAy2;
                if (k == 1)//cambiar k por 1 para salir al primer cruce
                {
                    n = 6;
                }
            }

            if (k == 0)
            {
                PAx1 = PcAsubE + (RA[0] * Cos(g[0]));
                PAy1 = PcAsubN + (RA[0] * Sin(g[0]));

                PBy1 = PcBsubN + (RB[0] * Sin(g[0]));

                sol_2 = 0;
                int c = 0;

                for (int n = 1; n < 73; n = n + 1)
                {
                    double PAx2 = PcAsubE + RA[n] * Cos(g[n]);
                    double PAy2 = PcAsubN + RA[n] * Sin(g[n]);

                    if (PAx1 > PAx2 && pasoB > 0) { pasoB = -pasoB; kA = 0; }
                    if (PAx1 < PAx2 && pasoB < 0) { pasoB = -pasoB; kA = 1; }

                    if (pasoB < 0)
                    {
                        for (double xj = PAx1; xj >= PAx2; xj = xj + pasoB)
                        {
                            double cA = PAx2 - PAx1;


                            if (cA == 0)
                            { cA = 0.00001; }


                            double sol_1 = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1) - (xj - PcBsubE + PcBsubN);

                            if (sol_1 * sol_2 < 0)
                            {
                                if (xj >= PcBsubE)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("corte id de dispoditivo A recta, " + "xj=" + xj + ", yj:" + yj);
                                    c = c + 1;
                                }
                            }

                            sol_2 = sol_1;
                        }


                    }
                    if (pasoB > 0)
                    {
                        for (double xj = PAx1; xj <= PAx2; xj = xj + pasoB)
                        {
                            double cA = PAx2 - PAx1;


                            if (cA == 0)
                            { cA = 0.00001; }


                            double sol_1 = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1) - (xj - PcBsubE + PcBsubN);

                            if (sol_1 * sol_2 < 0)
                            {
                                if (xj >= PcBsubE)
                                {
                                    double yj = (((xj - PAx1) * (PAy2 - PAy1) / (cA)) + PAy1);
                                    Console.WriteLine("corte id de dispoditivo A RECTA, " + "xj=" + xj + " yj:" + yj);
                                    c = c + 1;
                                }

                            }

                            sol_2 = sol_1;
                        }
                    }

                    PAx1 = PAx2;
                    PAy1 = PAy2;
                }
                if (c % 2 == 0)
                {
                    //Console.WriteLine("fuera: id de dispoditivo A RECTA, " + "c= " + c);
                    //return "fuera";
                }
                else
                {
                    Console.WriteLine("dentro: id de dispoditivo A RECTA, " + "c= " + c);
                    return "dentro";
                }
            }

            return "fuera";



        }
        catch (Exception ex)
        {
            throw ex;
        }



    }

    #endregion

    
    #region Validation Zone WithoutModel 
    [WebMethod(EnableSession = true)]
    public static string ValidationZoneWithoutModel(string latAnntena, string lngAnntena, string latDevice, string lngDevice)
    {

        double pi = Math.PI;


        //DESACTIVADA POR AHORA!!! :O

        //double AsubE = 602613.232171032;//punto central antena Suba en coordenadas UTM ESTE
        //double AsubN = 524389.864541357;//punto central antena Suba en coordenadas UTM NORTE

        //double PsubE = 601997.7;//punto central dispositivo en coordenadas UTM ESTE
        //double PsubN = 519703;//punto central dispositivo en coordenadas UTM NORTE
        //string LatAnntena = latAnntena.Replace(".", ",");
        //string LngAnntena = lngAnntena.Replace(".", ",");
        //string LatDevice = latDevice.Replace(".", ",");
        //string LngDevice = lngDevice.Replace(".", ",");

        double AsubE = Convert.ToDouble(latAnntena);
        double AsubN = Convert.ToDouble(lngAnntena);
        double PsubE = Convert.ToDouble(latDevice);
        double PsubN = Convert.ToDouble(lngDevice);

        double utmAntennaLat = 0;
        double utmAntennaLng = 0;
        double utmDeviceLat = 0;
        double utmDeviceLng = 0;

        string[] coordenadasAnntena = ConvertGPSToUTM(AsubE, AsubN);
        string[] coordenadasDevice = ConvertGPSToUTM(PsubE, PsubN);

        if (coordenadasAnntena.Count() == 2)
        {
            foreach (string coord in coordenadasAnntena)
            {
                if (utmAntennaLat == 0)
                {
                    utmAntennaLat = Convert.ToDouble(coord);
                }
                else if (utmAntennaLng == 0)
                {
                    utmAntennaLng = Convert.ToDouble(coord);
                }
            }
        }

        if (coordenadasDevice.Count() == 2)
        {
            foreach (string coord in coordenadasDevice)
            {
                if (utmDeviceLat == 0)
                {
                    utmDeviceLat = Convert.ToDouble(coord);
                }
                else if (utmDeviceLng == 0)
                {
                    utmDeviceLng = Convert.ToDouble(coord);
                }
            }
        }


        double X1 = utmDeviceLat - utmAntennaLat;

        double Y1 = utmDeviceLng - utmAntennaLng;

        double fSubPi = -400 * (Math.Sin((pi / 2 * Math.Cos(pi)) * 6 / 2) / (Math.Sin((pi / 2 * Math.Cos(pi)) / 2))) * (Math.Sin((pi / 2 * Math.Cos(pi)) * 6 / 2) / (Math.Sin((pi / 2 * Math.Cos(pi)) / 2)));// funcion de la antena evaluada en PI

        double paso = 0.0001, sol_1, sol_2 = 0, a = 0, c = 0, k = 0;
        for (double i = 0; i <= 2 * pi; i = i + paso)
        {

            sol_1 = 400 * (Math.Sin((pi / 2 * Math.Cos(i)) * 6 / 2) / (Math.Sin((pi / 2 * Math.Cos(i)) / 2))) * (Math.Sin((pi / 2 * Math.Cos(i)) * 6 / 2) / (Math.Sin((pi / 2 * Math.Cos(i)) / 2))) - (Y1 / Math.Sin(i));// funcion de la antena mas recta 
            if (sol_1 * sol_2 < 0)
            {

                Console.WriteLine("Los puntos de corte son:" + i);
                a = 400 * (Math.Sin((pi / 2 * Math.Cos(i)) * 6 / 2) / (Math.Sin((pi / 2 * Math.Cos(i)) / 2))) * (Math.Sin((pi / 2 * Math.Cos(i)) * 6 / 2) / (Math.Sin((pi / 2 * Math.Cos(i)) / 2))); // funcion antena
                a = a * Math.Cos(i);

                Console.WriteLine("a:" + a);

                if (a > X1)
                {
                    c = c + 1;
                }

                if (X1 < fSubPi)
                {
                    if (k == 0)
                    {
                        c = c - 1;
                        Console.WriteLine("yeah" + c);
                        k = 1;
                    }
                }
            }
            sol_2 = sol_1;
        }

        if (c % 2 == 0)
        {
            return "fuera";
        }
        else
        {
            return "dentro";
        }
    }

    #endregion


    #region GRAFIQUINHA LATITUDES
    [WebMethod(EnableSession = true)]
    // public static string Grafiquinha(string latitud, string longitud, string fixedDevice, string patternDb, string patternDrop, string gain, string powerFactor, string high)
    public static string Grafiquinha(string latitud, string longitud, string fixedDevice, string patternDrop,string gain, string powerFactor, string high)
    {
        //PuntoGrafica[] Puntos = new PuntoGrafica[72];
        try
        {



            string LatDevice = latitud.Replace(".", ",");
            string LngDevice = longitud.Replace(".", ",");
            string Gain = gain.Replace(".", ",");
            string PowerFactor = powerFactor.Replace(".", ",");
            string High = high.Replace(".", ",");

            double PuntsubE = Convert.ToDouble(LatDevice);
            double PuntsubN = Convert.ToDouble(LngDevice);
                                    
            //double PuntsubE = Convert.ToDouble(LatDevice, CultureInfo.CreateSpecificCulture("es-ES"));
            //double PuntsubN = Convert.ToDouble(LngDevice, CultureInfo.CreateSpecificCulture("es-ES"));
                        
            double pi = Math.PI;
            
            
            string[] coordenadasDevice = ConvertGPSToUTM(PuntsubE, PuntsubN);
            string Plat = coordenadasDevice[0];
            string Plng = coordenadasDevice[1];

            double PcAsubE = Convert.ToDouble(Plat);
            double PcAsubN = Convert.ToDouble(Plng);



           
            //string patronDataB = patternDb;//Patron guardado en la BD
            string patronDropdown = patternDrop;
            string dispFijo = fixedDevice;

            double[] RA = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            double[] RB = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

            if (dispFijo == "ESTACION SUBA")
            {
                RA = new double[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }; //Modelo 1 SUBA
            }
            else if (dispFijo == "ESTACION SANTA LIBRADA")
            {
                RA = new double[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }; //depende del modelo y del patron de rad del dispositivo fijo
            }
            //else
            //{
            //    //Estos valores pueden cambiar segun el dispositivo ?

            //    if (patronDataB == "1")
            //    {
            //        RA = new double[] { 1, 0.988876986, 0.956124372, 0.903545477, 0.83399558, 0.751167281, 0.659312559, 0.562925357, 0.466414596, 0.373800259, 0.288462966, 0.212969978, 0.148989113, 0.097289178, 0.057814075, 0.029810266, 0.011984724, 0.002672707, 0, 0.002030789, 0.006897836, 0.012914845, 0.018671195, 0.023106928, 0.025562491, 0.025794892, 0.023951897, 0.020499874, 0.016109123, 0.011511359, 0.007354108, 0.00408219, 0.001873848, 0.000647423, 0.000136138, 8.83289E-06, 3.75247E-33, 8.83289E-06, 0.000136138, 0.000647423, 0.001873848, 0.00408219, 0.007354108, 0.011511359, 0.016109123, 0.020499874, 0.023951897, 0.025794892, 0.025562491, 0.023106928, 0.018671195, 0.012914845, 0.006897836, 0.002030789, 0, 0.002672707, 0.011984724, 0.029810266, 0.057814075, 0.097289178, 0.148989113, 0.212969978, 0.288462966, 0.373800259, 0.466414596, 0.562925357, 0.659312559, 0.751167281, 0.83399558, 0.903545477, 0.956124372, 0.988876986, 1 };
            //    }
            //    else if (patronDataB == "2")
            //    {
            //        RA = new double[] { 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.947001689, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841286599, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1 };

            //    }
            //    //
            //}

            if (patronDropdown == "1")
            {
                RA = new double[] { 1, 0.988876986, 0.956124372, 0.903545477, 0.83399558, 0.751167281, 0.659312559, 0.562925357, 0.466414596, 0.373800259, 0.288462966, 0.212969978, 0.148989113, 0.097289178, 0.057814075, 0.029810266, 0.011984724, 0.002672707, 0, 0.002030789, 0.006897836, 0.012914845, 0.018671195, 0.023106928, 0.025562491, 0.025794892, 0.023951897, 0.020499874, 0.016109123, 0.011511359, 0.007354108, 0.00408219, 0.001873848, 0.000647423, 0.000136138, 8.83289E-06, 3.75247E-33, 8.83289E-06, 0.000136138, 0.000647423, 0.001873848, 0.00408219, 0.007354108, 0.011511359, 0.016109123, 0.020499874, 0.023951897, 0.025794892, 0.025562491, 0.023106928, 0.018671195, 0.012914845, 0.006897836, 0.002030789, 0, 0.002672707, 0.011984724, 0.029810266, 0.057814075, 0.097289178, 0.148989113, 0.212969978, 0.288462966, 0.373800259, 0.466414596, 0.562925357, 0.659312559, 0.751167281, 0.83399558, 0.903545477, 0.956124372, 0.988876986, 1 };
            }
            else if (patronDropdown == "2")
            {
                RA = new double[] { 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.946931306, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841356982, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1, 0.993595158, 0.975154842, 0.947001689, 0.912302928, 0.875633446, 0.841216216, 0.813203829, 0.794974662, 0.788640203, 0.795045045, 0.813274212, 0.841286599, 0.875774212, 0.912443694, 0.947001689, 0.975225225, 0.993665541, 1 };
            }

            
            double[] g = { 0, 0.087266463, 0.174532925, 0.261799388, 0.34906585, 0.436332313, 0.523598776, 0.610865238, 0.698131701, 0.785398163, 0.872664626, 0.959931089, 1.047197551, 1.134464014, 1.221730476, 1.308996939, 1.396263402, 1.483529864, 1.570796327, 1.658062789, 1.745329252, 1.832595715, 1.919862177, 2.00712864, 2.094395102, 2.181661565, 2.268928028, 2.35619449, 2.443460953, 2.530727415, 2.617993878, 2.705260341, 2.792526803, 2.879793266, 2.967059728, 3.054326191, 3.141592654, 3.228859116, 3.316125579, 3.403392041, 3.490658504, 3.577924967, 3.665191429, 3.752457892, 3.839724354, 3.926990817, 4.01425728, 4.101523742, 4.188790205, 4.276056667, 4.36332313, 4.450589593, 4.537856055, 4.625122518, 4.71238898, 4.799655443, 4.886921906, 4.974188368, 5.061454831, 5.148721293, 5.235987756, 5.323254219, 5.410520681, 5.497787144, 5.585053606, 5.672320069, 5.759586532, 5.846852994, 5.934119457, 6.021385919, 6.108652382, 6.195918845, 0 }; //grados a los que se evalua el RAn y RBn

            //inicio calculo amplitud de patron de radiacion

            double cons;
            double fc = 470; // 
            const double hr = 17.625;    //11.75*1.5 fijo
            double aHre; // factor de correcion de altura no cambia
            double hre; // no cambia
            double loH;
            double prxOH;
            double PotRX = -70;  //---- > sensibilidad wifi fija
            double grx = 5; //----> 5 fija
            double d;
            bool pot = false;
            double gtx = 0;
            double hte = 0;
            double ptx = 0;



            //if (Gain == "")
            //{ gtx = 14; }//----> la da el mono dejar predet 3 
            //else { gtx = Convert.ToDouble(Gain, CultureInfo.CreateSpecificCulture("es-ES")); }

            //if (High == "")
            //{ hte = 50; }// Altura Estacion  -----> la da el mono dejar predet 50
            //else { hte = Convert.ToDouble(High, CultureInfo.CreateSpecificCulture("es-ES")); }

            //if (PowerFactor == "")
            //{ ptx = 12.6; }//----> la da el mono dejar predet 12.6
            //else { ptx = Convert.ToDouble(PowerFactor, CultureInfo.CreateSpecificCulture("es-ES")); }

            if (Gain == "")
            { gtx = 14; }//----> la da el mono dejar predet 3 
            else { gtx = Convert.ToDouble(Gain); }

            if (High == "")
            { hte = 50; }// Altura Estacion  -----> la da el mono dejar predet 50
            else { hte = Convert.ToDouble(High); }

            if (PowerFactor == "")
            { ptx = 12.6; }//----> la da el mono dejar predet 12.6
            else { ptx = Convert.ToDouble(PowerFactor); }


            //gtx = 14;
            //hte = 50;
            //ptx = 12.6;

            hre = Math.Log10(hr);
            aHre = (3.2 * Math.Pow(hre, 2)) - 4.97;


            for (d = 0; d <= 80 && !pot; d = d + 0.001)
            {
                loH = (69.55 + 26.16 * Math.Log10(fc) - 13.82 * Math.Log10(hte) - aHre + (44.9 - 6.55 * Math.Log10(hte)) * Math.Log10(d));
                prxOH = ptx + gtx + grx - loH;
                if (prxOH <= PotRX)
                {
                    pot = true;

                }

            }
            cons = d * 1000;





            List<string> LatLng = new List<string>();
            string[] latslngs = new string[145];

            string output;


            for (int n = 0; n < 73; n = n + 1)
            {
                double PAx = PcAsubE + (RA[n] * cons * Cos(g[n]));
                double PAy = PcAsubN + (RA[n] * cons * Sin(g[n]));

                //-------------------------------- inicion Metodo UTM a GPS

                double UTME = PAx;
                double UTMN = PAy;


                double semiejeMayor = 6378388;
                double semiejeMenor = 6356911.946;
                double excentricidad = Math.Sqrt((semiejeMayor * semiejeMayor) - (semiejeMenor * semiejeMenor)) / semiejeMayor;
                double excentricidad2 = Math.Sqrt((semiejeMayor * semiejeMayor) - (semiejeMenor * semiejeMenor)) / semiejeMenor;
                double cuadradoExcentricidad = excentricidad2 * excentricidad2;
                double radioPolarCurvatura = (semiejeMayor * semiejeMayor) / semiejeMenor;
                //Fin elipsoide
                double huso = 18;

                //variables repetidas Ni=Ni2, A1=A12, A2=A22, J2=J22, J4=J42, J6=J62, Alfa=Alfa2,                  
                double FiPrima = UTMN / (6366197.724 * 0.9996);
                double Ni2 = (radioPolarCurvatura / (Math.Sqrt(1 + cuadradoExcentricidad * Math.Cos(FiPrima) * Math.Cos(FiPrima)))) * 0.9996;
                double a = (UTME - 500000) / Ni2;
                double A12 = Math.Sin(2 * FiPrima);
                double A22 = A12 * Math.Cos(FiPrima) * Math.Cos(FiPrima);
                double J22 = FiPrima + (A12 / 2);
                double J42 = ((3 * J22) + A22) / 4;
                double J62 = ((5 * J42) + A22 * (Math.Cos(FiPrima) * Math.Cos(FiPrima))) / 3;
                double Alfa2 = 3 * cuadradoExcentricidad / 4;
                double Beta2 = 5 * Alfa2 * Alfa2 / 3;
                double Gamma2 = 35 * Alfa2 * Alfa2 * Alfa2 / 27;
                double BSubFi2 = 0.9996 * radioPolarCurvatura * (FiPrima - (Alfa2 * J22) + (Beta2 * J42) - (Gamma2 * J62));
                double b = (UTMN - BSubFi2) / Ni2;
                double Zeta2 = ((cuadradoExcentricidad * a * a) / 2) * (Math.Cos(FiPrima) * Math.Cos(FiPrima));
                double Xi2 = (a) * (1 - (Zeta2 / 3));
                double Eta2 = b * (1 - Zeta2) + FiPrima;
                double SinhXi2 = Math.Sinh(Xi2);
                double deltaLamda2 = Math.Atan(SinhXi2 / (Math.Cos(Eta2)));
                double Tau = Math.Atan(Math.Cos(deltaLamda2) * Math.Tan(Eta2));
                double MerCentral = 6 * huso - 183;
                double FiRad = FiPrima + (1 + cuadradoExcentricidad * (Math.Cos(FiPrima) * Math.Cos(FiPrima)) - 3 * cuadradoExcentricidad / 2 * Math.Sin(FiPrima) * Math.Cos(FiPrima) * (Tau - FiPrima)) * (Tau - FiPrima);
                double longitude2 = (deltaLamda2 / pi) * 180 + MerCentral;
                double latitude2 = (FiRad / pi) * 180;
                //-------------------------------- fin Metodo UTM a GPS

                //Puntos[n] = new PuntoGrafica(latitude2, longitude2);
                string convlat = Convert.ToString(latitude2);
                string convlng = Convert.ToString(longitude2);

                LatLng.Add(convlat);
                LatLng.Add(convlng);


                latslngs = LatLng.ToArray();




            }
            output = JsonConvert.SerializeObject(latslngs);

            return output;




        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion


    private static string[] ConvertGPSToUTM(double lat, double lng)
    {

        try
        {

            List<string> coordList = new List<string>();           // <!--Inicio GPS a UTM--->
            //Inicio Elipsoide
            double semiejeMayor = 6378388;
            double semiejeMenor = 6356911.946;
            double excentricidad = Math.Sqrt((semiejeMayor * semiejeMayor) - (semiejeMenor * semiejeMenor)) / semiejeMayor;
            double excentricidad2 = Math.Sqrt((semiejeMayor * semiejeMayor) - (semiejeMenor * semiejeMenor)) / semiejeMenor;
            double cuadradoExcentricidad = excentricidad2 * excentricidad2;
            double radioPolarCurvatura = (semiejeMayor * semiejeMayor) / semiejeMenor;
            //Fin elipsoide
            //Inicio GPS En Radianes   

            double pi = Math.PI;

            double radlong = lng * pi / 180;
            double radlat = lat * pi / 180;
            //FIN GPS En Radianes

            //Inicio Calculo de Huso y meridiano de Huso
            double huso = Math.Truncate((lng / 6) + 31);
            double merHuso = 6 * huso - 183;
            //FIN Calculo de Huso y meridiano de Huso

            //Inicio Calculo de 15 Variables 
            double deltaLamda = radlong - ((merHuso * pi) / 180);
            double A = Math.Cos(radlat) * Math.Sin(deltaLamda);
            double Xi = (0.5) * (Math.Log((1 + A) / (1 - A)));
            double Eta = Math.Atan(((Math.Tan(radlat)) / (Math.Cos(deltaLamda)))) - radlat;
            double Ni = (radioPolarCurvatura / (Math.Sqrt(1 + cuadradoExcentricidad * Math.Cos(radlat) * Math.Cos(radlat)))) * 0.9996;
            double Zeta = (cuadradoExcentricidad / 2) * (Xi * Xi) * (Math.Cos(radlat) * Math.Cos(radlat));
            double A1 = Math.Sin(2 * radlat);
            double A2 = A1 * Math.Cos(radlat) * Math.Cos(radlat);
            double J2 = radlat + (A1 / 2);
            double J4 = ((3 * J2) + A2) / 4;
            double J6 = ((5 * J4) + A2 * (Math.Cos(radlat) * Math.Cos(radlat))) / 3;
            double Alfa = 3 * cuadradoExcentricidad / 4;
            double Beta = 5 * Alfa * Alfa / 3;
            double Gamma = 35 * Alfa * Alfa * Alfa / 27;
            double BSubFi = 0.9996 * radioPolarCurvatura * (radlat - (Alfa * J2) + (Beta * J4) - (Gamma * J6));
            //Fin Calculo de 15 Variables 
            //Coordenada UTM
            double UTME = Xi * Ni * (1 + (Zeta / 3)) + 500000;// en eje x
            double UTMN = Eta * Ni * (1 + Zeta) + BSubFi;// en eje y

            coordList.Add(UTME.ToString());
            coordList.Add(UTMN.ToString());

            return coordList.ToArray();

            //<!--Fin GPS a UTM--->


        }
        catch (Exception ex)
        {
            throw new NotImplementedException();
        }



    }

    public static double Sin(double d)
    {
        d = d % (2 * Math.PI); // Math.Sin calculates wrong results for values larger than 1e6
        if (d == 0 || d == Math.PI || d == -Math.PI)
        {
            return 0.0;
        }
        else
        {
            return Math.Sin(d);
        }
    }

    public static double Cos(double d)
    {
        d = d % (2 * Math.PI); // Math.Cos calculates wrong results for values larger than 1e6
        double multipleOfPi = d / Math.PI; // avoid calling the expensive modulo function twice
        if (multipleOfPi == 0.5 || multipleOfPi == -0.5 || multipleOfPi == 1.5 || multipleOfPi == -1.5)
        {
            return 0.0;
        }
        else
        {
            return Math.Cos(d);
        }
    }
}