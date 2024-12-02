<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="Public/css/estilos.css" rel="stylesheet" />
<title >Espacios en Blanco TDT</title>
    
<!---Bootstrap y jquery -->
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css"/>
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

</head>
<body >
 

<!---antiguo header -->
 <%--<div class="page-header" style="margin-top:0px;padding-top:9px ;margin-bottom:0px;background-color:#0c3c60">
<div class="row" style="margin-left:20px">
    <div class="col-md-2" >
        <center>
        <img style=" width: auto; height: 90px;" src="UD.png"/>
            </center>
        </div>
        <div class="col-md-10" >
  <h1  style=" margin-top: 10px"><strong style="color:#7dcada ">Uso de espacios en blanco de la televisión digital<br/><small style="color:#ffffff">Universidad Distrital Francisco Jose de Caldas</small></strong></h1>
    </div>
    </div>
       </div>--%>
<!---End antiguo header -->

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
    
    <!---End Nuevo header-->

<form id="form1" runat="server">
    <!---Row -->
    <div class="row" style="padding-left:20px;padding-top: 50px;padding-bottom:50px; background-image:url(Background2.png)">  
        <!--col-md-4 -->
         <div class="col-md-4" style="color:#0c3c60" >
             <div class="row" style="margin-left: 5px;">
             <span id="spnDevices" style="color:#0c3c60"><strong>Seleccionar un Dispositivo </strong></span>
                 </div>
             <select id="ddlDevices" class="form-control"  style="text-overflow: clip; color:#6ea4ca" name="Devices" onchange="GetDeviceById()">
             <option id="opSelect1" value="0" selected="selected">Seleccionar</option>
             </select>             
             <br />
              <div class="row" style="margin-left:5px" >
             <span id="info"><strong>INFORMACION DE DISPOSITIVO</strong></span>
             <div class="row" style="padding-top:5px" >
             </div></div>
             <div class="row" style="margin-left:5px" >
             <span id="spnID"><strong>Id:</strong></span>
             <span id="spnIDValue"></span>
             </div>
             <div class="row" style="margin-left:5px">
             <span id="spnName"><strong>Nombre:</strong></span>
             <span id="spnNameValue"></span>
             </div>
             <div class="row" style="margin-left:5px">
             <span id="spnDescription"><strong>Descripción:</strong></span>
             <span id="spnDescriptionValue"></span>
             </div>
        
             <div class="row" style="margin-left:5px">
             <span id="spnCanalaes"><strong>Canal Asignado:</strong></span>
             <span id="spnCanalesValue"></span>
             </div>
                
             <div class="row" style="margin-left:5px">
             <span id="spnLatitud"><strong>Latitud:</strong></span>
             <span id="spnLatitudValue"></span>
             </div>
             <div class="row" style="margin-left:5px">
             <span id="spnLongitud"><strong>Longitud:</strong></span>
             <span id="spnLongitudValue"></span>
            </div>
             <button id="btnEdit" type="button" class="btn btn-info" onclick="EditDevice();"  style="margin-top:20px; margin-bottom:20px "><span id="spnEdit">Editar</span></button>   
              
             <div class="row" style="margin-left:5px" >
             <span id="info2"><strong>DATOS DE TRANSMISIÓN</strong></span>
             <div class="row" style="padding-top:5px" >
             </div></div>
             <div class="row" style="margin-left:5px">
             <span id="spnGain"><strong>Ganancia de antena de transmisión (dBi):</strong></span>
             <span id="spnGainValue"></span>
            </div>
             <div class="row" style="margin-left:5px">
             <span id="spnGain2"><strong>Ganancia de antena de recepción (dBi):</strong> 5</span>
             <span id="spnGainValue2"></span>
            </div>
              <div class="row" style="margin-left:5px">
             <span id="spnPowerFactor"><strong>Potencia de transmisión (dBm):</strong></span>
             <span id="spnPowerFactorValue"></span>
            </div>
              <div class="row" style="margin-left:5px">
             <span id="spnHigh"><strong>Altura de antena de transmisión (m):</strong></span>
             <span id="spnHighValue"></span>
            </div>


                                    

        </div> 

          <div class="col-md-8"> 
                          <div class="modal-fade" id="ModalMap" tabindex="-1" role="dialog" >
                            <div class="modal-dialog" role="document" style="margin:0px auto; position:static">
                                <div class="modal-content">
                                    <div class="modal-body" style="background-color:#d2e0eb">
                                        <div class="from-horizontal">
                                           
                                            <div id="ModalMapPreview" style="width:100%; height:400px;">
                                            </div>
                                            <div class="clearfix">&nbsp;</div>

                                             <button id="btnNewDevice" type="button" class="btn btn-primary" onclick="NewDevice();"  style="margin-top:20px"><span id="spnNewDevice"> Nuevo Dispositivo</span></button>
                                                                       
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                     </div>
       
      
  </div>
    <!---End Row -->
    <div class="page-footer" style="margin-top:0px;padding-top:9px ;margin-bottom:0px;background-color:#6ea4ca">
          <center>
                   <h1  style=" margin-top: 10px; margin-bottom:17px; color:#ffffff; font-size:20px">ESPECIFICACIONES</h1>
                   </center>
        <div class="row" style="margin-left:20px;padding-bottom:40px">
               <div class="col-md-6" >
                   <center>
                        <img class="center-block" src="CH.jpg"style="height:100px" alt="CHANNEL"  onclick= "openVentanaBTS();"/>
                        <button id="btn-BTS" type="button" class="btn-link" onclick="openVentanaBTS();" style="color:#0c3c60;font-weight:600; padding-top:20px">Canales</button>   
                               </center>
                    </div>
            <div class="col-md-6" >
                <center>
                    <img class="center-block" src="PDR.jpg" style="height:100px" alt="Pattern" onclick= "openVentanaRDS();"/>
                   <button id="btn-RDS" type="button" class="btn-link" onclick="openVentanaRDS();" style="color:#0c3c60; font-weight:600; padding-top:20px">Patrones de Radiación</button>   
            
                   </center>
                    </div>
    </div>
          </div>               
                    
