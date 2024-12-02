<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="Public/css/estilos.css" rel="stylesheet" />
<title >Modelos de Propagación</title>
    
<!---Bootstrap y jquery -->
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css"/>
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

</head>
<body >


    <!---Nuevo header-->
    <header class="header" style="background-color:#0c3c60; margin-bottom:0px; padding-bottom:20px;position:static">
        <div class ="wrapper">
        <div class="logo">
            <img class="displayed" src="Public/image/200px-Escudo_UD.svg.png"   />
           
        </div>
        <div> <h1 style="color:#d1f4eb; text-align:center">GESTIÓN DE ESPACIOS EN BLANCO DE LA TELEVISIÓN DIGITAL</h1>
        <nav style="margin-top:22px">
            <a href="Default2.aspx">Inicio</a>
            <a href="Modelos.aspx">Modelos de Propagación</a>
            <a href="RDS.aspx">RDS</a>
           <a href="Autores.aspx">Información Adicional</a>
        </nav>
        </div>
        </div>
        </header>
   <form id="form1" runat="server">
        <div class="row" style="padding-left:20px;padding-top: 50px;padding-bottom:50px; background-image:url(Background2.png)"> 
            <div class="modal-fade" id="ModalMap" tabindex="-1" role="dialog" >
                            <div class="modal-dialog" role="document" style="margin:0px auto; position:static">
                                <div class="modal-content" style="width:900px; top:50%;left:50%;margin-left:-450px">
                                    <div class="modal-body" style="background-color:#d2e0eb">
                                        <div class="from-horizontal">
                                           
                                            <center>
                                          <h3 style="color:#0c3c60"> Radio Definido por Software (RDS)</h3><hr style="width:75%;color:#6ea4ca; "/>
                                            </center>
                                               <center>   <h5><strong> USRP N210</strong></h5></center>
                                           <p>  El USRP N210 proporciona una capacidad de procesamiento de alto rango dinámico y alto ancho de banda.<br/> Este dispositivo posee una arquitectura que incluye un dispositivo Xilinx® Spartan® 3A-DSP 3400 FPGA, 100 MS / s dual ADC, 400 MS / s dual DAC y conectividad Gigabit Ethernet para transmitir datos hacia y desde los procesadores host.<br/></p> 
                                          <center> <img src="RDS.jpg" style="height:40%" /></center>
                                          <p><br/>Posee un diseño modular que permite que funcione de CC a 6 GHz y un puerto de expansión que permite que múltiples dispositivos de la serie USRP N210 se sincronicen y utilicen en una configuración MIMO.  <br/> Este RDS proporciona un FPGA que puede procesar hasta 100 MS / s en las direcciones de transmisión y recepción.</p> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
        </div>
    </form>
</body>
</html>
