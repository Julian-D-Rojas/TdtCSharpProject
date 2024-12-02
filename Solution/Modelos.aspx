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
                                <div class="modal-content" style="width:150%; top:50%;left:50%;margin-left:-75%">
                                    <div class="modal-body" style="background-color:#d2e0eb">
                                        <div class="from-horizontal">
                                           
                                            <center>
                                          <h3 style="color:#0c3c60"> Modelos de Propagación</h3><hr style="width:75%;color:#6ea4ca; "/>
                                            </center>
                                            <div class="row">
                    <div class="col-md-4">
                     <center>   <h5><strong> MODELO OKUMURA-HATA</strong></h5></center>
                        <p>    Este modelo es aplicable para frecuencias en el rango de 150 MHz a los 1500 MHz, distancias de 1 Km a 100 Km y para alturas de la antena de 30 m a 1000 m. A continuación, se muestra la ecuación: </p>                
                                       
                <img src="oh1.jpg" style="width:92%" />

                     <p> <br/>   Donde:<br/> fc  es la frecuencia de operación. (MHz)<br/> hte es la altura de la antena de la estación base con un rango de 30 a 200 metros. (m)<br/> hre es la altura de la antena receptora con un rango de 1 a 10 metros. (m)<br/> d es la distancia entre el transmisor y el receptor. (Km) <br/>a(hre) es el factor de corrección de altura para la antena receptora. </p>
                        <p> <br/>Para un entorno urbano denso. (Ciudades grandes) </p>
                        <img src="oh2.jpg" style="width:92%" />
                    </div>

            <div class="col-md-4">
                     <center>   <h5><strong> MODELO WALFISCH-BERTONI</strong></h5></center>
                        <p>    Este modelo tiene en cuenta las pérdidas producidas debido a la altura de los edificios y la reducción del campo incidente sobre las terrazas de edificios debido a la difracción previa.<br/>Este modelo depende de tres tipos de pérdidas.<br/><br/>Pérdidas de espacio libre: </p>
                <img src="wb1.jpg" style="width:82%" />

                     <p> <br/>  Pérdidas por difracción y de propagación sobre los edificios</p>
                    <img src="wb2.jpg" style="width:92%" />
                         <p> <br/>Donde:<br/> fc(MHz) es la frecuencia de operación, R(Km) es la distancia entre las antenas, b(m) es la separación media de los edificios de centro a centro y hre, hte y h (m) son las alturas del receptor, la estación base y la media de los edificios respectivamente.<br/>La expresión de pérdidas totales Lw(dB) de este modelo está dada por la ecuación: </p>
                        <img src="wb3.jpg" style="width:42%" />
                    </div>
                
                    <div class="col-md-4">
                     <center>   <h5><strong> MODELO COST 231 WALFISCH IKEGAMI</strong></h5></center>
                        <p>   Este modelo toma en cuenta factores como el ángulo de incidencia del rayo directo respecto a la calle y los factores de corrección para las pérdidas por difracción.<br/> Las pérdidas totales de este modelo se hallan según la ecuación:</p>
                            <img src="cw1.jpg" style="width:92%" />

                     <p> <br/>  Pérdidas azotea a nivel de la calle Lrts(dB) están descritas por la ecuación:</p>
                    <img src="cw2.jpg" style="width:82%" />
                         <p> <br/>Donde:<br/> w(m) es el ancho de la calle, ∆hm(m) es la diferencia entre la altura media de los edificios y la altura de la antena del móvil, Lori define las pérdidas debidas al ángulo de incidencia del rayo directo respecto a la calle y se describen en la ecuación:</p>
                             <img src="cw3.jpg" style="width:92%" />
                      <p>  Donde ∅ es el ángulo de incidencia respecto a la calle.<br/>Las pérdidas por difracción en múltiples pantallas Lmsd (dB) son calculadas como se muestra en la ecuación:</p>
                         <img src="cw4.jpg" style="width:95%" />
                       <p> En esta expresión b(m) es la distancia centro a centro entre los edificios, d(km) es la separación entre transmisor y receptor, Lhte(dB) son las pérdidas debido a la altura de la antena de la estación base y Ka(dB) representa el incremento de las pérdidas para las estaciones base que están por debajo de las azoteas de los edificios adyacentes  y están descritas por las siguientes ecuaciones:</p> 
                   <img src="cw5.jpg" style="width:95%" />
                       <p> Donde ∆hte=hte - hroof, hte(m) es la altura de la estación base y hroof(m) es la altura media de las edificaciones del entorno. El término Kd(dB) está relacionado con el control de la dependencia entre las pérdidas por difracción en múltiples pantallas y la distancia, mientras que el término Kf(dB) controla la dependencia de dichas pérdidas con la frecuencia de operación, se calculan mediante las ecuaciones:</p>
                        <img src="cw6.jpg" style="width:88%" />
                    </div>

                    </div>
                                               
                                            </div>
                                    </div>
                                </div>
                            </div>
                        </div>
        
    </form>
</body>
</html>