</form>

    <div class="ventanaBTS" style="width:100%; height:100%; color:#fff; position:fixed; background-image:url(bg-modal.png); top:0; left:0; display:none">
      
       <div class="formBTS" style="width:800px; height:650px; background-color:#7dcada;padding:25px; color:#000000; top:50%;left:50%; position:absolute;margin-left:-400px;margin-top:-325px;">
           <div class="cerrar" style="color:red; font-weight:900; text-align:right" ><a href="javascript:closeVentanaBTS();" style="color:white;">X</a></div>
           <form style="color:#0c3c60" > <center><h3 style="color:#0c3c60"> Canales</h3><hr style="width:75%;color:#89f4eb; "/></center>
               <p>La banda de frecuencia de la televisión digital (470 MHz y 698 MHz) tiene 38 canales, enumerados desde el 14 al 51 cada uno con un ancho de 6MHz.</p>
              <center>
                <img class="center-block" src="ch tbl.jpg" style="height:350px" alt="Tbl" />
                  </center>
               <p><br/>Las estaciones de TDT de Suba y Santa Librada utilizan los canales: 14 al 24, 27 al 30, 37, 41 al 47, 49, 51</p>

               </form>
       </div>
       </div>
    <div class="ventanaRDS" style="width:100%; height:100%; color:#fff; position:fixed; background-image:url(bg-modal.png); top:0; left:0; display:none">
      
       <div class="formRDS" style="width:800px; height:650px;color:#0c3c60; background-color:#7dcada;padding:25px; color:#000000; top:50%;left:50%; position:absolute;margin-left:-400px;margin-top:-325px;">
           <div class="cerrar" style="color:red; font-weight:900; text-align:right" ><a href="javascript:closeVentanaRDS();" style="color:white;">X</a></div>
           <form style="color:#0c3c60"> <center><h3 style="color:#0c3c60">Patrones de Radiación</h3><hr style="width:75%;color:#89f4eb; "/></center>
               <p>
                   Los RDS utilizan dos patrones de radiación uno direccional y otro omnidireccional.
               </p>
              <p> El patrón de radiación direccional esta descrito a continuación por su ecuación matemática y por la figura resultante:</p>
            <center>
                <div class="row">
                    <div class="col-md-6">
                <img class="center-block" src="patron direccional.jpg" />
                        </div>
                    <div class="col-md-6">
                <img class="center-block" src="patron direccional f.jpg" style="height:157px" />
                    </div></div>
                  </center> 
               <p> <br/>El patrón de radiación omnidireccional esta descrito a continuación por su ecuación matemática y por la figura resultante:</p>
           <center>
                <div class="row">
                    <div class="col-md-6">
                <img class="center-block" src="patron direccional2.jpg" />
                        </div>
                    <div class="col-md-6">
                <img class="center-block" src="patron direccional f2.jpg" style="height:172px" />
                    </div></div>
                  </center> 
           </form>
       </div>
       </div>




