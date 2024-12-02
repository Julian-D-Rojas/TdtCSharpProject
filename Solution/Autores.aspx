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
                                          <h3 style="color:#0c3c60"> Información Adicional</h3><hr style="width:75%;color:#6ea4ca; "/></center>
                                                <center>   <h5><strong>PROTOTIPO DE SOFTWARE PARA EL USO DE ESPACIOS EN BLANCO DE LA TELEVISIÓN DIGITAL</strong></h5></center>
                                           <p> La investigación sobre espacios en blanco y maneras de hacer un uso más eficiente del espectro radioeléctrico es muy importante debido a que es un recurso cada vez más escaso y los servicios de comunicaciones inalámbricas siguen creciendo.<br/> Se desarrolló esta plataforma de software para conocer y administrar los espacios en blanco de la televisión Digital en una zona, lo cual puede ser de gran ayuda para prestar servicios diferentes en los canales disponibles resultantes.</p>
                                            <p><br/><strong>Autores:</strong><br/>Julian David Rojas Gutierrez<br/>Kristian Dario Cifuentes Vera<br/><br/><strong>Tutor:</strong><br/> PhD.Luis Fernando Pedraza
                                            </p>
                                                                
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
        </div>
    </form>
</body>
</html>
