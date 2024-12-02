using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Configuration;
using System.IO;


/// <summary>
/// Summary description for SQLserver
/// </summary>
public class SQLserver
{
    public static SqlConnection conn { get; set; }


    public static SqlConnection Connect()
    {
        try
        {
            string datasource = ConfigurationManager.AppSettings["Server"];
            string initialcatalog = ConfigurationManager.AppSettings["InitialCatalogo"];
            string userid = ConfigurationManager.AppSettings["Username"];
            string password = ConfigurationManager.AppSettings["Password"];

            string databaseConnectionString = "Data Source=" + datasource + ";Initial Catalog=" + initialcatalog + ";User ID=" + userid + ";Password=" + password + ";";


            conn = new SqlConnection(databaseConnectionString);
            SqlConnection.ClearAllPools();
            Console.WriteLine(conn.ToString());
            return conn;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public static DataSet ExecuteDataSet(string query)
    {
        try
        {

            if (conn == null)
            {
                Connect().Open();
            }
            using (SqlDataAdapter da = new SqlDataAdapter(query, Connect()))
            {

                DataSet ds = new DataSet();
                da.Fill(ds);
                Connect().Close();
                return ds;
            }

        }
        catch (SqlException ex)
        {
            writeTextLog(ex.Message);
            Connect().Close();
            throw ex;

        }
        catch (Exception ex)
        {
            writeTextLog(ex.Message);
            Connect().Close();
            throw ex;
        }


    }
    public static Boolean ExecuteCommand(string comando)
    {
        Boolean rta;
        try
        {

            if (conn == null)
            {
                Connect().Open();
            }

            using (SqlCommand cm = new SqlCommand(comando, Connect()))
            {

                cm.Connection.Open();
                cm.ExecuteNonQuery();
                rta = true;
                return rta;
            }
        }
        catch (SqlException ex)
        {
            writeTextLog(ex.Message);
            Connect().Close();
            rta = false;
            return rta;
        }

        catch (Exception ex)
        {
            writeTextLog(ex.Message);
            Connect().Close();
            rta = false;
            return rta;
        }
    }

    public static object SqlExecuteNonQuery(SqlCommand command)
    {


        object value = null;
        try
        {
            if (conn == null)
            {
                Connect().Open();
            }

            if (conn.State != ConnectionState.Open)
            {
                conn.Open();
            }
            command.Connection = conn;
            value = command.ExecuteScalar();

        }
        catch (Exception ex)
        {
            writeTextLog(ex.Message);
            Connect().Close();
            throw ex;

        }

        return value;

    }

    public static SqlParameter CreateParameter()
    {
        return new SqlParameter();
    }

    public static SqlCommand CreateCommand()
    {
        return new SqlCommand();
    }

    public static object SaveEntry(string location, string counterNumber, string dateReceived)
    {
        try
        {
            SqlParameter parameterlocationname = CreateParameter();
            SqlParameter parameterdateReceived = CreateParameter();
            SqlParameter parametercounterNumber = CreateParameter();


            parameterlocationname.ParameterName = "@localitation";
            parameterlocationname.SqlDbType = SqlDbType.VarChar;
            parameterlocationname.Value = location;

            parameterdateReceived.ParameterName = "@countNumber";
            parameterdateReceived.SqlDbType = SqlDbType.VarChar;
            parameterdateReceived.Value = counterNumber;

            parametercounterNumber.ParameterName = "@dateReceived";
            parametercounterNumber.SqlDbType = SqlDbType.VarChar;
            parametercounterNumber.Value = dateReceived;

            object VariableRetorno = null;

            SqlCommand commandCounter = CreateCommand();

            commandCounter.Parameters.Add(parameterlocationname);
            commandCounter.Parameters.Add(parameterdateReceived);
            commandCounter.Parameters.Add(parametercounterNumber);

            commandCounter.CommandType = CommandType.StoredProcedure;
            commandCounter.CommandText = "SP_SAVE_COUNTER";

            VariableRetorno = SqlExecuteNonQuery(commandCounter);

            commandCounter.Dispose();

            return VariableRetorno;
        }
        catch (Exception ex)
        {
            throw ex;

        }
    }


    private static void writeTextLog(string textLog)
    {
        try
        {
            // Example #2: Write one string to a text file.
            string text = textLog;
            // WriteAllText creates a file, writes the specified string to the file,
            // and then closes the file.    You do NOT need to call Flush() or Close().
            string filePath = ConfigurationManager.AppSettings.Get("LoggerPath") + "\\Logtxt.txt";

            if (!File.Exists(filePath))
            {
                // Create a file to write to.
                using (StreamWriter sw = File.CreateText(filePath))
                {
                    sw.WriteLine(text);

                }
            }


            // This text is always added, making the file longer over time
            // if it is not deleted.
            using (StreamWriter sw = File.AppendText(filePath))
            {
                sw.WriteLine(text);
            }



        }
        catch
        {

        }
    }
}