<script type="text/javascript">

    function openVentanaBTS() {

        $(".ventanaBTS").slideDown("slow");
    }
    function closeVentanaBTS() {

        $(".ventanaBTS").slideUp("fast");
    }
    function openVentanaRDS() {

        $(".ventanaRDS").slideDown("slow");
    }
    function closeVentanaRDS() {

        $(".ventanaRDS").slideUp("fast");
    }

    $(document).ready(function(){
        $(window).scroll(function() {
            if ($(this).scrollTop() > 0) {
                $('header').addClass('header2');
                $('displayed').addClass('diplayed2');
            }
            else {
                $('header').removeClass('header2');
                $('displayed').removeClass('displayed2');
            }
        });
    });


        $(document).ready(function () {


            var stavanger = new google.maps.LatLng(58.983991, 5.734863);
            var amsterdam = new google.maps.LatLng(52.395715, 4.888916);
            var london = new google.maps.LatLng(51.508742, -0.120850);
            var otro = new google.maps.LatLng(52.508742, -0.120850);

            var map = new google.maps.Map(document.getElementById('ModalMapPreview'), {
                zoom: 10,
                center: new google.maps.LatLng(4.579483322960404, -74.15749985784913),//4.624335, -74.063644.
                mapTypeId: google.maps.MapTypeId.ROADMAP //SATELITE, HYBRID, ROADMAP, TERRAIN
            });


            var myTrip = [stavanger, amsterdam, london, stavanger];
            var flightPath = new google.maps.Polygon({
                path: myTrip,
                strokeColor: "#0000FF",
                strokeOpacity: 0.8,
                strokeWeight: 2,
                fillColor: "#0000FF",
                fillOpacity: 0.1
            });

            flightPath.setMap(map);

            var infowindow = new google.maps.InfoWindow();
            var deviceMarker = "RDS.png";
            var antenaMarker = "bts2.png";
            var iconSelect = "";

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "/Default2.aspx/GetDevices",
                data: "{}",
                dataType: "json",
                success: function (data) {

                    var lankanListArray = JSON.parse(data.d);
                  
                    $.each(lankanListArray, function (key, value) {
                        $("#ddlDevices").append($("<option></option>").val(value.Id).html(value.Name));

                      
                        if (/NA/.test(value.Chanel)) {
                            iconSelect = antenaMarker;
                        } else
                        {
                            iconSelect = deviceMarker;
                        }

                        var marker, i;
                       
                            marker = new google.maps.Marker({
                                position: new google.maps.LatLng(value.Latitude, value.Longitude),
                                map: map,
                                icon: iconSelect
                            });

                            google.maps.event.addListener(marker, 'click', (function (marker, i) {
                                return function () {
                                    infowindow.setContent(value.Name);
                                    infowindow.open(map, marker);
                                }
                            })(marker, i));
                        

                    });

                  
                },
                error: function (Result) {
                    //alert("Error");
                }
            });

            

    });


        function PrintLocationsMaps(lat,lng)
        {
           

            var stavanger = new google.maps.LatLng(58.983991, 5.734863);
            var amsterdam = new google.maps.LatLng(52.395715, 4.888916);
            var london = new google.maps.LatLng(51.508742, -0.120850);
            var otro = new google.maps.LatLng(52.508742, -0.120850);

        
            var map = new google.maps.Map(document.getElementById('ModalMapPreview'), {
                zoom: 15,
                center: new google.maps.LatLng(lat, lng),//"4.624335", "-74.063644".
                mapTypeId: google.maps.MapTypeId.ROADMAP //SATELITE, HYBRID, ROADMAP, TERRAIN
            });

            var myTrip = [stavanger, amsterdam, london, stavanger];
            var flightPath = new google.maps.Polygon({
                path: myTrip,
                strokeColor: "#0000FF",
                strokeOpacity: 0.8,
                strokeWeight: 2,
                fillColor: "#0000FF",
                fillOpacity: 0.1
            });

            flightPath.setMap(map);
        

            var infowindow = new google.maps.InfoWindow();
        
            var deviceMarker = "RDS.png";
            var antenaMarker = "bts2.png";
            var iconSelect = "";

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "/Default2.aspx/GetDevices",
                data: "{}",
                dataType: "json",
                success: function (data) {

                    var lankanListArray = JSON.parse(data.d);

                    $.each(lankanListArray, function (key, value) {
                        //$("#ddlDevices").append($("<option></option>").val(value.name).html(value.name));

                        if (/NA/.test(value.Chanel)) {
                            iconSelect = antenaMarker;
                        } else {
                            iconSelect = deviceMarker;
                        }

                        var marker, i;

                        marker = new google.maps.Marker({
                            position: new google.maps.LatLng(value.Latitude, value.Longitude),
                            map: map,
                            icon: iconSelect
                        });

                        google.maps.event.addListener(marker, 'click', (function (marker, i) {
                            return function () {
                                infowindow.setContent(value.Name);
                                infowindow.open(map, marker);
                            }
                        })(marker, i));

                    });
                },
                error: function (Result) {
                    //alert("Error");
                }
            });

        }

        function GetDeviceById() {
            var device = document.getElementById('ddlDevices').selectedIndex.toString() == "0" ? "" : $('#ddlDevices :selected').val();
            var lat = "";
            var lng = "";
      
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "/Default2.aspx/GetDeviceById",
                data: '{id: "' + device + '" }',      
                dataType: "json",
                success: function (data) {

                    var lankanListArray = JSON.parse(data.d);

                    $.each(lankanListArray, function (key, value) {

                        if (/NA/.test(value.Chanel)) {

                            $('#btnEdit').prop("disabled", true);
                         

                        } else {

                            $('#btnEdit').prop("disabled", false);
                        }


                        $("#spnIDValue").html(value.Id);
                        $("#spnNameValue").html(value.Name);
                        $("#spnDescriptionValue").html(value.Description);
                       
                        $("#spnCanalesValue").html(value.Chanel);
                        $("#spnLatitudValue").html(value.Latitude);
                        $("#spnLongitudValue").html(value.Longitude);
                        $("#spnGainValue").html(value.Gain);
                        $("#spnPowerFactorValue").html(value.PowerFactor);
                        $("#spnHighValue").html(value.High);
                            
                        
                        PrintLocationsMaps(value.Latitude, value.Longitude);
                    });


                },
                error: function (Result) {
                    //alert("Error");
                }
            });

         
        }

        ///////////////
        $('#ModalMap').on('shown.bs.modal', function () {
            $('#ModalMapPreview').locationpicker('autosize');
        });

        function NewDevice() {
           
            window.location.href = '/NewDevice.aspx?latitud=4.624335&longitud=-74.063644';
            
        }

        function EditDevice() {

              var device = document.getElementById('ddlDevices').selectedIndex.toString() == "0" ? "" : $('#ddlDevices :selected').val();
              if (device != '') {
                  window.location.href = 'EditDevices.aspx';
              }
              else
              {

                  alert("Seleccione un Dispositivo para editar");
              }
              

        }
     
        function DeviceList() {

            var locations = "";
            var i = 0;
            var locationsParce = "";
                            
                                 

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "/Default2.aspx/GetDevices",
                data: "{}",
                dataType: "json",
                success: function (data) {

                    var lankanListArray = JSON.parse(data.d);
                    
                    locations="[";
                    $.each(lankanListArray, function (key, value) {
                        i++;
                        locations = locations + "['" + value.Name + "'," + value.Latitude + "," + value.Longitude + ","+i+"],";
                                                
                    });

                    locations = locations + "]";

                    locationsParce = locations.replace("],]", "]]");

                },
                error: function (Result) {
                    //alert("Error");
                }
            });
            var res = locationsParce.split(" ");
            return res;
        }

</script>



<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCfIeL5pi2G_CsF21w0FFZrmO4sEEl8So8&callback=myMap"></script>  
<script src="Public/js/locationpicker.jquery.js"></script> 

      
</body>
<!--complementos marcadores -->
</html>
