using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Reflection;

/// <summary>
/// Summary description for DeviceController
/// </summary>
public class DeviceController
{
 
    public static IList<Device> GetDevice()
    {
        IList<Device> DevicesList = new List<Device>();

        DataSet getDevices = SQLserver.ExecuteDataSet("SELECT * FROM Devices");

        Device objItem = null;
        if (getDevices.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i <= getDevices.Tables[0].Rows.Count - 1; i++)
            {

                objItem = new Device();
                objItem.Id = getDevices.Tables[0].Rows[i][0].ToString();
                objItem.Name = getDevices.Tables[0].Rows[i][1].ToString();
                objItem.Description = getDevices.Tables[0].Rows[i][2].ToString();
                objItem.Latitude = getDevices.Tables[0].Rows[i][3].ToString();
                objItem.Longitude = getDevices.Tables[0].Rows[i][4].ToString();
                objItem.Chanel = getDevices.Tables[0].Rows[i][5].ToString();
                objItem.Model = getDevices.Tables[0].Rows[i][6].ToString();
                objItem.Pattern = getDevices.Tables[0].Rows[i][7].ToString();
                objItem.GroundConditions = getDevices.Tables[0].Rows[i][8].ToString();
                objItem.Gain = getDevices.Tables[0].Rows[i][9].ToString();
                objItem.PowerFactor = getDevices.Tables[0].Rows[i][10].ToString();
                objItem.High = getDevices.Tables[0].Rows[i][11].ToString();

                DevicesList.Add(objItem);
            }
        }

