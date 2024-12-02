<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html>
<head runat="server">
<meta charset="utf-8"/>
    <title>Tipos de datos</title>
    <!---comentario desplegado en HTML y visualizado en el codigo fuente--->
</head>
<body>
    <h1>Tipos de datos</h1>
    <%
        //comentario que va al servidor (C#)
        string texto = "Cargando..........";
        string num = "12";
        // con la palabra "const string" creo una cadena de caracteres constante
        const string texto2 = "constante";
        //sintaxis
        float flotante = 1.10f;
        //double mejor opcion para manejar datos decimales (exportar e importar)
        double doble = 1.10;
        decimal decimal1 = 1.10m;

        //Ejemplo conversion implicita
        int num2 = int.Parse(num);


        %>
    <%Response.Write(texto); %>
    <!---concatenacion (string y int o string y string)--->
   <p> <%=texto2+texto%></p>
    

    <!--condiciones en C#--->
    
</body>
</html>