        return DevicesList;

    }

    public static IList<Channel> GetChannels()
    {
        IList<Channel> channelList = new List<Channel>();

        DataSet getDevices = SQLserver.ExecuteDataSet("SELECT * FROM Canales");

        Channel objItem = null;
        if (getDevices.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i <= getDevices.Tables[0].Rows.Count - 1; i++)
            {

                objItem = new Channel();
                objItem.Id = getDevices.Tables[0].Rows[i][0].ToString();
                objItem.Description = getDevices.Tables[0].Rows[i][1].ToString();

                channelList.Add(objItem);
            }
        }

        return channelList;

    }

    public static List<string> GetAvailableChannels(string antena)
    {
        List<string> channelListTable = new List<string>();
        string chanel = string.Empty;
        DataSet getDevices = SQLserver.ExecuteDataSet("select * from devices where Antena LIKE '%"+antena+"%'");

    
        if (getDevices.Tables[0].Rows.Count > 0)
        {
        
            for (int i = 0; i <= getDevices.Tables[0].Rows.Count - 1; i++)
            {

                chanel = getDevices.Tables[0].Rows[i][5].ToString();
                channelListTable.Remove(chanel);
              
            }
        }

        return channelListTable;

    }

    public static IList<Device> GetDeviceById(string id)
    {
        IList<Device> DevicesList = new List<Device>();
        try
        {
            

            DataSet getDevices = SQLserver.ExecuteDataSet("SELECT * FROM Devices where Id='" + id + "'");

            Device objItem = null;
            if (getDevices.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i <= getDevices.Tables[0].Rows.Count - 1; i++)
                {

                    objItem = new Device();
                    objItem.Id = getDevices.Tables[0].Rows[i][0].ToString();
                    objItem.Name = getDevices.Tables[0].Rows[i][1].ToString();
                    objItem.Description = getDevices.Tables[0].Rows[i][2].ToString();
                    objItem.Latitude = getDevices.Tables[0].Rows[i][3].ToString();
                    objItem.Longitude = getDevices.Tables[0].Rows[i][4].ToString();
                    objItem.Chanel = getDevices.Tables[0].Rows[i][5].ToString();
                    objItem.Model = getDevices.Tables[0].Rows[i][6].ToString();
                    objItem.Pattern = getDevices.Tables[0].Rows[i][7].ToString();
                    objItem.GroundConditions = getDevices.Tables[0].Rows[i][8].ToString();
                    objItem.Gain = getDevices.Tables[0].Rows[i][9].ToString();
                    objItem.PowerFactor = getDevices.Tables[0].Rows[i][10].ToString();
                    objItem.High = getDevices.Tables[0].Rows[i][11].ToString();


                    DevicesList.Add(objItem);
                }
            }

            return DevicesList;

        }
        catch (Exception ex)
        {

            return DevicesList;
        }
        
       
    }

    public static IList<Device> GetDeviceByName(string name)
    {
        IList<Device> DevicesList = new List<Device>();
        try
        {


            DataSet getDevices = SQLserver.ExecuteDataSet("SELECT * FROM Devices where name='" + name + "'");

            Device objItem = null;
            if (getDevices.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i <= getDevices.Tables[0].Rows.Count - 1; i++)
                {

                    objItem = new Device();
                    objItem.Id = getDevices.Tables[0].Rows[i][0].ToString();
                    objItem.Name = getDevices.Tables[0].Rows[i][1].ToString();
                    objItem.Description = getDevices.Tables[0].Rows[i][2].ToString();
                    objItem.Latitude = getDevices.Tables[0].Rows[i][3].ToString();
                    objItem.Longitude = getDevices.Tables[0].Rows[i][4].ToString();
                    objItem.Chanel = getDevices.Tables[0].Rows[i][5].ToString();
                    objItem.Model = getDevices.Tables[0].Rows[i][6].ToString();
                    objItem.Pattern = getDevices.Tables[0].Rows[i][7].ToString();
                    objItem.GroundConditions = getDevices.Tables[0].Rows[i][8].ToString();
                    objItem.Gain = getDevices.Tables[0].Rows[i][9].ToString();
                    objItem.PowerFactor = getDevices.Tables[0].Rows[i][10].ToString();
                    objItem.High = getDevices.Tables[0].Rows[i][11].ToString();


                    DevicesList.Add(objItem);
                }
            }

            return DevicesList;

        }
        catch (Exception ex)
        {

            return DevicesList;
        }


    }

    public static bool UpdateDevice(string id, string name, string description , string channel , string latitud, string longitud , string model , string pattern)
    {
        try
        {
            
            bool updateDevice = SQLserver.ExecuteCommand("UPDATE  Devices SET name = '" + name + "',description='" + description + "' , latitude='" + latitud + "', longitude='" + longitud + "', chanel = '" + channel + "', model = '" + model + "', pattern = '" + pattern + "' where Id='" + id + "'");
            return updateDevice;
        }
        catch(Exception ex)
        {
            return false;

        }
       
    }

    public static bool UpdateDeviceWithURL(string id, string groundConditions, string gain, string powerFactor, string high)
    {
        try
        {

            bool updateDevice = SQLserver.ExecuteCommand("UPDATE  Devices SET groundConditions = '" + groundConditions + "', gain='" + gain + "', powerFactor='" + powerFactor + "' , high='" + high  + "' where Id='" + id + "'");
            return updateDevice;
        }
        catch (Exception ex)
        {
            return false;

        }

    }

    public static bool UpdateLocation(string id, string latitude, string longitude)
    {
        try
        {

            bool updateDevice = SQLserver.ExecuteCommand("UPDATE  Devices SET  latitude='" + latitude + "', longitude='" + longitude + "' where Id='" + id + "'");
            return updateDevice;
        }
        catch (Exception ex)
        {
            return false;

        }

    }

    public static bool CreateDevice(string name, string description, string channel, string latitude , string longitude, string model , string pattern)
    {
        try
        {

            //Primero verifico si ya existe
            bool exist = false;
            IList<Device> DevicesList = new List<Device>();
            DevicesList = GetDeviceByName(name);

            foreach(Device item in DevicesList)
            {
                if (item.Name == name)
                {
                    exist = true;
                }

            }

            if (exist)
            {
                return false;
            }
            else
            {
                bool createDevice = SQLserver.ExecuteCommand("INSERT  INTO Devices (name,description,latitude,longitude,chanel,model,pattern) VALUES('" + name + "','" + description + "','"+latitude+ "', '"+longitude+"','"+channel+ "','" + model + "','" + pattern + "')");
                return createDevice;
                
            }

        
        }
        catch (Exception ex)
        {
            return false;

        }


    }
}