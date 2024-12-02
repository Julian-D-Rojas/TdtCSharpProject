<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditDevices.aspx.cs" Inherits="EditDevices" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Editar Dispositivo</title>
    <link href="Public/css/estilos.css" rel="stylesheet" />
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css"/>
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">

 <%--<div class="page-header" style="margin-top:0px;padding-top:9px ;margin-bottom:0px;background-color:#0c3c60">
    <div class="row" style="margin-left:20px">
  <h1><strong style="color:#7dcada">Editar Dispositivo</strong></h1>
       </div>
     </div>--%>
        <header class="header" style="background-color:#0c3c60; margin-bottom:0px; padding-bottom:20px;position:static">
        <div class ="wrapper">
        <div class="logo">
            <img class="displayed" src="Public/image/200px-Escudo_UD.svg.png"   />
           
        </div>
        <div> <h1 style="color:#d1f4eb;  text-align:center">EDITAR DISPOSITIVO</h1>
        <nav style="margin-top:22px">
            <a href="Default2.aspx">Inicio</a>
            <a href="Modelos.aspx">Modelos de Propagación</a>
            <a href="RDS.aspx">RDS</a>
          <a href="Autores.aspx">Información Adicional</a>
        </nav>
        </div>
        </div>
        </header>

   <!--container -fluid -->
        <div class="container-fluid"> 
             <!--Row-->
             <div class="row" style="padding-left:20px;padding-top: 50px;padding-bottom:50px; background-image:url(Background2.png)"> 
               <div class="col-md-4" style=" color:#0c3c60"> 
                 <div class="row" style="margin-left:5px">
                     <div class="col-md-12" style="margin-top:20px"> 
                      <span id="spnNote" style="color:orangered"><strong>Primero fije una ubicación antes de ingresar cualquier dato</strong></span>
                     </div>
                  </div>
                <div class="row" style="margin-left:5px">
                <div class="col-md-6" style="margin-top:20px"> 
                 <span id="spnLatitud"><strong>Latitud:</strong></span>
                 <input type="text" style="color:#6ea4ca" class="col-sm-4 form-control" id="txtLat" runat="server" readonly ="true"/> 
                  </div>
                 <div class="col-md-6" style="margin-top:20px"> 
                 <span id="spnLongitud"><strong>Longitud:</strong></span>
                 <input type="text" style="color:#6ea4ca" class="col-sm-4 form-control" id="txtLong" runat="server" readonly="true" />    
                      </div>    
                 </div>
             
                 <div class="row" style="margin-left:5px">
                      <div class="col-md-12" > 
                       <button id="btnEditLocation" type="button" class="btn btn-info" onclick="EditLocation();"  style="margin-top:20px ; float:right"><span id="editLocation">Editar locación</span></button>   
                      </div>
                 </div>
                       <br /> 
                 <div class="row" style="margin-left:5px">
                      <div class="col-md-6" > 
                       <span id="spnName"><strong>Nombre:</strong></span>                    
                       <input type="text" style="color:#6ea4ca" class="col-sm-4 form-control" id="txtName" runat="server" />     
                      </div>
                     <div class="col-md-6" > 
                       <span id="spnDescription"><strong>Descripción:</strong></span>
                       <input type="text"  style="color:#6ea4ca" class="form-control" id="txtDescription" runat="server" />
                     </div>
                 </div>
               
                              
                 <div class="row" style="margin-left:5px">
                     <br /> 
                      <div class="col-md-6" > 
                          <span id="spnMethod"><strong>Seleccionar un Modelo:</strong></span>
                            <select id="ddlMethod" class="form-control"  style="text-overflow: clip; color:#6ea4ca" name="Channels" onchange="ConsultRange()" >                           
                            <option id="opSelectMethod2" value="1" selected="selected">Okumura Hata</option>
                            <option id="opSelectMethod3" value="2" >Walfisch-Bertoni</option>
                            <option id="opSelectMethod4" value="3" >Cos231 Walfisch Ikegami</option>
                            </select> 
                        </div>
                    
                        <div class="col-md-6" > 
                        <span id="spnPattern"><strong>Seleccionar un patrón de radiación:</strong></span>
                            <select id="ddlPattern" class="form-control"  style="text-overflow: clip;color:#6ea4ca"" name="Channels" onchange="ConsultRange()" >
                            <option id="opSelectPattern" value="1" selected="selected">Direccional</option>
                            <option id="opSelectPattern1" value="2" >Omnidireccional</option>
                      
                            </select>
                         </div>
                      </div>
                  
                  <div class="row" style="margin-left:5px"> 
                       <div class="col-md-6" style="margin-top:20px">             
                         <span id="spnDevices"><strong>Canales Disponibles</strong></span>
                         <select id="ddlChannels" class="form-control"  style="text-overflow: clip;color:#6ea4ca" name="Channels" >
                         <option id="opSelect1" value="0" selected="selected">Off</option>
                         </select>  
                       </div>
                       <div class="col-md-6" style="margin-top:20px">   
                         <button id="btnConsult" type="button" class="btn btn-default" onclick="ConsultRange();"  style="margin-top:20px ; float:right ; width:100px"><span id="spnApply">Refrescar</span></button>   
                       </div>
                      
                  </div>
                   <hr />
                   <div class="row" style="margin-left:5px">
                      <div class="col-md-12" style="margin-top:5px">                       
                        <button id="btnCreate" type="button" class="btn btn-primary" onclick="UpdateDevice();"  style="margin-top:20px ; float:right ; width:100px"><span id="spnEdit">Actualizar</span></button>   
                       </div>
                   </div>
                </div>
                  
              <div class="col-md-8"> 
                          <div class="modal-fade" id="ModalMap" tabindex="-1" role="dialog" >
                            <div class="modal-dialog" role="document" style="margin:0px auto; position:static">
                                <div class="modal-content">
                                    <div class="modal-body" style="background-color:#d2e0eb">
                                        <div class="from-horizontal">                                           
                                             <div id="ModalMapPreview" style="width:100%;height:400px"></div>  
                                            <div class="clearfix">&nbsp;</div>                                         
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                  <div class="row" style="margin-left:5px">
                      <div class="col-md-12" style="margin-top:13px;padding-right:80px ;">                       
                         </div>
                   </div>
                </div>                  
              </div>         
            
             <!-- End-Row-->          
      </div> 
      <!--end container - fluid -->
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


    $(document).ready(function ()
     {
 
              var device = '<%= HttpContext.Current.Session["DeviceName"].ToString().ToLower() %>';

              var infowindow = new google.maps.InfoWindow();
              var deviceMarker = "RDS.png";
              var antenaMarker = "bts2.png";
              var iconSelect = "";
              
             
              
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "/Default2.aspx/GetDeviceById",
                  data: '{id: "' + device + '" }',
                  dataType: "json",
                  success: function (data) {

                      var lankanListArray = JSON.parse(data.d);

                      $.each(lankanListArray, function (key, value) {
                          var map = new google.maps.Map(document.getElementById('ModalMapPreview'), {
                              zoom: 15,
                              center: new google.maps.LatLng(value.Latitude, value.Longitude),//4.624335, -74.063644.
                              mapTypeId: google.maps.MapTypeId.ROADMAP //SATELITE, HYBRID, ROADMAP, TERRAIN
                          });
                        
                          document.getElementById("txtName").value = value.Name;
                          document.getElementById("txtDescription").value = value.Description;
                          document.getElementById("txtLat").value = value.Latitude;
                          document.getElementById("txtLong").value = value.Longitude;
                          document.getElementById("gainh").value = value.Gain;
                          document.getElementById("pwfactorh").value = value.PowerFactor;
                          document.getElementById("highh").value = value.High;
                  
                          $("#ddlMethod").val(value.Model);
                          $("#ddlPattern").val(value.Pattern);
                         

                          if (value.canales == "NA")
                          {
                              //document.getElementById("txtCanales").readOnly = true;
                              $('#ddlChannels').prop("disabled", true);
                              $('#ddlChannels').prop('selectedIndex', value.Chanel);
                              $('#btnEditLocation').prop("disabled", true);
                          }

                       
                          if (/ESTACIÓN/.test(value.name)) {
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

                        
                          ConsultRange();

                          $("#ddlChannels").val(value.Chanel);
                      });


                  },
                  error: function (Result) {
                      //alert("Error");
                  }
              });
              
     });
     function myMap(lat, long, name) { }


    function myMap1(lat, long, name) {
    var lati = [];
    
    lati = Grafiquinha();
        lati.success(function (data) {
            puntosLat = JSON.parse(data.d);
            console.log(strtofloat(puntosLat[0]));

            //Inicio Modelo 1

             var myCenterDevice = new google.maps.LatLng(lat, long);
             var mapOptions = { center: myCenterDevice, zoom: 15 };
             var mapCanvas = document.getElementById("ModalMapPreview");
             var map = new google.maps.Map(mapCanvas, {
                 zoom: 15,
                 center: new google.maps.LatLng(lat, long),
             });


                 // Graficadinamica
        var PC = new google.maps.LatLng(lat, long);
        var Pa0 = new google.maps.LatLng(strtofloat(puntosLat[0]), strtofloat(puntosLat[1]));
        var Pa1 = new google.maps.LatLng(strtofloat(puntosLat[2]), strtofloat(puntosLat[3]));
        var Pa2 = new google.maps.LatLng(strtofloat(puntosLat[4]), strtofloat(puntosLat[5]));
        var Pa3 = new google.maps.LatLng(strtofloat(puntosLat[6]), strtofloat(puntosLat[7]));
        var Pa4 = new google.maps.LatLng(strtofloat(puntosLat[8]), strtofloat(puntosLat[9]));
        var Pa5 = new google.maps.LatLng(strtofloat(puntosLat[10]), strtofloat(puntosLat[11]));
        var Pa6 = new google.maps.LatLng(strtofloat(puntosLat[12]), strtofloat(puntosLat[13]));
        var Pa7 = new google.maps.LatLng(strtofloat(puntosLat[14]), strtofloat(puntosLat[15]));
        var Pa8 = new google.maps.LatLng(strtofloat(puntosLat[16]), strtofloat(puntosLat[17]));
        var Pa9 = new google.maps.LatLng(strtofloat(puntosLat[18]), strtofloat(puntosLat[19]));
        var Pa10 = new google.maps.LatLng(strtofloat(puntosLat[20]), strtofloat(puntosLat[21]));
        var Pa11 = new google.maps.LatLng(strtofloat(puntosLat[22]), strtofloat(puntosLat[23]));
        var Pa12 = new google.maps.LatLng(strtofloat(puntosLat[24]), strtofloat(puntosLat[25]));
        var Pa13 = new google.maps.LatLng(strtofloat(puntosLat[26]), strtofloat(puntosLat[27]));
        var Pa14 = new google.maps.LatLng(strtofloat(puntosLat[28]), strtofloat(puntosLat[29]));
        var Pa15 = new google.maps.LatLng(strtofloat(puntosLat[30]), strtofloat(puntosLat[31]));
        var Pa16 = new google.maps.LatLng(strtofloat(puntosLat[32]), strtofloat(puntosLat[33]));
        var Pa17 = new google.maps.LatLng(strtofloat(puntosLat[34]), strtofloat(puntosLat[35]));
        var Pa18 = new google.maps.LatLng(strtofloat(puntosLat[36]), strtofloat(puntosLat[37]));
        var Pa19 = new google.maps.LatLng(strtofloat(puntosLat[38]), strtofloat(puntosLat[39]));
        var Pa20 = new google.maps.LatLng(strtofloat(puntosLat[40]), strtofloat(puntosLat[41]));
        var Pa21 = new google.maps.LatLng(strtofloat(puntosLat[42]), strtofloat(puntosLat[43]));
        var Pa22 = new google.maps.LatLng(strtofloat(puntosLat[44]), strtofloat(puntosLat[45]));
        var Pa23 = new google.maps.LatLng(strtofloat(puntosLat[46]), strtofloat(puntosLat[47]));
        var Pa24 = new google.maps.LatLng(strtofloat(puntosLat[48]), strtofloat(puntosLat[49]));
        var Pa25 = new google.maps.LatLng(strtofloat(puntosLat[50]), strtofloat(puntosLat[51]));
        var Pa26 = new google.maps.LatLng(strtofloat(puntosLat[52]), strtofloat(puntosLat[53]));
        var Pa27 = new google.maps.LatLng(strtofloat(puntosLat[54]), strtofloat(puntosLat[55]));
        var Pa28 = new google.maps.LatLng(strtofloat(puntosLat[56]), strtofloat(puntosLat[57]));
        var Pa29 = new google.maps.LatLng(strtofloat(puntosLat[58]), strtofloat(puntosLat[59]));
        var Pa30 = new google.maps.LatLng(strtofloat(puntosLat[60]), strtofloat(puntosLat[61]));
        var Pa31 = new google.maps.LatLng(strtofloat(puntosLat[62]), strtofloat(puntosLat[63]));
        var Pa32 = new google.maps.LatLng(strtofloat(puntosLat[64]), strtofloat(puntosLat[65]));
        var Pa33 = new google.maps.LatLng(strtofloat(puntosLat[66]), strtofloat(puntosLat[67]));
        var Pa34 = new google.maps.LatLng(strtofloat(puntosLat[68]), strtofloat(puntosLat[69]));
        var Pa35 = new google.maps.LatLng(strtofloat(puntosLat[70]), strtofloat(puntosLat[71]));
        var Pa36 = new google.maps.LatLng(strtofloat(puntosLat[72]), strtofloat(puntosLat[73]));
        var Pa37 = new google.maps.LatLng(strtofloat(puntosLat[74]), strtofloat(puntosLat[75]));
        var Pa38 = new google.maps.LatLng(strtofloat(puntosLat[76]), strtofloat(puntosLat[77]));
        var Pa39 = new google.maps.LatLng(strtofloat(puntosLat[78]), strtofloat(puntosLat[79]));
        var Pa40 = new google.maps.LatLng(strtofloat(puntosLat[80]), strtofloat(puntosLat[81]));
        var Pa41 = new google.maps.LatLng(strtofloat(puntosLat[82]), strtofloat(puntosLat[83]));
        var Pa42 = new google.maps.LatLng(strtofloat(puntosLat[84]), strtofloat(puntosLat[85]));
        var Pa43 = new google.maps.LatLng(strtofloat(puntosLat[86]), strtofloat(puntosLat[87]));
        var Pa44 = new google.maps.LatLng(strtofloat(puntosLat[88]), strtofloat(puntosLat[89]));
        var Pa45 = new google.maps.LatLng(strtofloat(puntosLat[90]), strtofloat(puntosLat[91]));
        var Pa46 = new google.maps.LatLng(strtofloat(puntosLat[92]), strtofloat(puntosLat[93]));
        var Pa47 = new google.maps.LatLng(strtofloat(puntosLat[94]), strtofloat(puntosLat[95]));
        var Pa48 = new google.maps.LatLng(strtofloat(puntosLat[96]), strtofloat(puntosLat[97]));
        var Pa49 = new google.maps.LatLng(strtofloat(puntosLat[98]), strtofloat(puntosLat[99]));
        var Pa50 = new google.maps.LatLng(strtofloat(puntosLat[100]), strtofloat(puntosLat[101]));
        var Pa51 = new google.maps.LatLng(strtofloat(puntosLat[102]), strtofloat(puntosLat[103]));
        var Pa52 = new google.maps.LatLng(strtofloat(puntosLat[104]), strtofloat(puntosLat[105]));
        var Pa53 = new google.maps.LatLng(strtofloat(puntosLat[106]), strtofloat(puntosLat[107]));
        var Pa54 = new google.maps.LatLng(strtofloat(puntosLat[108]), strtofloat(puntosLat[109]));
        var Pa55 = new google.maps.LatLng(strtofloat(puntosLat[110]), strtofloat(puntosLat[111]));
        var Pa56 = new google.maps.LatLng(strtofloat(puntosLat[112]), strtofloat(puntosLat[113]));
        var Pa57 = new google.maps.LatLng(strtofloat(puntosLat[114]), strtofloat(puntosLat[115]));
        var Pa58 = new google.maps.LatLng(strtofloat(puntosLat[116]), strtofloat(puntosLat[117]));
        var Pa59 = new google.maps.LatLng(strtofloat(puntosLat[118]), strtofloat(puntosLat[119]));
        var Pa60 = new google.maps.LatLng(strtofloat(puntosLat[120]), strtofloat(puntosLat[121]));
        var Pa61 = new google.maps.LatLng(strtofloat(puntosLat[122]), strtofloat(puntosLat[123]));
        var Pa62 = new google.maps.LatLng(strtofloat(puntosLat[124]), strtofloat(puntosLat[125]));
        var Pa63 = new google.maps.LatLng(strtofloat(puntosLat[126]), strtofloat(puntosLat[127]));
        var Pa64 = new google.maps.LatLng(strtofloat(puntosLat[128]), strtofloat(puntosLat[129]));
        var Pa65 = new google.maps.LatLng(strtofloat(puntosLat[130]), strtofloat(puntosLat[131]));
        var Pa66 = new google.maps.LatLng(strtofloat(puntosLat[132]), strtofloat(puntosLat[133]));
        var Pa67 = new google.maps.LatLng(strtofloat(puntosLat[134]), strtofloat(puntosLat[135]));
        var Pa68 = new google.maps.LatLng(strtofloat(puntosLat[136]), strtofloat(puntosLat[137]));
        var Pa69 = new google.maps.LatLng(strtofloat(puntosLat[138]), strtofloat(puntosLat[139]));
        var Pa70 = new google.maps.LatLng(strtofloat(puntosLat[140]), strtofloat(puntosLat[141]));
        var Pa71 = new google.maps.LatLng(strtofloat(puntosLat[142]), strtofloat(puntosLat[143]));
        var Pa72 = new google.maps.LatLng(strtofloat(puntosLat[144]), strtofloat(puntosLat[145]));
       

             var flightPath0 = new google.maps.Polygon({
                 path: [Pa0,Pa1,Pa2,Pa3,Pa4,Pa5,Pa6,Pa7,Pa8,Pa9,Pa10,Pa11,Pa12,Pa13,Pa14,Pa15,Pa16,Pa17,Pa18,Pa19,Pa20,Pa21,Pa22,Pa23,Pa24,Pa25,Pa26,Pa27,Pa28,Pa29,Pa30,Pa31,Pa32,Pa33,Pa34,Pa35,Pa36,Pa37,Pa38,Pa39,Pa40,Pa41,Pa42,Pa43,Pa44,Pa45,Pa46,Pa47,Pa48,Pa49,Pa50,Pa51,Pa52,Pa53,Pa54,Pa55,Pa56,Pa57,Pa58,Pa59,Pa60,Pa61,Pa62,Pa63,Pa64,Pa65,Pa66,Pa67,Pa68,Pa69,Pa70,Pa71,Pa72],
                 strokeColor: "#0000FF",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#0000FF",
                 fillOpacity: 0.1
        });


             // Suba
        var PC = new google.maps.LatLng(lat, long);
        var Pa0= new google.maps.LatLng(4.74335548659456,-73.9466737046473);
        var Pa1= new google.maps.LatLng(4.75448553418307,-73.9479705467613);
        var Pa2= new google.maps.LatLng(4.76512469708644,-73.9517209652059);
        var Pa3= new google.maps.LatLng(4.77486841255424,-73.9575570717719);
        var Pa4= new google.maps.LatLng(4.78348245687787,-73.9648946306319);
        var Pa5= new google.maps.LatLng(4.79095269948214,-73.9730423844449);
        var Pa6= new google.maps.LatLng(4.79746144514068,-73.9813695376023);
        var Pa7= new google.maps.LatLng(4.80336264177492,-73.9893516394942);
        var Pa8= new google.maps.LatLng(4.80910071369387,-73.9966647174072);
        var Pa9= new google.maps.LatLng(4.81510593435922,-74.0032321264398);
        var Pa10= new google.maps.LatLng(4.82171862302198,-74.0091934074467);
        var Pa11= new google.maps.LatLng(4.82907222495834,-74.0148926984837);
        var Pa12= new google.maps.LatLng(4.83710534467567,-74.0207482288665);
        var Pa13= new google.maps.LatLng(4.84547900652217,-74.0272137271506);
        var Pa14= new google.maps.LatLng(4.85367552019723,-74.0346384223348);
        var Pa15= new google.maps.LatLng(4.86105383202795,-74.0432082930755);
        var Pa16= new google.maps.LatLng(4.86693762658106,-74.0529058486121);
        var Pa17= new google.maps.LatLng(4.87074047046606,-74.0635015836658);
        var Pa18= new google.maps.LatLng(4.87205585673894,-74.0745955791988);
        var Pa19= new google.maps.LatLng(4.87076198810651,-74.0856923915425);
        var Pa20= new google.maps.LatLng(4.86698836800689,-74.0962978004074);
        var Pa21= new google.maps.LatLng(4.86113132337411,-74.1060107647163);
        var Pa22= new google.maps.LatLng(4.85376813880359,-74.1145970741281);
        var Pa23= new google.maps.LatLng(4.8455923968392,-74.1220427875163);
        var Pa24= new google.maps.LatLng(4.8372369371295,-74.1285298101401);
        var Pa25= new google.maps.LatLng(4.82922784023831,-74.134411138629);
        var Pa26= new google.maps.LatLng(4.82189002213707,-74.1401299069316);
        var Pa27= new google.maps.LatLng(4.81530026675622,-74.1461150721266);
        var Pa28= new google.maps.LatLng(4.80931849218789,-74.1527058584628);
        var Pa29= new google.maps.LatLng(4.80359940882978,-74.1600352100789);
        var Pa30= new google.maps.LatLng(4.79772345145688,-74.1680418169671);
        var Pa31= new google.maps.LatLng(4.79123552712991,-74.1763876456819);
        var Pa32= new google.maps.LatLng(4.78378544562142,-74.1845565377292);
        var Pa33= new google.maps.LatLng(4.7751868373087,-74.1919094205936);
        var Pa34= new google.maps.LatLng(4.76545745534544,-74.1977721647323);
        var Pa35= new google.maps.LatLng(4.75482768377826,-74.201560346156);
        var Pa36= new google.maps.LatLng(4.74369875854255,-74.2028689840235);
        var Pa37= new google.maps.LatLng(4.73256761359512,-74.2015769353303);
        var Pa38= new google.maps.LatLng(4.7219298619344,-74.1978135239223);
        var Pa39= new google.maps.LatLng(4.71218759073468,-74.1919739540365);
        var Pa40= new google.maps.LatLng(4.70357553877169,-74.1846336920509);
        var Pa41= new google.maps.LatLng(4.69610753010142,-74.1764840199952);
        var Pa42= new google.maps.LatLng(4.68960099917325,-74.1681556117429);
        var Pa43= new google.maps.LatLng(4.68370180916431,-74.1601727082637);
        var Pa44= new google.maps.LatLng(4.6779654428165,-74.1528590617674);
        var Pa45= new google.maps.LatLng(4.6719616224906,-74.1462911484054);
        var Pa46= new google.maps.LatLng(4.66535008542317,-74.1403293400672);
        var Pa47= new google.maps.LatLng(4.65799748764372,-74.1346295260981);
        var Pa48= new google.maps.LatLng(4.64996533034075,-74.1287735977553);
        var Pa49= new google.maps.LatLng(4.64159268935504,-74.1223080514965);
        var Pa50= new google.maps.LatLng(4.63339730989351,-74.1148839179373);
        var Pa51= new google.maps.LatLng(4.62602024035996,-74.1063154501022);
        var Pa52= new google.maps.LatLng(4.62013772515773,-74.0966202612315);
        var Pa53= new google.maps.LatLng(4.61633607490965,-74.0860277995417);
        var Pa54= new google.maps.LatLng(4.61502165784426,-74.0749377342246);
        var Pa55= new google.maps.LatLng(4.61631615886839,-74.0638451109464);
        var Pa56= new google.maps.LatLng(4.62009002223125,-74.0532437124874);
        var Pa57= new google.maps.LatLng(4.62594693765389,-74.0435342116623);
        var Pa58= new google.maps.LatLng(4.63330969040148,-74.0349506052315);
        var Pa59= new google.maps.LatLng(4.64148478762335,-74.0275068101825);
        var Pa60= new google.maps.LatLng(4.6498394650672,-74.021021042595);
        var Pa61= new google.maps.LatLng(4.65784767862663,-74.0151405156271);
        var Pa62= new google.maps.LatLng(4.66518450178662,-74.0094223160386);
        var Pa63= new google.maps.LatLng(4.67177309997838,-74.0034376550165);
        var Pa64= new google.maps.LatLng(4.67775347700395,-73.9968473960631);
        var Pa65= new google.maps.LatLng(4.68347084567088,-73.989518567383);
        var Pa66= new google.maps.LatLng(4.68934471422303,-73.9815123583519);
        var Pa67= new google.maps.LatLng(4.69583018508494,-73.9731665777426);
        var Pa68= new google.maps.LatLng(4.70327754295502,-73.9649971239061);
        var Pa69= new google.maps.LatLng(4.71187335123697,-73.9576428381611);
        var Pa70= new google.maps.LatLng(4.72160013893673,-73.951777727455);
        var Pa71= new google.maps.LatLng(4.73222783678103,-73.9479862725671);
        var Pa72= new google.maps.LatLng(4.74335548659456,-73.9466737046473);


             var flightPath = new google.maps.Polygon({
                 path: [Pa0, Pa1, Pa2, Pa3, Pa4, Pa5, Pa6, Pa7, Pa8, Pa9, Pa10, Pa11, Pa12, Pa13, Pa14, Pa15, Pa16, Pa17, Pa18, Pa19, Pa20, Pa21, Pa22, Pa23, Pa24, Pa25, Pa26, Pa27, Pa28, Pa29, Pa30, Pa31, Pa32, Pa33, Pa34, Pa35, Pa36, Pa37, Pa38, Pa39, Pa40, Pa41, Pa42, Pa43, Pa44, Pa45, Pa46, Pa47, Pa48, Pa49, Pa50, Pa51, Pa52, Pa53, Pa54, Pa55, Pa56, Pa57, Pa58, Pa59, Pa60, Pa61, Pa62, Pa63, Pa64, Pa65, Pa66, Pa67, Pa68, Pa69, Pa70, Pa71, Pa72],
                 strokeColor: "#DF0101",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#DF0101",
                 fillOpacity: 0.1
             });


             // SANTA LIBRADA
        var Pf0= new google.maps.LatLng(4.52008006504514,-73.974749796485);
        var Pf1= new google.maps.LatLng(4.5312109132217,-73.9760384836024);
        var Pf2= new google.maps.LatLng(4.54184904739658,-73.9797979003083);
        var Pf3= new google.maps.LatLng(4.55159226727071,-73.9856332826233);
        var Pf4= new google.maps.LatLng(4.56020563604835,-73.9929695251227);
        var Pf5= new google.maps.LatLng(4.56767510038211,-74.0011155805227);
        var Pf6= new google.maps.LatLng(4.57418303758289,-74.0094408678855);
        var Pf7= new google.maps.LatLng(4.58008345790015,-74.0174211379213);
        var Pf8= new google.maps.LatLng(4.58582082663751,-74.0247325670895);
        var Pf9= new google.maps.LatLng(4.59182543092261,-74.0312985811786);
        var Pf10= new google.maps.LatLng(4.59843757917157,-74.0372587145251);
        var Pf11= new google.maps.LatLng(4.60579068125795,-74.0429570124868);
        var Pf12= new google.maps.LatLng(4.61382329605757,-74.0488115672206);
        var Pf13= new google.maps.LatLng(4.62219639506641,-74.05527592896);
        var Pf14= new google.maps.LatLng(4.63039224432207,-74.0626991616868);
        var Pf15= new google.maps.LatLng(4.63776976268825,-74.0712671174252);
        var Pf16= new google.maps.LatLng(4.64365262878617,-74.0809622402024);
        var Pf17= new google.maps.LatLng(4.64745442700352,-74.0915550377098);
        var Pf18= new google.maps.LatLng(4.64876868810086,-74.1026456786009);
        var Pf19= new google.maps.LatLng(4.64747366538203,-74.1137388680239);
        var Pf20= new google.maps.LatLng(4.64369891486302,-74.1243405601177);
        var Pf21= new google.maps.LatLng(4.6378408088761,-74.1340498847165);
        var Pf22= new google.maps.LatLng(4.63047666203492,-74.1426327658118);
        var Pf23= new google.maps.LatLng(4.62230006598804,-74.1500753365234);
        var Pf24= new google.maps.LatLng(4.61394384928815,-74.1565595070384);
        var Pf25= new google.maps.LatLng(4.60593406353297,-74.1624382139501);
        var Pf26= new google.maps.LatLng(4.59859558483251,-74.1681544832497);
        var Pf27= new google.maps.LatLng(4.59200515604697,-74.1741371447471);
        var Pf28= new google.maps.LatLng(4.58602266076052,-74.1807253029777);
        var Pf29= new google.maps.LatLng(4.58030279273921,-74.1880518274618);
        var Pf30= new google.maps.LatLng(4.57442598820539,-74.1960553876221);
        var Pf31= new google.maps.LatLng(4.56793718158793,-74.2043980127823);
        var Pf32= new google.maps.LatLng(4.56048622758706,-74.2125636729076);
        var Pf33= new google.maps.LatLng(4.55188681402899,-74.2199134771697);
        var Pf34= new google.maps.LatLng(4.54215675609382,-74.2257735062977);
        var Pf35= new google.maps.LatLng(4.53152649323845,-74.2295595363429);
        var Pf36= new google.maps.LatLng(4.52039730214888,-74.2308667444369);
        var Pf37= new google.maps.LatLng(4.50926613313484,-74.2295740652315);
        var Pf38= new google.maps.LatLng(4.49862859354169,-74.2258108228718);
        var Pf39= new google.maps.LatLng(4.48888674014104,-74.219972133081);
        var Pf40= new google.maps.LatLng(4.48027526286672,-74.212633305507);
        var Pf41= new google.maps.LatLng(4.47280792287342,-74.2044854121702);
        var Pf42= new google.maps.LatLng(4.46630209381296,-74.1961589189241);
        var Pf43= new google.maps.LatLng(4.46040358466791,-74.1881778758038);
        var Pf44= new google.maps.LatLng(4.45466784087015,-74.1808658963268);
        var Pf45= new google.maps.LatLng(4.44866457081226,-74.1742993936255);
        var Pf46= new google.maps.LatLng(4.44205351972478,-74.1683387497601);
        var Pf47= new google.maps.LatLng(4.43470137444677,-74.16263994497);
        var Pf48= new google.maps.LatLng(4.42666967726509,-74.1567850015829);
        var Pf49= new google.maps.LatLng(4.41829755289048,-74.150320583693);
        var Pf50= new google.maps.LatLng(4.41010278835601,-74.1428978749964);
        var Pf51= new google.maps.LatLng(4.402726460366,-74.1343312450211);
        var Pf52= new google.maps.LatLng(4.39684482277892,-74.1246383675991);
        var Pf53= new google.maps.LatLng(4.39304417379315,-74.1140486819163);
        var Pf54= new google.maps.LatLng(4.39173084946948,-74.1029617823259);
        var Pf55= new google.maps.LatLng(4.39302648805116,-74.0918725849027);
        var Pf56= new google.maps.LatLng(4.39680148231071,-74.0812747184767);
        var Pf57= new google.maps.LatLng(4.40265073458823,-74.071566379967);
        var Pf58= new google.maps.LatLng(4.41002321692027,-74.0629884053516);
        var Pf59= new google.maps.LatLng(4.41819920274563,-74.0555476726735);
        var Pf60= new google.maps.LatLng(4.42655467610958,-74.0490647079839);
        var Pf61= new google.maps.LatLng(4.43456362091952,-74.0431867740911);
        var Pf62= new google.maps.LatLng(4.44190115174218,-74.0374710552317);
        var Pf63= new google.maps.LatLng(4.44849047796451,-74.0314888821907);
        var Pf64= new google.maps.LatLng(4.45447164175669,-74.0249012345311);
        var Pf65= new google.maps.LatLng(4.46018987600647,-74.0175752168801);
        var Pf66= new google.maps.LatLng(4.4660692229189,-74.0095798440194);
        var Pf67= new google.maps.LatLng(4.47255115677314,-74.0012294763929);
        var Pf68= new google.maps.LatLng(4.47999951171238,-73.993063292074);
        var Pf69= new google.maps.LatLng(4.48859625073998,-73.9857121620739);
        var Pf70= new google.maps.LatLng(4.49832382737276,-73.9798498876888);
        var Pf71= new google.maps.LatLng(4.50895210248357,-73.9760607457177);
        var Pf72 = new google.maps.LatLng(4.52008006504514, -73.974749796485);


             var flightPath2 = new google.maps.Polygon({
                 path: [Pf0, Pf1, Pf2, Pf3, Pf4, Pf5, Pf6, Pf7, Pf8, Pf9, Pf10, Pf11, Pf12, Pf13, Pf14, Pf15, Pf16, Pf17, Pf18, Pf19, Pf20, Pf21, Pf22, Pf23, Pf24, Pf25, Pf26, Pf27, Pf28, Pf29, Pf30, Pf31, Pf32, Pf33, Pf34, Pf35, Pf36, Pf37, Pf38, Pf39, Pf40, Pf41, Pf42, Pf43, Pf44, Pf45, Pf46, Pf47, Pf48, Pf49, Pf50, Pf51, Pf52, Pf53, Pf54, Pf55, Pf56, Pf57, Pf58, Pf59, Pf60, Pf61, Pf62, Pf63, Pf64, Pf65, Pf66, Pf67, Pf68, Pf69, Pf70, Pf71, Pf72],

                 strokeColor: "#DF0101",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#DF0101",
                 fillOpacity: 0.1
             });
             //Fin Sta
                          // RDS1
var Ph0= new google.maps.LatLng(4.62300335201773,-74.1923332259559);
var Ph1= new google.maps.LatLng(4.62320453268704,-74.1923676196464);
var Ph2= new google.maps.LatLng(4.62339098516204,-74.192468615485);
var Ph3= new google.maps.LatLng(4.62354945856799,-74.1926285444787);
var Ph4= new google.maps.LatLng(4.6236696249107,-74.19283553866);
var Ph5= new google.maps.LatLng(4.62374507787803,-74.1930748009495);
var Ph6= new google.maps.LatLng(4.62377383939467,-74.1933301560788);
var Ph7= new google.maps.LatLng(4.62375831758471,-74.1935856837403);
var Ph8= new google.maps.LatLng(4.62370473968175,-74.1938272234125);
var Ph9= new google.maps.LatLng(4.6236221620979,-74.1940435622009);
var Ph10= new google.maps.LatLng(4.62352122123389,-74.1942271716169);
var Ph11= new google.maps.LatLng(4.62341281886315,-74.1943744365116);
var Ph12= new google.maps.LatLng(4.62330692887334,-74.1944854027565);
var Ph13= new google.maps.LatLng(4.62321167125462,-74.1945631410483);
var Ph14= new google.maps.LatLng(4.6231327368969,-74.1946128683564);
var Ph15= new google.maps.LatLng(4.62307318006254,-74.1946409801049);
var Ph16= new google.maps.LatLng(4.62303353942409,-74.1946541290866);
var Ph17= new google.maps.LatLng(4.62301221314764,-74.194658451631);
var Ph18= new google.maps.LatLng(4.62300599994493,-74.194659000417);
var Ph19= new google.maps.LatLng(4.62301072182628,-74.1946594067366);
var Ph20= new google.maps.LatLng(4.62302185669098,-74.1946617683229);
var Ph21= new google.maps.LatLng(4.62303512238728,-74.1946667417001);
var Ph22= new google.maps.LatLng(4.6230469637205,-74.1946738064108);
var Ph23= new google.maps.LatLng(4.62305490010708,-74.1946816573829);
var Ph24= new google.maps.LatLng(4.62305769878328,-74.1946886683884);
var Ph25= new google.maps.LatLng(4.62305535204289,-74.1946933553804);
var Ph26= new google.maps.LatLng(4.62304886166022,-74.1946947596647);
var Ph27= new google.maps.LatLng(4.62303986805364,-74.1946926757282);
var Ph28= new google.maps.LatLng(4.62303019844115,-74.1946876739056);
var Ph29= new google.maps.LatLng(4.62302143410597,-74.1946809140399);
var Ph30= new google.maps.LatLng(4.62301459828072,-74.1946738032279);
var Ph31= new google.maps.LatLng(4.62301003601195,-74.1946676005892);
var Ph32= new google.maps.LatLng(4.62300750031643,-74.1946630940488);
var Ph33= new google.maps.LatLng(4.62300639266201,-74.1946604544282);
var Ph34= new google.maps.LatLng(4.62300605547064,-74.1946593121708);
var Ph35= new google.maps.LatLng(4.62300600176484,-74.1946590208801);
var Ph36= new google.maps.LatLng(4.62300599994493,-74.194659000417);
var Ph37= new google.maps.LatLng(4.62300599817155,-74.1946590208842);
var Ph38= new google.maps.LatLng(4.6230059451282,-74.1946593122954);
var Ph39= new google.maps.LatLng(4.62300561053489,-74.1946604553113);
var Ph40= new google.maps.LatLng(4.62300450888511,-74.1946630974263);
var Ph41= new google.maps.LatLng(4.62300198344273,-74.1946676096811);
var Ph42= new google.maps.LatLng(4.62299743528868,-74.1946738226058);
var Ph43= new google.maps.LatLng(4.62299061564876,-74.1946809488352);
var Ph44= new google.maps.LatLng(4.62298186670578,-74.1946877284736);
var Ph45= new google.maps.LatLng(4.62297220849051,-74.1946927521175);
var Ph46= new google.maps.LatLng(4.62296321964509,-74.1946948563563);
var Ph47= new google.maps.LatLng(4.62295672608626,-74.1946934667314);
var Ph48= new google.maps.LatLng(4.6229543686953,-74.1946887850511);
var Ph49= new google.maps.LatLng(4.62295715142362,-74.194681767745);
var Ph50= new google.maps.LatLng(4.62296506993917,-74.194673898873);
var Ph51= new google.maps.LatLng(4.6229768951789,-74.1946668074421);
var Ph52= new google.maps.LatLng(4.62299014953307,-74.1946618041224);
var Ph53= new google.maps.LatLng(4.62300127899956,-74.1946594173982);
var Ph54= new google.maps.LatLng(4.62300599994493,-74.194659000417);
var Ph55= new google.maps.LatLng(4.62299978551037,-74.1946584656627);
var Ph56= new google.maps.LatLng(4.62297844946026,-74.1946541912875);
var Ph57= new google.maps.LatLng(4.62293877902565,-74.1946411318567);
var Ph58= new google.maps.LatLng(4.62287915842246,-74.194613154681);
var Ph59= new google.maps.LatLng(4.62280011118967,-74.1945636057843);
var Ph60= new google.maps.LatLng(4.6227046770279,-74.1944860828883);
var Ph61= new google.maps.LatLng(4.62259853492805,-74.1943753562205);
var Ph62= new google.maps.LatLng(4.62248979784178,-74.1942283367915);
var Ph63= new google.maps.LatLng(4.62238843948269,-74.1940449562255);
var Ph64= new google.maps.LatLng(4.62230536976837,-74.1938288050317);
var Ph65= new google.maps.LatLng(4.6222512421536,-74.1935873876024);
var Ph66= new google.maps.LatLng(4.62223513851493,-74.1933318962463);
var Ph67= new google.maps.LatLng(4.62226331829672,-74.1930764772514);
var Ph68= new google.maps.LatLng(4.62233822590184,-74.192837045307);
var Ph69= new google.maps.LatLng(4.62245792016194,-74.19262978001);
var Ph70= new google.maps.LatLng(4.62261602857335,-74.1924694928457);
var Ph71= new google.maps.LatLng(4.62280225029513,-74.192368075144);
var Ph72= new google.maps.LatLng(4.62300335201773,-74.1923332259559);

             var flightPath3 = new google.maps.Polygon({
                 path: [Ph0, Ph1, Ph2, Ph3, Ph4, Ph5, Ph6, Ph7, Ph8, Ph9, Ph10, Ph11, Ph12, Ph13, Ph14, Ph15, Ph16, Ph17, Ph18, Ph19, Ph20, Ph21, Ph22, Ph23, Ph24, Ph25, Ph26, Ph27, Ph28, Ph29, Ph30, Ph31, Ph32, Ph33, Ph34, Ph35, Ph36, Ph37, Ph38, Ph39, Ph40, Ph41, Ph42, Ph43, Ph44, Ph45, Ph46, Ph47, Ph48, Ph49, Ph50, Ph51, Ph52, Ph53, Ph54, Ph55, Ph56, Ph57, Ph58, Ph59, Ph60, Ph61, Ph62, Ph63, Ph64, Ph65, Ph66, Ph67, Ph68, Ph69, Ph70, Ph71, Ph72],

                 strokeColor: "#0000FF",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#0000FF",
                 fillOpacity: 0.1
             });
             //Fin RDS1

             // RDS2
var Pi0= new google.maps.LatLng(4.5845547171763,-74.0981287507777);
var Pi1= new google.maps.LatLng(4.58484868973354,-74.0981789685506);
var Pi2= new google.maps.LatLng(4.5851211532813,-74.0983265031);
var Pi3= new google.maps.LatLng(4.58535274417898,-74.0985601514455);
var Pi4= new google.maps.LatLng(4.58552836895619,-74.0988625748371);
var Pi5= new google.maps.LatLng(4.58563866400212,-74.099212154003);
var Pi6= new google.maps.LatLng(4.58568073603222,-74.0995852551577);
var Pi7= new google.maps.LatLng(4.58565810096097,-74.0999586162567);
var Pi8= new google.maps.LatLng(4.58557985553768,-74.1003115458493);
var Pi9= new google.maps.LatLng(4.58545923106329,-74.1006276588504);
var Pi10= new google.maps.LatLng(4.58531176819261,-74.1008959532932);
var Pi11= new google.maps.LatLng(4.58515339604373,-74.1011111450635);
var Pi12= new google.maps.LatLng(4.58499868855094,-74.1012732994363);
var Pi13= new google.maps.LatLng(4.58485951125393,-74.1013869016708);
var Pi14= new google.maps.LatLng(4.58474418065065,-74.1014595734306);
var Pi15= new google.maps.LatLng(4.58465716078584,-74.1015006587118);
var Pi16= new google.maps.LatLng(4.58459923995036,-74.1015198779974);
var Pi17= new google.maps.LatLng(4.58456807861987,-74.1015261975254);
var Pi18= new google.maps.LatLng(4.58455899994445,-74.1015270004619);
var Pi19= new google.maps.LatLng(4.58456589966017,-74.1015275933173);
var Pi20= new google.maps.LatLng(4.5845821704147,-74.1015310419392);
var Pi21= new google.maps.LatLng(4.58460155521595,-74.1015383063441);
var Pi22= new google.maps.LatLng(4.58461885909821,-74.101548626702);
var Pi23= new google.maps.LatLng(4.58463045718584,-74.101560096573);
var Pi24= new google.maps.LatLng(4.58463454786897,-74.1015703400482);
var Pi25= new google.maps.LatLng(4.58463111962492,-74.1015771887488);
var Pi26= new google.maps.LatLng(4.58462163608347,-74.101579241725);
var Pi27= new google.maps.LatLng(4.58460849419838,-74.1015761984085);
var Pi28= new google.maps.LatLng(4.58459436401333,-74.1015688918097);
var Pi29= new google.maps.LatLng(4.5845815563147,-74.1015590163287);
var Pi30= new google.maps.LatLng(4.58457156650534,-74.1015486277324);
var Pi31= new google.maps.LatLng(4.58456489899208,-74.1015395656933);
var Pi32= new google.maps.LatLng(4.58456119302068,-74.1015329815125);
var Pi33= new google.maps.LatLng(4.58455957404223,-74.1015291248874);
var Pi34= new google.maps.LatLng(4.58455908113409,-74.1015274559639);
var Pi35= new google.maps.LatLng(4.58455900260733,-74.1015270303608);
var Pi36= new google.maps.LatLng(4.58455899994445,-74.1015270004619);
var Pi37= new google.maps.LatLng(4.5845589973568,-74.1015270303673);
var Pi38= new google.maps.LatLng(4.58455891990102,-74.1015274561653);
var Pi39= new google.maps.LatLng(4.58455843119312,-74.1015291263149);
var Pi40= new google.maps.LatLng(4.58455682192227,-74.1015329869726);
var Pi41= new google.maps.LatLng(4.58455313252688,-74.101539580391);
var Pi42= new google.maps.LatLng(4.58454648783253,-74.1015486590585);
var Pi43= new google.maps.LatLng(4.58453652418953,-74.1015590725782);
var Pi44= new google.maps.LatLng(4.58452374137495,-74.1015689800232);
var Pi45= new google.maps.LatLng(4.58450962961537,-74.1015763218974);
var Pi46= new google.maps.LatLng(4.58449649542745,-74.101579398034);
var Pi47= new google.maps.LatLng(4.58448700675121,-74.1015773687558);
var Pi48= new google.maps.LatLng(4.58448356128879,-74.1015705286424);
var Pi49= new google.maps.LatLng(4.58448762618952,-74.1015602749822);
var Pi50= new google.maps.LatLng(4.5844991953856,-74.1015487761751);
var Pi51= new google.maps.LatLng(4.58451647324991,-74.101538412622);
var Pi52= new google.maps.LatLng(4.58453583971457,-74.1015310998125);
var Pi53= new google.maps.LatLng(4.58455210174192,-74.1015276105529);
var Pi54= new google.maps.LatLng(4.58455899994445,-74.1015270004619);
var Pi55= new google.maps.LatLng(4.58454991927752,-74.101526220209);
var Pi56= new google.maps.LatLng(4.58451874214611,-74.1015199785512);
var Pi57= new google.maps.LatLng(4.58446077313943,-74.1015009040346);
var Pi58= new google.maps.LatLng(4.58437365017923,-74.1014600363096);
var Pi59= new google.maps.LatLng(4.58425813708744,-74.101387652988);
var Pi60= new google.maps.LatLng(4.58411867436093,-74.1012743990067);
var Pi61= new google.maps.LatLng(4.5839635592493,-74.101112632022);
var Pi62= new google.maps.LatLng(4.58380464589591,-74.1008978372197);
var Pi63= new google.maps.LatLng(4.58365650793098,-74.1006299129546);
var Pi64= new google.maps.LatLng(4.58353508761545,-74.1003141035017);
var Pi65= new google.maps.LatLng(4.58345595315687,-74.0999613718442);
var Pi66= new google.maps.LatLng(4.58343237701949,-74.099588069736);
var Pi67= new google.maps.LatLng(4.58347350804466,-74.0992148655489);
var Pi68= new google.maps.LatLng(4.58358292083871,-74.0988650121764);
var Pi69= new google.maps.LatLng(4.58375778184663,-74.0985621503525);
var Pi70= new google.maps.LatLng(4.58398878218891,-74.0983279226268);
var Pi71= new google.maps.LatLng(4.58426087236286,-74.0981797055519);
var Pi72= new google.maps.LatLng(4.5845547171763,-74.0981287507777);

             var flightPath4 = new google.maps.Polygon({
                 path: [Pi0, Pi1, Pi2, Pi3, Pi4, Pi5, Pi6, Pi7, Pi8, Pi9, Pi10, Pi11, Pi12, Pi13, Pi14, Pi15, Pi16, Pi17, Pi18, Pi19, Pi20, Pi21, Pi22, Pi23, Pi24, Pi25, Pi26, Pi27, Pi28, Pi29, Pi30, Pi31, Pi32, Pi33, Pi34, Pi35, Pi36, Pi37, Pi38, Pi39, Pi40, Pi41, Pi42, Pi43, Pi44, Pi45, Pi46, Pi47, Pi48, Pi49, Pi50, Pi51, Pi52, Pi53, Pi54, Pi55, Pi56, Pi57, Pi58, Pi59, Pi60, Pi61, Pi62, Pi63, Pi64, Pi65, Pi66, Pi67, Pi68, Pi69, Pi70, Pi71, Pi72],

                 strokeColor: "#0000FF",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#0000FF",
                 fillOpacity: 0.1
             });
             //Fin RDS2

             // RDS3
var Pj0= new google.maps.LatLng(4.76044379902037,-74.0359516773987);
var Pj1= new google.maps.LatLng(4.76064592372199,-74.0359750895185);
var Pj2= new google.maps.LatLng(4.76083910048308,-74.0360433815511);
var Pj3= new google.maps.LatLng(4.76101602610486,-74.0361493807241);
var Pj4= new google.maps.LatLng(4.76117243504312,-74.03628263926);
var Pj5= new google.maps.LatLng(4.76130807273921,-74.0364306043243);
var Pj6= new google.maps.LatLng(4.76142625129238,-74.0365818221379);
var Pj7= new google.maps.LatLng(4.76153339906946,-74.0367267706744);
var Pj8= new google.maps.LatLng(4.76163758670733,-74.0368595684231);
var Pj9= new google.maps.LatLng(4.76174662733429,-74.0369788246577);
var Pj10= new google.maps.LatLng(4.76186670031116,-74.0370870737508);
var Pj11= new google.maps.LatLng(4.76200022826746,-74.0371905645386);
var Pj12= new google.maps.LatLng(4.76214609582834,-74.0372968906424);
var Pj13= new google.maps.LatLng(4.76229814724999,-74.0374142896569);
var Pj14= new google.maps.LatLng(4.76244698187816,-74.0375491014253);
var Pj15= new google.maps.LatLng(4.76258095933772,-74.037704701703);
var Pj16= new google.maps.LatLng(4.7626877993398,-74.0378807724624);
var Pj17= new google.maps.LatLng(4.76275685397272,-74.0380731472382);
var Pj18= new google.maps.LatLng(4.76278074248966,-74.0382745665991);
var Pj19= new google.maps.LatLng(4.76275725372258,-74.038476037522);
var Pj20= new google.maps.LatLng(4.76268873920149,-74.0386685892978);
var Pj21= new google.maps.LatLng(4.76258239506585,-74.0388449423335);
var Pj22= new google.maps.LatLng(4.76244870308276,-74.039000844907);
var Pj23= new google.maps.LatLng(4.76230025688719,-74.03913604333);
var Pj24= new google.maps.LatLng(4.76214854746274,-74.0392538390379);
var Pj25= new google.maps.LatLng(4.76200312773915,-74.0393606396519);
var Pj26= new google.maps.LatLng(4.76186989829986,-74.0394644897211);
var Pj27= new google.maps.LatLng(4.76175025435173,-74.0395731771038);
var Pj28= new google.maps.LatLng(4.76164165326104,-74.0396928611558);
var Pj29= new google.maps.LatLng(4.76153782588386,-74.0398259566394);
var Pj30= new google.maps.LatLng(4.76143115393455,-74.0399713517574);
var Pj31= new google.maps.LatLng(4.76131337309992,-74.0401229106426);
var Pj32= new google.maps.LatLng(4.76117812299719,-74.0402712630308);
var Pj33= new google.maps.LatLng(4.76102201697447,-74.0404048062035);
var Pj34= new google.maps.LatLng(4.76084537416243,-74.0405112996287);
var Pj35= new google.maps.LatLng(4.76065237459855,-74.040580129906);
var Pj36= new google.maps.LatLng(4.76045030131041,-74.0406039402522);
var Pj37= new google.maps.LatLng(4.76024817649479,-74.0405805267447);
var Pj38= new google.maps.LatLng(4.76005499993361,-74.0405122333804);
var Pj39= new google.maps.LatLng(4.75987807478507,-74.0404062330553);
var Pj40= new google.maps.LatLng(4.75972166649926,-74.0402729736166);
var Pj41= new google.maps.LatLng(4.75958602953957,-74.0401250079094);
var Pj42= new google.maps.LatLng(4.75946785171959,-74.0399737896737);
var Pj43= new google.maps.LatLng(4.75936070460443,-74.0398288408637);
var Pj44= new google.maps.LatLng(4.75925651753233,-74.0396960429216);
var Pj45= new google.maps.LatLng(4.75914747736743,-74.0395767865128);
var Pj46= new google.maps.LatLng(4.75902740477163,-74.039468537239);
var Pj47= new google.maps.LatLng(4.75889387714878,-74.0393650462732);
var Pj48= new google.maps.LatLng(4.75874800990579,-74.039258720029);
var Pj49= new google.maps.LatLng(4.75859595882424,-74.0391413209926);
var Pj50= new google.maps.LatLng(4.75844712457348,-74.0390065094002);
var Pj51= new google.maps.LatLng(4.75831314752984,-74.0388509095789);
var Pj52= new google.maps.LatLng(4.75820630795838,-74.0386748395984);
var Pj53= new google.maps.LatLng(4.75813725372862,-74.0384824658992);
var Pj54= new google.maps.LatLng(4.75811336554196,-74.0382810478396);
var Pj55= new google.maps.LatLng(4.75813685452786,-74.0380795783021);
var Pj56= new google.maps.LatLng(4.75820536913805,-74.0378870278579);
var Pj57= new google.maps.LatLng(4.75831155452281,-74.0377106338236);
var Pj58= new google.maps.LatLng(4.75844540508289,-74.0375547743036);
var Pj59= new google.maps.LatLng(4.75859385106724,-74.0374195765253);
var Pj60= new google.maps.LatLng(4.75874556023515,-74.0373017812387);
var Pj61= new google.maps.LatLng(4.75889097966697,-74.0371949808971);
var Pj62= new google.maps.LatLng(4.75902420877596,-74.037091131024);
var Pj63= new google.maps.LatLng(4.75914385234237,-74.0369824438129);
var Pj64= new google.maps.LatLng(4.75925245296929,-74.0368627599428);
var Pj65= new google.maps.LatLng(4.75935627978046,-74.0367296646376);
var Pj66= new google.maps.LatLng(4.7594630333626,-74.0365844113296);
var Pj67= new google.maps.LatLng(4.75958073105776,-74.0364327107977);
var Pj68= new google.maps.LatLng(4.7597159802582,-74.0362843582308);
var Pj69= new google.maps.LatLng(4.75987208534753,-74.0361508146023);
var Pj70= new google.maps.LatLng(4.76004872729644,-74.0360443203999);
var Pj71= new google.maps.LatLng(4.76024172616563,-74.0359754890439);
var Pj72= new google.maps.LatLng(4.76044379902037,-74.0359516773987);

             var flightPath5 = new google.maps.Polygon({
                path: [Pj0, Pj1, Pj2, Pj3, Pj4, Pj5, Pj6, Pj7, Pj8, Pj9, Pj10, Pj11, Pj12, Pj13, Pj14, Pj15, Pj16, Pj17, Pj18, Pj19, Pj20, Pj21, Pj22, Pj23, Pj24, Pj25, Pj26, Pj27, Pj28, Pj29, Pj30, Pj31, Pj32, Pj33, Pj34, Pj35, Pj36, Pj37, Pj38, Pj39, Pj40, Pj41, Pj42, Pj43, Pj44, Pj45, Pj46, Pj47, Pj48, Pj49, Pj50, Pj51, Pj52, Pj53, Pj54, Pj55, Pj56, Pj57, Pj58, Pj59, Pj60, Pj61, Pj62, Pj63, Pj64, Pj65, Pj66, Pj67, Pj68, Pj69, Pj70, Pj71, Pj72],

                 strokeColor: "#0000FF",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#0000FF",
                 fillOpacity: 0.1
             });
             //Fin RDS3


    var deviceMarker = "RDS.png";
    var antenaMarker = "bts2.png";

             var markerDevice = new google.maps.Marker({ position: myCenterDevice, icon: deviceMarker });
             var infowindowD = new google.maps.InfoWindow({
                 content: name
             });


             var myCenter = new google.maps.LatLng(4.52025, -74.102806);
             var marker = new google.maps.Marker({ position: myCenter, icon: antenaMarker });
             var infowindow2 = new google.maps.InfoWindow({
                 content: "SANTA LIBRADA"
             });

             var myCenter2 = new google.maps.LatLng(4.743539, -74.074769);
             var marker2 = new google.maps.Marker({ position: myCenter2, icon: antenaMarker });
             var infowindow5 = new google.maps.InfoWindow({
                 content: "SUBA"
             });

             var myCenter3 = new google.maps.LatLng(4.623006, -74.194659);
             var marker3 = new google.maps.Marker({ position: myCenter3 , icon: deviceMarker});
             var infowindow6 = new google.maps.InfoWindow({
                 content: "RDS1"
             });
             var myCenter4 = new google.maps.LatLng(4.584559, -74.101527);
             var marker4 = new google.maps.Marker({ position: myCenter4 , icon: deviceMarker});
             var infowindow7 = new google.maps.InfoWindow({
                 content: "RDS2"
             });
             var myCenter5 = new google.maps.LatLng(4.760447054149487, -74.03827780748605);
             var marker5 = new google.maps.Marker({ position: myCenter5 , icon: deviceMarker});
             var infowindow8 = new google.maps.InfoWindow({
                 content: "RDS3"
    });
            

             var i;
             google.maps.event.addListener(markerDevice, 'click', (function (markerDevice, i) {
                 return function () {
                     infowindowD.setContent(markerDevice);
                     infowindowD.open(map, markerDevice);
                 }
             })
                 (markerDevice, i));



             var k;
             google.maps.event.addListener(marker, 'click', (function (marker, k) {
                 return function () {
                     infowindow2.setContent(marker);
                     infowindow2.open(map, marker);
                 }
             })
                 (marker, k));



             var m;
             google.maps.event.addListener(marker2, 'click', (function (marker2, m) {
                 return function () {
                     infowindow5.setContent(marker2);
                     infowindow5.open(map, marker2);
                 }
             })
                 (marker2, m));
             var n;
             google.maps.event.addListener(marker3, 'click', (function (marker3, m) {
                 return function () {
                     infowindow6.setContent(marker3);
                     infowindow6.open(map, marker3);
                 }
             })
                 (marker3, n));

              var o;
             google.maps.event.addListener(marker4, 'click', (function (marker4, o) {
                 return function () {
                     infowindow7.setContent(marker4);
                     infowindow7.open(map, marker4);
                 }
             })
                 (marker4, o));
             var p;
             google.maps.event.addListener(marker5, 'click', (function (marker5, p) {
                 return function () {
                     infowindow8.setContent(marker5);
                     infowindow8.open(map, marker5);
                 }
             })
        (marker5, p));
    
   


             marker.setMap(map);//Sta Librada
             marker2.setMap(map);//Suba
             marker3.setMap(map)//rds1
             marker4.setMap(map)//rds2
             marker5.setMap(map)//rds3
             markerDevice.setMap(map);

             flightPath0.setMap(map); //grafica dinamica
             flightPath.setMap(map);   //Sta Librada
             flightPath2.setMap(map); // Suba
             flightPath3.setMap(map); //RDS1
             flightPath4.setMap(map); //RDS2
             flightPath5.setMap(map); //RDS3
             
             //Fin Modelo1

        });

         }

 
         function myMap2(lat, long, name) {
            var lati = [];
    
            lati = Grafiquinha();
            lati.success(function (data) {
             puntosLat = JSON.parse(data.d);
             console.log(strtofloat(puntosLat[0]));

             var myCenterDevice = new google.maps.LatLng(lat, long);
             var mapOptions = { center: myCenterDevice, zoom: 15 };
             var mapCanvas = document.getElementById("ModalMapPreview");
             var map = new google.maps.Map(mapCanvas, {
                 zoom: 15,
                 center: new google.maps.LatLng(lat, long),
             });


                 // Graficadinamica
        var PC = new google.maps.LatLng(lat, long);
        var Pa0 = new google.maps.LatLng(strtofloat(puntosLat[0]), strtofloat(puntosLat[1]));
        var Pa1 = new google.maps.LatLng(strtofloat(puntosLat[2]), strtofloat(puntosLat[3]));
        var Pa2 = new google.maps.LatLng(strtofloat(puntosLat[4]), strtofloat(puntosLat[5]));
        var Pa3 = new google.maps.LatLng(strtofloat(puntosLat[6]), strtofloat(puntosLat[7]));
        var Pa4 = new google.maps.LatLng(strtofloat(puntosLat[8]), strtofloat(puntosLat[9]));
        var Pa5 = new google.maps.LatLng(strtofloat(puntosLat[10]), strtofloat(puntosLat[11]));
        var Pa6 = new google.maps.LatLng(strtofloat(puntosLat[12]), strtofloat(puntosLat[13]));
        var Pa7 = new google.maps.LatLng(strtofloat(puntosLat[14]), strtofloat(puntosLat[15]));
        var Pa8 = new google.maps.LatLng(strtofloat(puntosLat[16]), strtofloat(puntosLat[17]));
        var Pa9 = new google.maps.LatLng(strtofloat(puntosLat[18]), strtofloat(puntosLat[19]));
        var Pa10 = new google.maps.LatLng(strtofloat(puntosLat[20]), strtofloat(puntosLat[21]));
        var Pa11 = new google.maps.LatLng(strtofloat(puntosLat[22]), strtofloat(puntosLat[23]));
        var Pa12 = new google.maps.LatLng(strtofloat(puntosLat[24]), strtofloat(puntosLat[25]));
        var Pa13 = new google.maps.LatLng(strtofloat(puntosLat[26]), strtofloat(puntosLat[27]));
        var Pa14 = new google.maps.LatLng(strtofloat(puntosLat[28]), strtofloat(puntosLat[29]));
        var Pa15 = new google.maps.LatLng(strtofloat(puntosLat[30]), strtofloat(puntosLat[31]));
        var Pa16 = new google.maps.LatLng(strtofloat(puntosLat[32]), strtofloat(puntosLat[33]));
        var Pa17 = new google.maps.LatLng(strtofloat(puntosLat[34]), strtofloat(puntosLat[35]));
        var Pa18 = new google.maps.LatLng(strtofloat(puntosLat[36]), strtofloat(puntosLat[37]));
        var Pa19 = new google.maps.LatLng(strtofloat(puntosLat[38]), strtofloat(puntosLat[39]));
        var Pa20 = new google.maps.LatLng(strtofloat(puntosLat[40]), strtofloat(puntosLat[41]));
        var Pa21 = new google.maps.LatLng(strtofloat(puntosLat[42]), strtofloat(puntosLat[43]));
        var Pa22 = new google.maps.LatLng(strtofloat(puntosLat[44]), strtofloat(puntosLat[45]));
        var Pa23 = new google.maps.LatLng(strtofloat(puntosLat[46]), strtofloat(puntosLat[47]));
        var Pa24 = new google.maps.LatLng(strtofloat(puntosLat[48]), strtofloat(puntosLat[49]));
        var Pa25 = new google.maps.LatLng(strtofloat(puntosLat[50]), strtofloat(puntosLat[51]));
        var Pa26 = new google.maps.LatLng(strtofloat(puntosLat[52]), strtofloat(puntosLat[53]));
        var Pa27 = new google.maps.LatLng(strtofloat(puntosLat[54]), strtofloat(puntosLat[55]));
        var Pa28 = new google.maps.LatLng(strtofloat(puntosLat[56]), strtofloat(puntosLat[57]));
        var Pa29 = new google.maps.LatLng(strtofloat(puntosLat[58]), strtofloat(puntosLat[59]));
        var Pa30 = new google.maps.LatLng(strtofloat(puntosLat[60]), strtofloat(puntosLat[61]));
        var Pa31 = new google.maps.LatLng(strtofloat(puntosLat[62]), strtofloat(puntosLat[63]));
        var Pa32 = new google.maps.LatLng(strtofloat(puntosLat[64]), strtofloat(puntosLat[65]));
        var Pa33 = new google.maps.LatLng(strtofloat(puntosLat[66]), strtofloat(puntosLat[67]));
        var Pa34 = new google.maps.LatLng(strtofloat(puntosLat[68]), strtofloat(puntosLat[69]));
        var Pa35 = new google.maps.LatLng(strtofloat(puntosLat[70]), strtofloat(puntosLat[71]));
        var Pa36 = new google.maps.LatLng(strtofloat(puntosLat[72]), strtofloat(puntosLat[73]));
        var Pa37 = new google.maps.LatLng(strtofloat(puntosLat[74]), strtofloat(puntosLat[75]));
        var Pa38 = new google.maps.LatLng(strtofloat(puntosLat[76]), strtofloat(puntosLat[77]));
        var Pa39 = new google.maps.LatLng(strtofloat(puntosLat[78]), strtofloat(puntosLat[79]));
        var Pa40 = new google.maps.LatLng(strtofloat(puntosLat[80]), strtofloat(puntosLat[81]));
        var Pa41 = new google.maps.LatLng(strtofloat(puntosLat[82]), strtofloat(puntosLat[83]));
        var Pa42 = new google.maps.LatLng(strtofloat(puntosLat[84]), strtofloat(puntosLat[85]));
        var Pa43 = new google.maps.LatLng(strtofloat(puntosLat[86]), strtofloat(puntosLat[87]));
        var Pa44 = new google.maps.LatLng(strtofloat(puntosLat[88]), strtofloat(puntosLat[89]));
        var Pa45 = new google.maps.LatLng(strtofloat(puntosLat[90]), strtofloat(puntosLat[91]));
        var Pa46 = new google.maps.LatLng(strtofloat(puntosLat[92]), strtofloat(puntosLat[93]));
        var Pa47 = new google.maps.LatLng(strtofloat(puntosLat[94]), strtofloat(puntosLat[95]));
        var Pa48 = new google.maps.LatLng(strtofloat(puntosLat[96]), strtofloat(puntosLat[97]));
        var Pa49 = new google.maps.LatLng(strtofloat(puntosLat[98]), strtofloat(puntosLat[99]));
        var Pa50 = new google.maps.LatLng(strtofloat(puntosLat[100]), strtofloat(puntosLat[101]));
        var Pa51 = new google.maps.LatLng(strtofloat(puntosLat[102]), strtofloat(puntosLat[103]));
        var Pa52 = new google.maps.LatLng(strtofloat(puntosLat[104]), strtofloat(puntosLat[105]));
        var Pa53 = new google.maps.LatLng(strtofloat(puntosLat[106]), strtofloat(puntosLat[107]));
        var Pa54 = new google.maps.LatLng(strtofloat(puntosLat[108]), strtofloat(puntosLat[109]));
        var Pa55 = new google.maps.LatLng(strtofloat(puntosLat[110]), strtofloat(puntosLat[111]));
        var Pa56 = new google.maps.LatLng(strtofloat(puntosLat[112]), strtofloat(puntosLat[113]));
        var Pa57 = new google.maps.LatLng(strtofloat(puntosLat[114]), strtofloat(puntosLat[115]));
        var Pa58 = new google.maps.LatLng(strtofloat(puntosLat[116]), strtofloat(puntosLat[117]));
        var Pa59 = new google.maps.LatLng(strtofloat(puntosLat[118]), strtofloat(puntosLat[119]));
        var Pa60 = new google.maps.LatLng(strtofloat(puntosLat[120]), strtofloat(puntosLat[121]));
        var Pa61 = new google.maps.LatLng(strtofloat(puntosLat[122]), strtofloat(puntosLat[123]));
        var Pa62 = new google.maps.LatLng(strtofloat(puntosLat[124]), strtofloat(puntosLat[125]));
        var Pa63 = new google.maps.LatLng(strtofloat(puntosLat[126]), strtofloat(puntosLat[127]));
        var Pa64 = new google.maps.LatLng(strtofloat(puntosLat[128]), strtofloat(puntosLat[129]));
        var Pa65 = new google.maps.LatLng(strtofloat(puntosLat[130]), strtofloat(puntosLat[131]));
        var Pa66 = new google.maps.LatLng(strtofloat(puntosLat[132]), strtofloat(puntosLat[133]));
        var Pa67 = new google.maps.LatLng(strtofloat(puntosLat[134]), strtofloat(puntosLat[135]));
        var Pa68 = new google.maps.LatLng(strtofloat(puntosLat[136]), strtofloat(puntosLat[137]));
        var Pa69 = new google.maps.LatLng(strtofloat(puntosLat[138]), strtofloat(puntosLat[139]));
        var Pa70 = new google.maps.LatLng(strtofloat(puntosLat[140]), strtofloat(puntosLat[141]));
        var Pa71 = new google.maps.LatLng(strtofloat(puntosLat[142]), strtofloat(puntosLat[143]));
        var Pa72 = new google.maps.LatLng(strtofloat(puntosLat[144]), strtofloat(puntosLat[145]));
       





             var flightPath0 = new google.maps.Polygon({
                 path: [Pa0,Pa1,Pa2,Pa3,Pa4,Pa5,Pa6,Pa7,Pa8,Pa9,Pa10,Pa11,Pa12,Pa13,Pa14,Pa15,Pa16,Pa17,Pa18,Pa19,Pa20,Pa21,Pa22,Pa23,Pa24,Pa25,Pa26,Pa27,Pa28,Pa29,Pa30,Pa31,Pa32,Pa33,Pa34,Pa35,Pa36,Pa37,Pa38,Pa39,Pa40,Pa41,Pa42,Pa43,Pa44,Pa45,Pa46,Pa47,Pa48,Pa49,Pa50,Pa51,Pa52,Pa53,Pa54,Pa55,Pa56,Pa57,Pa58,Pa59,Pa60,Pa61,Pa62,Pa63,Pa64,Pa65,Pa66,Pa67,Pa68,Pa69,Pa70,Pa71,Pa72],
                 strokeColor: "#0000FF",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#0000FF",
                 fillOpacity: 0.1

        });



              // Suba
              var PC = new google.maps.LatLng(lat, long);
             var Pa0= new google.maps.LatLng(4.74342528832294,-73.9934737030271);
var Pa1= new google.maps.LatLng(4.75048613562712,-73.9943296750397);
var Pa2= new google.maps.LatLng(4.75720982625312,-73.9968552349836);
var Pa3= new google.maps.LatLng(4.76333029720381,-74.0007347811926);
var Pa4= new google.maps.LatLng(4.7686963083184,-74.0055751985667);
var Pa5= new google.maps.LatLng(4.77330948391686,-74.0109019613554);
var Pa6= new google.maps.LatLng(4.77730553845841,-74.0162864365421);
var Pa7= new google.maps.LatLng(4.78092391738547,-74.0213939967401);
var Pa8= new google.maps.LatLng(4.78445045779011,-74.0260341596896);
var Pa9= new google.maps.LatLng(4.80611354833993,-74.0122221370719);
var Pa10= new google.maps.LatLng(4.81189824411359,-74.0174318403811);
var Pa11= new google.maps.LatLng(4.81833939858171,-74.022407261348);
var Pa12= new google.maps.LatLng(4.82537278282402,-74.0275231910145);
var Pa13= new google.maps.LatLng(4.83270716059249,-74.0331728939028);
var Pa14= new google.maps.LatLng(4.83990449603252,-74.0396571636987);
var Pa15= new google.maps.LatLng(4.84638107270166,-74.0471497757872);
var Pa16= new google.maps.LatLng(4.85153966247162,-74.0556346686765);
var Pa17= new google.maps.LatLng(4.85488316387252,-74.0649066958056);
var Pa18= new google.maps.LatLng(4.85889484151195,-74.0746135543419);
var Pa19= new google.maps.LatLng(4.85773958232898,-74.0845743039412);
var Pa20= new google.maps.LatLng(4.85435383704385,-74.0940942498401);
var Pa21= new google.maps.LatLng(4.84909588814436,-74.1028128777254);
var Pa22= new google.maps.LatLng(4.84249181779842,-74.1105222441639);
var Pa23= new google.maps.LatLng(4.83515003447665,-74.1172050486963);
var Pa24= new google.maps.LatLng(4.82764928553366,-74.1230280816441);
var Pa25= new google.maps.LatLng(4.82046180271835,-74.1283089779773);
var Pa26= new google.maps.LatLng(4.81387126373738,-74.133439806907);
var Pa27= new google.maps.LatLng(4.78976648873057,-74.1207267760283);
var Pa28= new google.maps.LatLng(4.78804099967182,-74.127493372075);
var Pa29= new google.maps.LatLng(4.78229459875507,-74.1297862162285);
var Pa30= new google.maps.LatLng(4.78030520583774,-74.1380544886167);
var Pa31= new google.maps.LatLng(4.77445903325652,-74.1406400174379);
var Pa32= new google.maps.LatLng(4.77098113167125,-74.1496216857184);
var Pa33= new google.maps.LatLng(4.76417858717994,-74.1511546274514);
var Pa34= new google.maps.LatLng(4.75855637421301,-74.1590305980946);
var Pa35= new google.maps.LatLng(4.75093300840173,-74.1577868492415);
var Pa36= new google.maps.LatLng(4.74365390787606,-74.1649199955955);
var Pa37= new google.maps.LatLng(4.73582259440757,-74.1639845696492);
var Pa38= new google.maps.LatLng(4.72835966673051,-74.1612158359077);
var Pa39= new google.maps.LatLng(4.7215598746497,-74.1569456373769);
var Pa40= new google.maps.LatLng(4.71755667289624,-74.1462050511435);
var Pa41= new google.maps.LatLng(4.7112832360761,-74.1439456391977);
var Pa42= new google.maps.LatLng(4.70694568630783,-74.1381298427687);
var Pa43= new google.maps.LatLng(4.7030154416113,-74.1326105438264);
var Pa44= new google.maps.LatLng(4.6991801538199,-74.1275980066524);
var Pa45= new google.maps.LatLng(4.69386072518686,-74.1244115808444);
var Pa46= new google.maps.LatLng(4.68925210815336,-74.1202902325951);
var Pa47= new google.maps.LatLng(4.68407907116551,-74.1163803225393);
var Pa48= new google.maps.LatLng(4.67838887646906,-74.1123715127965);
var Pa49= new google.maps.LatLng(4.67625004896744,-74.106148936752);
var Pa50= new google.maps.LatLng(4.67062719624237,-74.1013262815689);
var Pa51= new google.maps.LatLng(4.66552549105166,-74.0957124390988);
var Pa52= new google.maps.LatLng(4.66701021166312,-74.0883217589764);
var Pa53= new google.maps.LatLng(4.66451261772032,-74.081764686052);
var Pa54= new google.maps.LatLng(4.65533715086173,-74.0748853073961);
var Pa55= new google.maps.LatLng(4.65626647466695,-74.0672754784199);
var Pa56= new google.maps.LatLng(4.66845381507837,-74.0616763165472);
var Pa57= new google.maps.LatLng(4.6722093330109,-74.0558216259893);
var Pa58= new google.maps.LatLng(4.68299878078064,-74.0528987387202);
var Pa59= new google.maps.LatLng(4.68546965682922,-74.0478751494548);
var Pa60= new google.maps.LatLng(4.69038633114731,-74.0442778934402);
var Pa61= new google.maps.LatLng(4.69270594922117,-74.0393948946708);
var Pa62= new google.maps.LatLng(4.69712329102886,-74.0360568398435);
var Pa63= new google.maps.LatLng(4.69877630259623,-74.0302751160799);
var Pa64= new google.maps.LatLng(4.70248779377145,-74.0261420985862);
var Pa65= new google.maps.LatLng(4.70600183430943,-74.0214920922995);
var Pa66= new google.maps.LatLng(4.70960635821953,-74.0163744384712);
var Pa67= new google.maps.LatLng(4.71243742377766,-74.0085291997326);
var Pa68= new google.maps.LatLng(4.71722041125288,-74.0030056689676);
var Pa69= new google.maps.LatLng(4.72278357077422,-73.9979890126895);
var Pa70= new google.maps.LatLng(4.72912806915511,-73.993965841457);
var Pa71= new google.maps.LatLng(4.73609848811063,-73.9913417607912);
var Pa72= new google.maps.LatLng(4.74342528832294,-73.9934737030271);


             var flightPath = new google.maps.Polygon({
                 path: [Pa0, Pa1, Pa2, Pa3, Pa4, Pa5, Pa6, Pa7, Pa8, Pa9, Pa10, Pa11, Pa12, Pa13, Pa14, Pa15, Pa16, Pa17, Pa18, Pa19, Pa20, Pa21, Pa22, Pa23, Pa24, Pa25, Pa26, Pa27, Pa28, Pa29, Pa30, Pa31, Pa32, Pa33, Pa34, Pa35, Pa36, Pa37, Pa38, Pa39, Pa40, Pa41, Pa42, Pa43, Pa44, Pa45, Pa46, Pa47, Pa48, Pa49, Pa50, Pa51, Pa52, Pa53, Pa54, Pa55, Pa56, Pa57, Pa58, Pa59, Pa60, Pa61, Pa62, Pa63, Pa64, Pa65, Pa66, Pa67, Pa68, Pa69, Pa70, Pa71, Pa72],
                 strokeColor: "#DF0101",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#DF0101",
                 fillOpacity: 0.1
             });


             // SANTA LIBRADA
            var Pf0= new google.maps.LatLng(4.52013920004594,-74.0174166275551);
var Pf1= new google.maps.LatLng(4.52755802472754,-74.018315176513);
var Pf2= new google.maps.LatLng(4.53462588994031,-74.0209489037057);
var Pf3= new google.maps.LatLng(4.54291434958283,-74.0180841607601);
var Pf4= new google.maps.LatLng(4.54907968014158,-74.0235605938254);
var Pf5= new google.maps.LatLng(4.55438820407788,-74.0296105995693);
var Pf6= new google.maps.LatLng(4.55899559375286,-74.035736199352);
var Pf7= new google.maps.LatLng(4.5595673591451,-74.046702061751);
var Pf8= new google.maps.LatLng(4.56328016063356,-74.051574222906);
var Pf9= new google.maps.LatLng(4.56720156577389,-74.0559017932343);
var Pf10= new google.maps.LatLng(4.56705565816624,-74.0635699153647);
var Pf11= new google.maps.LatLng(4.57153096322671,-74.0669295121091);
var Pf12= new google.maps.LatLng(4.57128019281983,-74.0733625885415);
var Pf13= new google.maps.LatLng(4.5760291979528,-74.0768025835924);
var Pf14= new google.maps.LatLng(4.58357985956632,-74.0797473521719);
var Pf15= new google.maps.LatLng(4.58805469865405,-74.0846110085219);
var Pf16= new google.maps.LatLng(4.5916592552021,-74.0901671613);
var Pf17= new google.maps.LatLng(4.61126104618124,-74.0947571312004);
var Pf18= new google.maps.LatLng(4.6122248521603,-74.1026917277796);
var Pf19= new google.maps.LatLng(4.61482285247607,-74.1109330900842);
var Pf20= new google.maps.LatLng(4.61908038374224,-74.120045806538);
var Pf21= new google.maps.LatLng(4.61429466124232,-74.1277931307204);
var Pf22= new google.maps.LatLng(4.61669196379783,-74.1376515994905);
var Pf23= new google.maps.LatLng(4.60952027235718,-74.1441551286823);
var Pf24= new google.maps.LatLng(4.61214085396363,-74.1555249761786);
var Pf25= new google.maps.LatLng(4.58574802940933,-74.1483883089144);
var Pf26= new google.maps.LatLng(4.58009676547315,-74.1527230212927);
var Pf27= new google.maps.LatLng(4.5750545729224,-74.1572850384124);
var Pf28= new google.maps.LatLng(4.57022052687511,-74.1620029168918);
var Pf29= new google.maps.LatLng(4.56591263985797,-74.1676224385759);
var Pf30= new google.maps.LatLng(4.56149242064103,-74.1737908304562);
var Pf31= new google.maps.LatLng(4.55660953815407,-74.1802620834256);
var Pf32= new google.maps.LatLng(4.548395779692,-74.1795772417373);
var Pf33= new google.maps.LatLng(4.54243401309334,-74.1849147346756);
var Pf34= new google.maps.LatLng(4.53564337691813,-74.18919980833);
var Pf35= new google.maps.LatLng(4.52818524488777,-74.1919761688575);
var Pf36= new google.maps.LatLng(4.52035602459871,-74.1929293957175);
var Pf37= new google.maps.LatLng(4.51139201841074,-74.2050591532438);
var Pf38= new google.maps.LatLng(4.50282508328818,-74.2019470140168);
var Pf39= new google.maps.LatLng(4.49500063742996,-74.1971385965441);
var Pf40= new google.maps.LatLng(4.48810700830777,-74.1911210378212);
var Pf41= new google.maps.LatLng(4.48215580248717,-74.1844544389914);
var Pf42= new google.maps.LatLng(4.48149673310278,-74.169869498338);
var Pf43= new google.maps.LatLng(4.47732700080475,-74.1640395029468);
var Pf44= new google.maps.LatLng(4.47326074313366,-74.1587381970856);
var Pf45= new google.maps.LatLng(4.47329413210473,-74.1497041725108);
var Pf46= new google.maps.LatLng(4.46802768125257,-74.1465734471316);
var Pf47= new google.maps.LatLng(4.455202657943,-74.1483028992487);
var Pf48= new google.maps.LatLng(4.44901246719683,-74.1438989758732);
var Pf49= new google.maps.LatLng(4.44251824797548,-74.139034243321);
var Pf50= new google.maps.LatLng(4.4361276727602,-74.1334267084663);
var Pf51= new google.maps.LatLng(4.43784852524092,-74.124911393989);
var Pf52= new google.maps.LatLng(4.43354779407962,-74.118146238499);
var Pf53= new google.maps.LatLng(4.4340406777216,-74.1104262440582);
var Pf54= new google.maps.LatLng(4.42980360975231,-74.1029161062874);
var Pf55= new google.maps.LatLng(4.4116003711987,-74.0934688404127);
var Pf56= new google.maps.LatLng(4.41486209343838,-74.0844245727833);
var Pf57= new google.maps.LatLng(4.41992132908283,-74.0761538299696);
var Pf58= new google.maps.LatLng(4.4262570498368,-74.0688520481865);
var Pf59= new google.maps.LatLng(4.44244667780421,-74.0667753465049);
var Pf60= new google.maps.LatLng(4.4489281612061,-74.061896420413);
var Pf61= new google.maps.LatLng(4.45509917963952,-74.0574737893605);
var Pf62= new google.maps.LatLng(4.46072735362813,-74.0531687317275);
var Pf63= new google.maps.LatLng(4.46574388413806,-74.0486342727805);
var Pf64= new google.maps.LatLng(4.4700898394292,-74.0433967918803);
var Pf65= new google.maps.LatLng(4.47441678800225,-74.0377622355431);
var Pf66= new google.maps.LatLng(4.478852587529,-74.031572744529);
var Pf67= new google.maps.LatLng(4.48528678612772,-74.0283465926689);
var Pf68= new google.maps.LatLng(4.49068445665703,-74.0221905344036);
var Pf69= new google.maps.LatLng(4.49595185510081,-74.0129153357096);
var Pf70= new google.maps.LatLng(4.50339723083978,-74.0082895478031);
var Pf71= new google.maps.LatLng(4.51155879859423,-74.0052819513595);
var Pf72= new google.maps.LatLng(4.52013920004594,-74.0174166275551);

             var flightPath2 = new google.maps.Polygon({
                 path: [Pf0, Pf1, Pf2, Pf3, Pf4, Pf5, Pf6, Pf7, Pf8, Pf9, Pf10, Pf11, Pf12, Pf13, Pf14, Pf15, Pf16, Pf17, Pf18, Pf19, Pf20, Pf21, Pf22, Pf23, Pf24, Pf25, Pf26, Pf27, Pf28, Pf29, Pf30, Pf31, Pf32, Pf33, Pf34, Pf35, Pf36, Pf37, Pf38, Pf39, Pf40, Pf41, Pf42, Pf43, Pf44, Pf45, Pf46, Pf47, Pf48, Pf49, Pf50, Pf51, Pf52, Pf53, Pf54, Pf55, Pf56, Pf57, Pf58, Pf59, Pf60, Pf61, Pf62, Pf63, Pf64, Pf65, Pf66, Pf67, Pf68, Pf69, Pf70, Pf71, Pf72],

                 strokeColor: "#DF0101",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#DF0101",
                 fillOpacity: 0.1
             });
             //Fin Sta
                         // RDS1
var Ph0= new google.maps.LatLng(4.62300335201773,-74.1923332259559);
var Ph1= new google.maps.LatLng(4.62320453268704,-74.1923676196464);
var Ph2= new google.maps.LatLng(4.62339098516204,-74.192468615485);
var Ph3= new google.maps.LatLng(4.62354945856799,-74.1926285444787);
var Ph4= new google.maps.LatLng(4.6236696249107,-74.19283553866);
var Ph5= new google.maps.LatLng(4.62374507787803,-74.1930748009495);
var Ph6= new google.maps.LatLng(4.62377383939467,-74.1933301560788);
var Ph7= new google.maps.LatLng(4.62375831758471,-74.1935856837403);
var Ph8= new google.maps.LatLng(4.62370473968175,-74.1938272234125);
var Ph9= new google.maps.LatLng(4.6236221620979,-74.1940435622009);
var Ph10= new google.maps.LatLng(4.62352122123389,-74.1942271716169);
var Ph11= new google.maps.LatLng(4.62341281886315,-74.1943744365116);
var Ph12= new google.maps.LatLng(4.62330692887334,-74.1944854027565);
var Ph13= new google.maps.LatLng(4.62321167125462,-74.1945631410483);
var Ph14= new google.maps.LatLng(4.6231327368969,-74.1946128683564);
var Ph15= new google.maps.LatLng(4.62307318006254,-74.1946409801049);
var Ph16= new google.maps.LatLng(4.62303353942409,-74.1946541290866);
var Ph17= new google.maps.LatLng(4.62301221314764,-74.194658451631);
var Ph18= new google.maps.LatLng(4.62300599994493,-74.194659000417);
var Ph19= new google.maps.LatLng(4.62301072182628,-74.1946594067366);
var Ph20= new google.maps.LatLng(4.62302185669098,-74.1946617683229);
var Ph21= new google.maps.LatLng(4.62303512238728,-74.1946667417001);
var Ph22= new google.maps.LatLng(4.6230469637205,-74.1946738064108);
var Ph23= new google.maps.LatLng(4.62305490010708,-74.1946816573829);
var Ph24= new google.maps.LatLng(4.62305769878328,-74.1946886683884);
var Ph25= new google.maps.LatLng(4.62305535204289,-74.1946933553804);
var Ph26= new google.maps.LatLng(4.62304886166022,-74.1946947596647);
var Ph27= new google.maps.LatLng(4.62303986805364,-74.1946926757282);
var Ph28= new google.maps.LatLng(4.62303019844115,-74.1946876739056);
var Ph29= new google.maps.LatLng(4.62302143410597,-74.1946809140399);
var Ph30= new google.maps.LatLng(4.62301459828072,-74.1946738032279);
var Ph31= new google.maps.LatLng(4.62301003601195,-74.1946676005892);
var Ph32= new google.maps.LatLng(4.62300750031643,-74.1946630940488);
var Ph33= new google.maps.LatLng(4.62300639266201,-74.1946604544282);
var Ph34= new google.maps.LatLng(4.62300605547064,-74.1946593121708);
var Ph35= new google.maps.LatLng(4.62300600176484,-74.1946590208801);
var Ph36= new google.maps.LatLng(4.62300599994493,-74.194659000417);
var Ph37= new google.maps.LatLng(4.62300599817155,-74.1946590208842);
var Ph38= new google.maps.LatLng(4.6230059451282,-74.1946593122954);
var Ph39= new google.maps.LatLng(4.62300561053489,-74.1946604553113);
var Ph40= new google.maps.LatLng(4.62300450888511,-74.1946630974263);
var Ph41= new google.maps.LatLng(4.62300198344273,-74.1946676096811);
var Ph42= new google.maps.LatLng(4.62299743528868,-74.1946738226058);
var Ph43= new google.maps.LatLng(4.62299061564876,-74.1946809488352);
var Ph44= new google.maps.LatLng(4.62298186670578,-74.1946877284736);
var Ph45= new google.maps.LatLng(4.62297220849051,-74.1946927521175);
var Ph46= new google.maps.LatLng(4.62296321964509,-74.1946948563563);
var Ph47= new google.maps.LatLng(4.62295672608626,-74.1946934667314);
var Ph48= new google.maps.LatLng(4.6229543686953,-74.1946887850511);
var Ph49= new google.maps.LatLng(4.62295715142362,-74.194681767745);
var Ph50= new google.maps.LatLng(4.62296506993917,-74.194673898873);
var Ph51= new google.maps.LatLng(4.6229768951789,-74.1946668074421);
var Ph52= new google.maps.LatLng(4.62299014953307,-74.1946618041224);
var Ph53= new google.maps.LatLng(4.62300127899956,-74.1946594173982);
var Ph54= new google.maps.LatLng(4.62300599994493,-74.194659000417);
var Ph55= new google.maps.LatLng(4.62299978551037,-74.1946584656627);
var Ph56= new google.maps.LatLng(4.62297844946026,-74.1946541912875);
var Ph57= new google.maps.LatLng(4.62293877902565,-74.1946411318567);
var Ph58= new google.maps.LatLng(4.62287915842246,-74.194613154681);
var Ph59= new google.maps.LatLng(4.62280011118967,-74.1945636057843);
var Ph60= new google.maps.LatLng(4.6227046770279,-74.1944860828883);
var Ph61= new google.maps.LatLng(4.62259853492805,-74.1943753562205);
var Ph62= new google.maps.LatLng(4.62248979784178,-74.1942283367915);
var Ph63= new google.maps.LatLng(4.62238843948269,-74.1940449562255);
var Ph64= new google.maps.LatLng(4.62230536976837,-74.1938288050317);
var Ph65= new google.maps.LatLng(4.6222512421536,-74.1935873876024);
var Ph66= new google.maps.LatLng(4.62223513851493,-74.1933318962463);
var Ph67= new google.maps.LatLng(4.62226331829672,-74.1930764772514);
var Ph68= new google.maps.LatLng(4.62233822590184,-74.192837045307);
var Ph69= new google.maps.LatLng(4.62245792016194,-74.19262978001);
var Ph70= new google.maps.LatLng(4.62261602857335,-74.1924694928457);
var Ph71= new google.maps.LatLng(4.62280225029513,-74.192368075144);
var Ph72= new google.maps.LatLng(4.62300335201773,-74.1923332259559);

             var flightPath3 = new google.maps.Polygon({
                 path: [Ph0, Ph1, Ph2, Ph3, Ph4, Ph5, Ph6, Ph7, Ph8, Ph9, Ph10, Ph11, Ph12, Ph13, Ph14, Ph15, Ph16, Ph17, Ph18, Ph19, Ph20, Ph21, Ph22, Ph23, Ph24, Ph25, Ph26, Ph27, Ph28, Ph29, Ph30, Ph31, Ph32, Ph33, Ph34, Ph35, Ph36, Ph37, Ph38, Ph39, Ph40, Ph41, Ph42, Ph43, Ph44, Ph45, Ph46, Ph47, Ph48, Ph49, Ph50, Ph51, Ph52, Ph53, Ph54, Ph55, Ph56, Ph57, Ph58, Ph59, Ph60, Ph61, Ph62, Ph63, Ph64, Ph65, Ph66, Ph67, Ph68, Ph69, Ph70, Ph71, Ph72],

                 strokeColor: "#0000FF",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#0000FF",
                 fillOpacity: 0.1
             });
             //Fin RDS1

             // RDS2
var Pi0= new google.maps.LatLng(4.5845547171763,-74.0981287507777);
var Pi1= new google.maps.LatLng(4.58484868973354,-74.0981789685506);
var Pi2= new google.maps.LatLng(4.5851211532813,-74.0983265031);
var Pi3= new google.maps.LatLng(4.58535274417898,-74.0985601514455);
var Pi4= new google.maps.LatLng(4.58552836895619,-74.0988625748371);
var Pi5= new google.maps.LatLng(4.58563866400212,-74.099212154003);
var Pi6= new google.maps.LatLng(4.58568073603222,-74.0995852551577);
var Pi7= new google.maps.LatLng(4.58565810096097,-74.0999586162567);
var Pi8= new google.maps.LatLng(4.58557985553768,-74.1003115458493);
var Pi9= new google.maps.LatLng(4.58545923106329,-74.1006276588504);
var Pi10= new google.maps.LatLng(4.58531176819261,-74.1008959532932);
var Pi11= new google.maps.LatLng(4.58515339604373,-74.1011111450635);
var Pi12= new google.maps.LatLng(4.58499868855094,-74.1012732994363);
var Pi13= new google.maps.LatLng(4.58485951125393,-74.1013869016708);
var Pi14= new google.maps.LatLng(4.58474418065065,-74.1014595734306);
var Pi15= new google.maps.LatLng(4.58465716078584,-74.1015006587118);
var Pi16= new google.maps.LatLng(4.58459923995036,-74.1015198779974);
var Pi17= new google.maps.LatLng(4.58456807861987,-74.1015261975254);
var Pi18= new google.maps.LatLng(4.58455899994445,-74.1015270004619);
var Pi19= new google.maps.LatLng(4.58456589966017,-74.1015275933173);
var Pi20= new google.maps.LatLng(4.5845821704147,-74.1015310419392);
var Pi21= new google.maps.LatLng(4.58460155521595,-74.1015383063441);
var Pi22= new google.maps.LatLng(4.58461885909821,-74.101548626702);
var Pi23= new google.maps.LatLng(4.58463045718584,-74.101560096573);
var Pi24= new google.maps.LatLng(4.58463454786897,-74.1015703400482);
var Pi25= new google.maps.LatLng(4.58463111962492,-74.1015771887488);
var Pi26= new google.maps.LatLng(4.58462163608347,-74.101579241725);
var Pi27= new google.maps.LatLng(4.58460849419838,-74.1015761984085);
var Pi28= new google.maps.LatLng(4.58459436401333,-74.1015688918097);
var Pi29= new google.maps.LatLng(4.5845815563147,-74.1015590163287);
var Pi30= new google.maps.LatLng(4.58457156650534,-74.1015486277324);
var Pi31= new google.maps.LatLng(4.58456489899208,-74.1015395656933);
var Pi32= new google.maps.LatLng(4.58456119302068,-74.1015329815125);
var Pi33= new google.maps.LatLng(4.58455957404223,-74.1015291248874);
var Pi34= new google.maps.LatLng(4.58455908113409,-74.1015274559639);
var Pi35= new google.maps.LatLng(4.58455900260733,-74.1015270303608);
var Pi36= new google.maps.LatLng(4.58455899994445,-74.1015270004619);
var Pi37= new google.maps.LatLng(4.5845589973568,-74.1015270303673);
var Pi38= new google.maps.LatLng(4.58455891990102,-74.1015274561653);
var Pi39= new google.maps.LatLng(4.58455843119312,-74.1015291263149);
var Pi40= new google.maps.LatLng(4.58455682192227,-74.1015329869726);
var Pi41= new google.maps.LatLng(4.58455313252688,-74.101539580391);
var Pi42= new google.maps.LatLng(4.58454648783253,-74.1015486590585);
var Pi43= new google.maps.LatLng(4.58453652418953,-74.1015590725782);
var Pi44= new google.maps.LatLng(4.58452374137495,-74.1015689800232);
var Pi45= new google.maps.LatLng(4.58450962961537,-74.1015763218974);
var Pi46= new google.maps.LatLng(4.58449649542745,-74.101579398034);
var Pi47= new google.maps.LatLng(4.58448700675121,-74.1015773687558);
var Pi48= new google.maps.LatLng(4.58448356128879,-74.1015705286424);
var Pi49= new google.maps.LatLng(4.58448762618952,-74.1015602749822);
var Pi50= new google.maps.LatLng(4.5844991953856,-74.1015487761751);
var Pi51= new google.maps.LatLng(4.58451647324991,-74.101538412622);
var Pi52= new google.maps.LatLng(4.58453583971457,-74.1015310998125);
var Pi53= new google.maps.LatLng(4.58455210174192,-74.1015276105529);
var Pi54= new google.maps.LatLng(4.58455899994445,-74.1015270004619);
var Pi55= new google.maps.LatLng(4.58454991927752,-74.101526220209);
var Pi56= new google.maps.LatLng(4.58451874214611,-74.1015199785512);
var Pi57= new google.maps.LatLng(4.58446077313943,-74.1015009040346);
var Pi58= new google.maps.LatLng(4.58437365017923,-74.1014600363096);
var Pi59= new google.maps.LatLng(4.58425813708744,-74.101387652988);
var Pi60= new google.maps.LatLng(4.58411867436093,-74.1012743990067);
var Pi61= new google.maps.LatLng(4.5839635592493,-74.101112632022);
var Pi62= new google.maps.LatLng(4.58380464589591,-74.1008978372197);
var Pi63= new google.maps.LatLng(4.58365650793098,-74.1006299129546);
var Pi64= new google.maps.LatLng(4.58353508761545,-74.1003141035017);
var Pi65= new google.maps.LatLng(4.58345595315687,-74.0999613718442);
var Pi66= new google.maps.LatLng(4.58343237701949,-74.099588069736);
var Pi67= new google.maps.LatLng(4.58347350804466,-74.0992148655489);
var Pi68= new google.maps.LatLng(4.58358292083871,-74.0988650121764);
var Pi69= new google.maps.LatLng(4.58375778184663,-74.0985621503525);
var Pi70= new google.maps.LatLng(4.58398878218891,-74.0983279226268);
var Pi71= new google.maps.LatLng(4.58426087236286,-74.0981797055519);
var Pi72= new google.maps.LatLng(4.5845547171763,-74.0981287507777);

             var flightPath4 = new google.maps.Polygon({
                 path: [Pi0, Pi1, Pi2, Pi3, Pi4, Pi5, Pi6, Pi7, Pi8, Pi9, Pi10, Pi11, Pi12, Pi13, Pi14, Pi15, Pi16, Pi17, Pi18, Pi19, Pi20, Pi21, Pi22, Pi23, Pi24, Pi25, Pi26, Pi27, Pi28, Pi29, Pi30, Pi31, Pi32, Pi33, Pi34, Pi35, Pi36, Pi37, Pi38, Pi39, Pi40, Pi41, Pi42, Pi43, Pi44, Pi45, Pi46, Pi47, Pi48, Pi49, Pi50, Pi51, Pi52, Pi53, Pi54, Pi55, Pi56, Pi57, Pi58, Pi59, Pi60, Pi61, Pi62, Pi63, Pi64, Pi65, Pi66, Pi67, Pi68, Pi69, Pi70, Pi71, Pi72],

                 strokeColor: "#0000FF",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#0000FF",
                 fillOpacity: 0.1
             });
             //Fin RDS2

             // RDS3
var Pj0= new google.maps.LatLng(4.76044379902037,-74.0359516773987);
var Pj1= new google.maps.LatLng(4.76064592372199,-74.0359750895185);
var Pj2= new google.maps.LatLng(4.76083910048308,-74.0360433815511);
var Pj3= new google.maps.LatLng(4.76101602610486,-74.0361493807241);
var Pj4= new google.maps.LatLng(4.76117243504312,-74.03628263926);
var Pj5= new google.maps.LatLng(4.76130807273921,-74.0364306043243);
var Pj6= new google.maps.LatLng(4.76142625129238,-74.0365818221379);
var Pj7= new google.maps.LatLng(4.76153339906946,-74.0367267706744);
var Pj8= new google.maps.LatLng(4.76163758670733,-74.0368595684231);
var Pj9= new google.maps.LatLng(4.76174662733429,-74.0369788246577);
var Pj10= new google.maps.LatLng(4.76186670031116,-74.0370870737508);
var Pj11= new google.maps.LatLng(4.76200022826746,-74.0371905645386);
var Pj12= new google.maps.LatLng(4.76214609582834,-74.0372968906424);
var Pj13= new google.maps.LatLng(4.76229814724999,-74.0374142896569);
var Pj14= new google.maps.LatLng(4.76244698187816,-74.0375491014253);
var Pj15= new google.maps.LatLng(4.76258095933772,-74.037704701703);
var Pj16= new google.maps.LatLng(4.7626877993398,-74.0378807724624);
var Pj17= new google.maps.LatLng(4.76275685397272,-74.0380731472382);
var Pj18= new google.maps.LatLng(4.76278074248966,-74.0382745665991);
var Pj19= new google.maps.LatLng(4.76275725372258,-74.038476037522);
var Pj20= new google.maps.LatLng(4.76268873920149,-74.0386685892978);
var Pj21= new google.maps.LatLng(4.76258239506585,-74.0388449423335);
var Pj22= new google.maps.LatLng(4.76244870308276,-74.039000844907);
var Pj23= new google.maps.LatLng(4.76230025688719,-74.03913604333);
var Pj24= new google.maps.LatLng(4.76214854746274,-74.0392538390379);
var Pj25= new google.maps.LatLng(4.76200312773915,-74.0393606396519);
var Pj26= new google.maps.LatLng(4.76186989829986,-74.0394644897211);
var Pj27= new google.maps.LatLng(4.76175025435173,-74.0395731771038);
var Pj28= new google.maps.LatLng(4.76164165326104,-74.0396928611558);
var Pj29= new google.maps.LatLng(4.76153782588386,-74.0398259566394);
var Pj30= new google.maps.LatLng(4.76143115393455,-74.0399713517574);
var Pj31= new google.maps.LatLng(4.76131337309992,-74.0401229106426);
var Pj32= new google.maps.LatLng(4.76117812299719,-74.0402712630308);
var Pj33= new google.maps.LatLng(4.76102201697447,-74.0404048062035);
var Pj34= new google.maps.LatLng(4.76084537416243,-74.0405112996287);
var Pj35= new google.maps.LatLng(4.76065237459855,-74.040580129906);
var Pj36= new google.maps.LatLng(4.76045030131041,-74.0406039402522);
var Pj37= new google.maps.LatLng(4.76024817649479,-74.0405805267447);
var Pj38= new google.maps.LatLng(4.76005499993361,-74.0405122333804);
var Pj39= new google.maps.LatLng(4.75987807478507,-74.0404062330553);
var Pj40= new google.maps.LatLng(4.75972166649926,-74.0402729736166);
var Pj41= new google.maps.LatLng(4.75958602953957,-74.0401250079094);
var Pj42= new google.maps.LatLng(4.75946785171959,-74.0399737896737);
var Pj43= new google.maps.LatLng(4.75936070460443,-74.0398288408637);
var Pj44= new google.maps.LatLng(4.75925651753233,-74.0396960429216);
var Pj45= new google.maps.LatLng(4.75914747736743,-74.0395767865128);
var Pj46= new google.maps.LatLng(4.75902740477163,-74.039468537239);
var Pj47= new google.maps.LatLng(4.75889387714878,-74.0393650462732);
var Pj48= new google.maps.LatLng(4.75874800990579,-74.039258720029);
var Pj49= new google.maps.LatLng(4.75859595882424,-74.0391413209926);
var Pj50= new google.maps.LatLng(4.75844712457348,-74.0390065094002);
var Pj51= new google.maps.LatLng(4.75831314752984,-74.0388509095789);
var Pj52= new google.maps.LatLng(4.75820630795838,-74.0386748395984);
var Pj53= new google.maps.LatLng(4.75813725372862,-74.0384824658992);
var Pj54= new google.maps.LatLng(4.75811336554196,-74.0382810478396);
var Pj55= new google.maps.LatLng(4.75813685452786,-74.0380795783021);
var Pj56= new google.maps.LatLng(4.75820536913805,-74.0378870278579);
var Pj57= new google.maps.LatLng(4.75831155452281,-74.0377106338236);
var Pj58= new google.maps.LatLng(4.75844540508289,-74.0375547743036);
var Pj59= new google.maps.LatLng(4.75859385106724,-74.0374195765253);
var Pj60= new google.maps.LatLng(4.75874556023515,-74.0373017812387);
var Pj61= new google.maps.LatLng(4.75889097966697,-74.0371949808971);
var Pj62= new google.maps.LatLng(4.75902420877596,-74.037091131024);
var Pj63= new google.maps.LatLng(4.75914385234237,-74.0369824438129);
var Pj64= new google.maps.LatLng(4.75925245296929,-74.0368627599428);
var Pj65= new google.maps.LatLng(4.75935627978046,-74.0367296646376);
var Pj66= new google.maps.LatLng(4.7594630333626,-74.0365844113296);
var Pj67= new google.maps.LatLng(4.75958073105776,-74.0364327107977);
var Pj68= new google.maps.LatLng(4.7597159802582,-74.0362843582308);
var Pj69= new google.maps.LatLng(4.75987208534753,-74.0361508146023);
var Pj70= new google.maps.LatLng(4.76004872729644,-74.0360443203999);
var Pj71= new google.maps.LatLng(4.76024172616563,-74.0359754890439);
var Pj72= new google.maps.LatLng(4.76044379902037,-74.0359516773987);

             var flightPath5 = new google.maps.Polygon({
                path: [Pj0, Pj1, Pj2, Pj3, Pj4, Pj5, Pj6, Pj7, Pj8, Pj9, Pj10, Pj11, Pj12, Pj13, Pj14, Pj15, Pj16, Pj17, Pj18, Pj19, Pj20, Pj21, Pj22, Pj23, Pj24, Pj25, Pj26, Pj27, Pj28, Pj29, Pj30, Pj31, Pj32, Pj33, Pj34, Pj35, Pj36, Pj37, Pj38, Pj39, Pj40, Pj41, Pj42, Pj43, Pj44, Pj45, Pj46, Pj47, Pj48, Pj49, Pj50, Pj51, Pj52, Pj53, Pj54, Pj55, Pj56, Pj57, Pj58, Pj59, Pj60, Pj61, Pj62, Pj63, Pj64, Pj65, Pj66, Pj67, Pj68, Pj69, Pj70, Pj71, Pj72],

                 strokeColor: "#0000FF",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#0000FF",
                 fillOpacity: 0.1
             });
             //Fin RDS3


             var deviceMarker = "RDS.png";
             var antenaMarker = "bts2.png";

             var markerDevice = new google.maps.Marker({ position: myCenterDevice, icon: deviceMarker });
             var infowindowD = new google.maps.InfoWindow({
                 content: name
             });


             var myCenter = new google.maps.LatLng(4.52025, -74.102806);
             var marker = new google.maps.Marker({ position: myCenter, icon: antenaMarker });
             var infowindow2 = new google.maps.InfoWindow({
                 content: "SANTA LIBRADA"
             });

             var myCenter2 = new google.maps.LatLng(4.743539, -74.074769);
             var marker2 = new google.maps.Marker({ position: myCenter2, icon: antenaMarker });
             var infowindow5 = new google.maps.InfoWindow({
                 content: "SUBA"
             });

             var myCenter3 = new google.maps.LatLng(4.623006, -74.194659);
             var marker3 = new google.maps.Marker({ position: myCenter3 , icon: deviceMarker});
             var infowindow6 = new google.maps.InfoWindow({
                 content: "RDS1"
             });
             var myCenter4 = new google.maps.LatLng(4.584559, -74.101527);
             var marker4 = new google.maps.Marker({ position: myCenter4 , icon: deviceMarker});
             var infowindow7 = new google.maps.InfoWindow({
                 content: "RDS2"
             });
             var myCenter5 = new google.maps.LatLng(4.760447054149487, -74.03827780748605);
             var marker5 = new google.maps.Marker({ position: myCenter5 , icon: deviceMarker});
             var infowindow8 = new google.maps.InfoWindow({
                 content: "RDS3"
             });
             var i;
             google.maps.event.addListener(markerDevice, 'click', (function (markerDevice, i) {
                 return function () {
                     infowindowD.setContent(markerDevice);
                     infowindowD.open(map, markerDevice);
                 }
             })
                 (markerDevice, i));



             var k;
             google.maps.event.addListener(marker, 'click', (function (marker, k) {
                 return function () {
                     infowindow2.setContent(marker);
                     infowindow2.open(map, marker);
                 }
             })
                 (marker, k));



             var m;
             google.maps.event.addListener(marker2, 'click', (function (marker2, m) {
                 return function () {
                     infowindow5.setContent(marker2);
                     infowindow5.open(map, marker2);
                 }
             })
                 (marker2, m));
             var n;
             google.maps.event.addListener(marker3, 'click', (function (marker3, m) {
                 return function () {
                     infowindow6.setContent(marker3);
                     infowindow6.open(map, marker3);
                 }
             })
                 (marker3, n));

              var o;
             google.maps.event.addListener(marker4, 'click', (function (marker4, o) {
                 return function () {
                     infowindow7.setContent(marker4);
                     infowindow7.open(map, marker4);
                 }
             })
                 (marker4, o));
             var p;
             google.maps.event.addListener(marker5, 'click', (function (marker5, p) {
                 return function () {
                     infowindow8.setContent(marker5);
                     infowindow8.open(map, marker5);
                 }
             })
                 (marker5, p));


             marker.setMap(map);//Sta Librada
             marker2.setMap(map);//Suba
             marker3.setMap(map)//rds1
             marker4.setMap(map)//rds2
             marker5.setMap(map)//rds3
             markerDevice.setMap(map);

             flightPath0.setMap(map); //Dispositivo RDS
             flightPath.setMap(map);   //Sta Librada
             flightPath2.setMap(map); // Suba
             flightPath3.setMap(map); //RDS1
             flightPath4.setMap(map); //RDS2
             flightPath5.setMap(map); //RDS3

             //Modelo 2 Fin

         });

         }

    function myMap3(lat, long, name) {
        var lati = [];
        lati = Grafiquinha();
        lati.success(function (data) {
            puntosLat = JSON.parse(data.d);
            console.log(strtofloat(puntosLat[0]));


            var myCenterDevice = new google.maps.LatLng(lat, long);
             var mapOptions = { center: myCenterDevice, zoom: 15 };
             var mapCanvas = document.getElementById("ModalMapPreview");
             var map = new google.maps.Map(mapCanvas, {
                 zoom: 15,
                 center: new google.maps.LatLng(lat, long),
             });


                 // Graficadinamica
        var PC = new google.maps.LatLng(lat, long);
        var Pa0 = new google.maps.LatLng(strtofloat(puntosLat[0]), strtofloat(puntosLat[1]));
        var Pa1 = new google.maps.LatLng(strtofloat(puntosLat[2]), strtofloat(puntosLat[3]));
        var Pa2 = new google.maps.LatLng(strtofloat(puntosLat[4]), strtofloat(puntosLat[5]));
        var Pa3 = new google.maps.LatLng(strtofloat(puntosLat[6]), strtofloat(puntosLat[7]));
        var Pa4 = new google.maps.LatLng(strtofloat(puntosLat[8]), strtofloat(puntosLat[9]));
        var Pa5 = new google.maps.LatLng(strtofloat(puntosLat[10]), strtofloat(puntosLat[11]));
        var Pa6 = new google.maps.LatLng(strtofloat(puntosLat[12]), strtofloat(puntosLat[13]));
        var Pa7 = new google.maps.LatLng(strtofloat(puntosLat[14]), strtofloat(puntosLat[15]));
        var Pa8 = new google.maps.LatLng(strtofloat(puntosLat[16]), strtofloat(puntosLat[17]));
        var Pa9 = new google.maps.LatLng(strtofloat(puntosLat[18]), strtofloat(puntosLat[19]));
        var Pa10 = new google.maps.LatLng(strtofloat(puntosLat[20]), strtofloat(puntosLat[21]));
        var Pa11 = new google.maps.LatLng(strtofloat(puntosLat[22]), strtofloat(puntosLat[23]));
        var Pa12 = new google.maps.LatLng(strtofloat(puntosLat[24]), strtofloat(puntosLat[25]));
        var Pa13 = new google.maps.LatLng(strtofloat(puntosLat[26]), strtofloat(puntosLat[27]));
        var Pa14 = new google.maps.LatLng(strtofloat(puntosLat[28]), strtofloat(puntosLat[29]));
        var Pa15 = new google.maps.LatLng(strtofloat(puntosLat[30]), strtofloat(puntosLat[31]));
        var Pa16 = new google.maps.LatLng(strtofloat(puntosLat[32]), strtofloat(puntosLat[33]));
        var Pa17 = new google.maps.LatLng(strtofloat(puntosLat[34]), strtofloat(puntosLat[35]));
        var Pa18 = new google.maps.LatLng(strtofloat(puntosLat[36]), strtofloat(puntosLat[37]));
        var Pa19 = new google.maps.LatLng(strtofloat(puntosLat[38]), strtofloat(puntosLat[39]));
        var Pa20 = new google.maps.LatLng(strtofloat(puntosLat[40]), strtofloat(puntosLat[41]));
        var Pa21 = new google.maps.LatLng(strtofloat(puntosLat[42]), strtofloat(puntosLat[43]));
        var Pa22 = new google.maps.LatLng(strtofloat(puntosLat[44]), strtofloat(puntosLat[45]));
        var Pa23 = new google.maps.LatLng(strtofloat(puntosLat[46]), strtofloat(puntosLat[47]));
        var Pa24 = new google.maps.LatLng(strtofloat(puntosLat[48]), strtofloat(puntosLat[49]));
        var Pa25 = new google.maps.LatLng(strtofloat(puntosLat[50]), strtofloat(puntosLat[51]));
        var Pa26 = new google.maps.LatLng(strtofloat(puntosLat[52]), strtofloat(puntosLat[53]));
        var Pa27 = new google.maps.LatLng(strtofloat(puntosLat[54]), strtofloat(puntosLat[55]));
        var Pa28 = new google.maps.LatLng(strtofloat(puntosLat[56]), strtofloat(puntosLat[57]));
        var Pa29 = new google.maps.LatLng(strtofloat(puntosLat[58]), strtofloat(puntosLat[59]));
        var Pa30 = new google.maps.LatLng(strtofloat(puntosLat[60]), strtofloat(puntosLat[61]));
        var Pa31 = new google.maps.LatLng(strtofloat(puntosLat[62]), strtofloat(puntosLat[63]));
        var Pa32 = new google.maps.LatLng(strtofloat(puntosLat[64]), strtofloat(puntosLat[65]));
        var Pa33 = new google.maps.LatLng(strtofloat(puntosLat[66]), strtofloat(puntosLat[67]));
        var Pa34 = new google.maps.LatLng(strtofloat(puntosLat[68]), strtofloat(puntosLat[69]));
        var Pa35 = new google.maps.LatLng(strtofloat(puntosLat[70]), strtofloat(puntosLat[71]));
        var Pa36 = new google.maps.LatLng(strtofloat(puntosLat[72]), strtofloat(puntosLat[73]));
        var Pa37 = new google.maps.LatLng(strtofloat(puntosLat[74]), strtofloat(puntosLat[75]));
        var Pa38 = new google.maps.LatLng(strtofloat(puntosLat[76]), strtofloat(puntosLat[77]));
        var Pa39 = new google.maps.LatLng(strtofloat(puntosLat[78]), strtofloat(puntosLat[79]));
        var Pa40 = new google.maps.LatLng(strtofloat(puntosLat[80]), strtofloat(puntosLat[81]));
        var Pa41 = new google.maps.LatLng(strtofloat(puntosLat[82]), strtofloat(puntosLat[83]));
        var Pa42 = new google.maps.LatLng(strtofloat(puntosLat[84]), strtofloat(puntosLat[85]));
        var Pa43 = new google.maps.LatLng(strtofloat(puntosLat[86]), strtofloat(puntosLat[87]));
        var Pa44 = new google.maps.LatLng(strtofloat(puntosLat[88]), strtofloat(puntosLat[89]));
        var Pa45 = new google.maps.LatLng(strtofloat(puntosLat[90]), strtofloat(puntosLat[91]));
        var Pa46 = new google.maps.LatLng(strtofloat(puntosLat[92]), strtofloat(puntosLat[93]));
        var Pa47 = new google.maps.LatLng(strtofloat(puntosLat[94]), strtofloat(puntosLat[95]));
        var Pa48 = new google.maps.LatLng(strtofloat(puntosLat[96]), strtofloat(puntosLat[97]));
        var Pa49 = new google.maps.LatLng(strtofloat(puntosLat[98]), strtofloat(puntosLat[99]));
        var Pa50 = new google.maps.LatLng(strtofloat(puntosLat[100]), strtofloat(puntosLat[101]));
        var Pa51 = new google.maps.LatLng(strtofloat(puntosLat[102]), strtofloat(puntosLat[103]));
        var Pa52 = new google.maps.LatLng(strtofloat(puntosLat[104]), strtofloat(puntosLat[105]));
        var Pa53 = new google.maps.LatLng(strtofloat(puntosLat[106]), strtofloat(puntosLat[107]));
        var Pa54 = new google.maps.LatLng(strtofloat(puntosLat[108]), strtofloat(puntosLat[109]));
        var Pa55 = new google.maps.LatLng(strtofloat(puntosLat[110]), strtofloat(puntosLat[111]));
        var Pa56 = new google.maps.LatLng(strtofloat(puntosLat[112]), strtofloat(puntosLat[113]));
        var Pa57 = new google.maps.LatLng(strtofloat(puntosLat[114]), strtofloat(puntosLat[115]));
        var Pa58 = new google.maps.LatLng(strtofloat(puntosLat[116]), strtofloat(puntosLat[117]));
        var Pa59 = new google.maps.LatLng(strtofloat(puntosLat[118]), strtofloat(puntosLat[119]));
        var Pa60 = new google.maps.LatLng(strtofloat(puntosLat[120]), strtofloat(puntosLat[121]));
        var Pa61 = new google.maps.LatLng(strtofloat(puntosLat[122]), strtofloat(puntosLat[123]));
        var Pa62 = new google.maps.LatLng(strtofloat(puntosLat[124]), strtofloat(puntosLat[125]));
        var Pa63 = new google.maps.LatLng(strtofloat(puntosLat[126]), strtofloat(puntosLat[127]));
        var Pa64 = new google.maps.LatLng(strtofloat(puntosLat[128]), strtofloat(puntosLat[129]));
        var Pa65 = new google.maps.LatLng(strtofloat(puntosLat[130]), strtofloat(puntosLat[131]));
        var Pa66 = new google.maps.LatLng(strtofloat(puntosLat[132]), strtofloat(puntosLat[133]));
        var Pa67 = new google.maps.LatLng(strtofloat(puntosLat[134]), strtofloat(puntosLat[135]));
        var Pa68 = new google.maps.LatLng(strtofloat(puntosLat[136]), strtofloat(puntosLat[137]));
        var Pa69 = new google.maps.LatLng(strtofloat(puntosLat[138]), strtofloat(puntosLat[139]));
        var Pa70 = new google.maps.LatLng(strtofloat(puntosLat[140]), strtofloat(puntosLat[141]));
        var Pa71 = new google.maps.LatLng(strtofloat(puntosLat[142]), strtofloat(puntosLat[143]));
        var Pa72 = new google.maps.LatLng(strtofloat(puntosLat[144]), strtofloat(puntosLat[145]));
 
             var flightPath0 = new google.maps.Polygon({
                 path: [Pa0,Pa1,Pa2,Pa3,Pa4,Pa5,Pa6,Pa7,Pa8,Pa9,Pa10,Pa11,Pa12,Pa13,Pa14,Pa15,Pa16,Pa17,Pa18,Pa19,Pa20,Pa21,Pa22,Pa23,Pa24,Pa25,Pa26,Pa27,Pa28,Pa29,Pa30,Pa31,Pa32,Pa33,Pa34,Pa35,Pa36,Pa37,Pa38,Pa39,Pa40,Pa41,Pa42,Pa43,Pa44,Pa45,Pa46,Pa47,Pa48,Pa49,Pa50,Pa51,Pa52,Pa53,Pa54,Pa55,Pa56,Pa57,Pa58,Pa59,Pa60,Pa61,Pa62,Pa63,Pa64,Pa65,Pa66,Pa67,Pa68,Pa69,Pa70,Pa71,Pa72],
                 strokeColor: "#0000FF",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#0000FF",
                 fillOpacity: 0.1

        });

            //Modelo 3 inicio

        var myCenterDevice = new google.maps.LatLng(lat, long);
        var mapOptions = { center: myCenterDevice, zoom: 15 };
        var mapCanvas = document.getElementById("ModalMapPreview");
        var map = new google.maps.Map(mapCanvas, {
            zoom: 15,
            center: new google.maps.LatLng(lat, long),
        });

        // Suba
        var PC = new google.maps.LatLng(lat, long);
        var Pa0 = new google.maps.LatLng(4.75291824234325, -73.9661423029136);
        var Pa1 = new google.maps.LatLng(4.75291824234325, -73.9661423029136);
        var Pa2 = new google.maps.LatLng(4.7620320159725, -73.9693590821436);
        var Pa3 = new google.maps.LatLng(4.77037784757928, -73.9743630308198);
        var Pa4 = new google.maps.LatLng(4.77775812383751, -73.9806448357575);
        var Pa5 = new google.maps.LatLng(4.78415483366448, -73.9876303668593);
        var Pa6 = new google.maps.LatLng(4.78972956302621, -73.9947644600151);
        var Pa7 = new google.maps.LatLng(4.79478914655764, -74.0015950939752);
        var Pa8 = new google.maps.LatLng(4.79970398566195, -74.0078608896869);
        var Pa9 = new google.maps.LatLng(4.83108488165285, -73.9872563969952);
        var Pa10 = new google.maps.LatLng(4.83916516585896, -73.9945563757961);
        var Pa11 = new google.maps.LatLng(4.84816891979863, -74.0015213312327);
        var Pa12 = new google.maps.LatLng(4.85798728762837, -74.0086891458548);
        var Pa13 = new google.maps.LatLng(4.86823705137434, -74.0165943713588);
        var Pa14 = new google.maps.LatLng(4.87826946088795, -74.0256746521013);
        var Pa15 = new google.maps.LatLng(4.8872899657635, -74.0361599767794);
        var Pa16 = new google.maps.LatLng(4.89449177259227, -74.0480222225708);
        var Pa17 = new google.maps.LatLng(4.89911237799846, -74.0609872096897);
        var Pa18 = new google.maps.LatLng(4.90721518927529, -74.0745473176789);
        var Pa19 = new google.maps.LatLng(4.90556651402448, -74.0886806475274);
        var Pa20 = new google.maps.LatLng(4.90075768807729, -74.1021875998455);
        var Pa21 = new google.maps.LatLng(4.89329574710928, -74.1145574218252);
        var Pa22 = new google.maps.LatLng(4.88392335031262, -74.1254945383078);
        var Pa23 = new google.maps.LatLng(4.87350700076343, -74.1349757121949);
        var Pa24 = new google.maps.LatLng(4.86286401459662, -74.1432362565643);
        var Pa25 = new google.maps.LatLng(4.85267054374187, -74.1507307505718);
        var Pa26 = new google.maps.LatLng(4.84331711440801, -74.1580075727453);
        var Pa27 = new google.maps.LatLng(4.80881921631605, -74.1396707107442);
        var Pa28 = new google.maps.LatLng(4.80529480278136, -74.1479378564178);
        var Pa29 = new google.maps.LatLng(4.79817324983924, -74.1523307148815);
        var Pa30 = new google.maps.LatLng(4.79441030414714, -74.1623376192432);
        var Pa31 = new google.maps.LatLng(4.78692752529564, -74.1672075753797);
        var Pa32 = new google.maps.LatLng(4.78132713830224, -74.1778489248276);
        var Pa33 = new google.maps.LatLng(4.77232974789133, -74.1813309476376);
        var Pa34 = new google.maps.LatLng(4.76411819874827, -74.1902528031025);
        var Pa35 = new google.maps.LatLng(4.75380832886435, -74.190100470007);
        var Pa36 = new google.maps.LatLng(4.74370524068703, -74.2085041103473);
        var Pa37 = new google.maps.LatLng(4.7320852153521, -74.2071461742014);
        var Pa38 = new google.maps.LatLng(4.72098105429057, -74.2032130073373);
        var Pa39 = new google.maps.LatLng(4.71081223603214, -74.1971135922417);
        var Pa40 = new google.maps.LatLng(4.7056818049691, -74.1788448939459);
        var Pa41 = new google.maps.LatLng(4.69716378629172, -74.1742194528599);
        var Pa42 = new google.maps.LatLng(4.69080159270995, -74.1660773681737);
        var Pa43 = new google.maps.LatLng(4.68503293492422, -74.158273189069);
        var Pa44 = new google.maps.LatLng(4.67942275900094, -74.151123880428);
        var Pa45 = new google.maps.LatLng(4.67178913454301, -74.1464634733255);
        var Pa46 = new google.maps.LatLng(4.66516318531603, -74.1404860260883);
        var Pa47 = new google.maps.LatLng(4.65779019417998, -74.1347745608417);
        var Pa48 = new google.maps.LatLng(4.6497383150819, -74.1289045917298);
        var Pa49 = new google.maps.LatLng(4.64500929732965, -74.1207151421558);
        var Pa50 = new google.maps.LatLng(4.63708464052007, -74.1135412267579);
        var Pa51 = new google.maps.LatLng(4.62995943023396, -74.1052582670912);
        var Pa52 = new google.maps.LatLng(4.63531365762694, -74.0939336413485);
        var Pa53 = new google.maps.LatLng(4.63197748106223, -74.0846438361567);
        var Pa54 = new google.maps.LatLng(4.61338443356222, -74.0749398535535);
        var Pa55 = new google.maps.LatLng(4.61469399436031, -74.0637058210562);
        var Pa56 = new google.maps.LatLng(4.63701912400096, -74.0561953775738);
        var Pa57 = new google.maps.LatLng(4.64207278052122, -74.0478171627815);
        var Pa58 = new google.maps.LatLng(4.66009740915991, -74.0446263267874);
        var Pa59 = new google.maps.LatLng(4.66410067064905, -74.0379794154776);
        var Pa60 = new google.maps.LatLng(4.67060683117505, -74.032932465544);
        var Pa61 = new google.maps.LatLng(4.67252528095399, -74.0253528874825);
        var Pa62 = new google.maps.LatLng(4.6786080156262, -74.0206161691124);
        var Pa63 = new google.maps.LatLng(4.68205949698598, -74.0136606007611);
        var Pa64 = new google.maps.LatLng(4.68718837190323, -74.0080214830512);
        var Pa65 = new google.maps.LatLng(4.69207994826868, -74.0017352326442);
        var Pa66 = new google.maps.LatLng(4.69711583916676, -73.9948827792934);
        var Pa67 = new google.maps.LatLng(4.70163962330847, -73.9855363304097);
        var Pa68 = new google.maps.LatLng(4.70818212905927, -73.978366364057);
        var Pa69 = new google.maps.LatLng(4.71572688459135, -73.9718921955359);
        var Pa70 = new google.maps.LatLng(4.7242707427399, -73.9667426698082);
        var Pa71 = new google.maps.LatLng(4.73360627410999, -73.9634227872475);
        var Pa72 = new google.maps.LatLng(4.74338324192758, -73.9650293904591);


        var flightPath = new google.maps.Polygon({
            path: [Pa0, Pa1, Pa2, Pa3, Pa4, Pa5, Pa6, Pa7, Pa8, Pa9, Pa10, Pa11, Pa12, Pa13, Pa14, Pa15, Pa16, Pa17, Pa18, Pa19, Pa20, Pa21, Pa22, Pa23, Pa24, Pa25, Pa26, Pa27, Pa28, Pa29, Pa30, Pa31, Pa32, Pa33, Pa34, Pa35, Pa36, Pa37, Pa38, Pa39, Pa40, Pa41, Pa42, Pa43, Pa44, Pa45, Pa46, Pa47, Pa48, Pa49, Pa50, Pa51, Pa52, Pa53, Pa54, Pa55, Pa56, Pa57, Pa58, Pa59, Pa60, Pa61, Pa62, Pa63, Pa64, Pa65, Pa66, Pa67, Pa68, Pa69, Pa70, Pa71, Pa72],
            strokeColor: "#DF0101",
            strokeOpacity: 0.4,
            strokeWeight: 2,
            fillColor: "#DF0101",
            fillOpacity: 0.1
        });


        // SANTA LIBRADA
        var Pf0 = new google.maps.LatLng(4.52009426982021, -73.9848351243515);
        var Pf1 = new google.maps.LatLng(4.53034835559639, -73.9860239618496);
        var Pf2 = new google.maps.LatLng(4.54014750877051, -73.989493051933);
        var Pf3 = new google.maps.LatLng(4.55262857038832, -73.9817576090589);
        var Pf4 = new google.maps.LatLng(4.56152770584163, -73.9893341414862);
        var Pf5 = new google.maps.LatLng(4.56924534902496, -73.9977477821806);
        var Pf6 = new google.maps.LatLng(4.57596520428793, -74.0063550480195);
        var Pf7 = new google.maps.LatLng(4.57537141812053, -74.0241465743314);
        var Pf8 = new google.maps.LatLng(4.58065453240545, -74.0308849307428);
        var Pf9 = new google.maps.LatLng(4.58618536389209, -74.0369341736718);
        var Pf10 = new google.maps.LatLng(4.58771639623436, -74.0462479653391);
        var Pf11 = new google.maps.LatLng(4.59405754179348, -74.0511674041127);
        var Pf12 = new google.maps.LatLng(4.59108425182838, -74.06193445871);
        var Pf13 = new google.maps.LatLng(4.59742111371058, -74.0668285244286);
        var Pf14 = new google.maps.LatLng(4.6090166853524, -74.0704841230298);
        var Pf15 = new google.maps.LatLng(4.61496485355782, -74.0773884568044);
        var Pf16 = new google.maps.LatLng(4.6197043850775, -74.0852023105512);
        var Pf17 = new google.maps.LatLng(4.65271628805296, -74.0910894536887);
        var Pf18 = new google.maps.LatLng(4.65408744122406, -74.102638945768);
        var Pf19 = new google.maps.LatLng(4.64617592382886, -74.1136273498911);
        var Pf20 = new google.maps.LatLng(4.65489888077521, -74.1262944634359);
        var Pf21 = new google.maps.LatLng(4.64851261748541, -74.1368857214412);
        var Pf22 = new google.maps.LatLng(4.65508671636425, -74.1515261038776);
        var Pf23 = new google.maps.LatLng(4.64507890365179, -74.1606280389629);
        var Pf24 = new google.maps.LatLng(4.65222990903917, -74.1785286508459);
        var Pf25 = new google.maps.LatLng(4.61140696064118, -74.1662476100879);
        var Pf26 = new google.maps.LatLng(4.60359654394623, -74.1723263754624);
        var Pf27 = new google.maps.LatLng(4.59659015740861, -74.1786956901062);
        var Pf28 = new google.maps.LatLng(4.5907213119577, -74.1862925135646);
        var Pf29 = new google.maps.LatLng(4.5846005242753, -74.1941535144227);
        var Pf30 = new google.maps.LatLng(4.57829598082386, -74.2027177631951);
        var Pf31 = new google.maps.LatLng(4.57134760364313, -74.2116650898509);
        var Pf32 = new google.maps.LatLng(4.55869570830862, -74.2076782781031);
        var Pf33 = new google.maps.LatLng(4.55047874783042, -74.2146997120824);
        var Pf34 = new google.maps.LatLng(4.54118167768162, -74.2202975962422);
        var Pf35 = new google.maps.LatLng(4.53102454893828, -74.2239121116077);
        var Pf36 = new google.maps.LatLng(4.52039123088936, -74.2251702612211);
        var Pf37 = new google.maps.LatLng(4.50596815782093, -74.2675856419907);
        var Pf38 = new google.maps.LatLng(4.49214332280191, -74.262680480129);
        var Pf39 = new google.maps.LatLng(4.47948119129983, -74.2550927639171);
        var Pf40 = new google.maps.LatLng(4.46828411950619, -74.2455661157789);
        var Pf41 = new google.maps.LatLng(4.45858082992716, -74.2349682758003);
        var Pf42 = new google.maps.LatLng(4.45935443020592, -74.2081786253442);
        var Pf43 = new google.maps.LatLng(4.45270042959104, -74.1991642989029);
        var Pf44 = new google.maps.LatLng(4.4462246763067, -74.1909135345448);
        var Pf45 = new google.maps.LatLng(4.44819816337639, -74.1747651239157);
        var Pf46 = new google.maps.LatLng(4.44571571262037, -74.1652701231991);
        var Pf47 = new google.maps.LatLng(4.42407666458323, -74.1700696090224);
        var Pf48 = new google.maps.LatLng(4.41505190005251, -74.1634850344938);
        var Pf49 = new google.maps.LatLng(4.40563809357776, -74.1562192286814);
        var Pf50 = new google.maps.LatLng(4.39642326071929, -74.1478758640296);
        var Pf51 = new google.maps.LatLng(4.40243821525408, -74.1344085480166);
        var Pf52 = new google.maps.LatLng(4.39654200676382, -74.1246919263301);
        var Pf53 = new google.maps.LatLng(4.39899993850564, -74.1135224857028);
        var Pf54 = new google.maps.LatLng(4.39141425471833, -74.1029621604766);
        var Pf55 = new google.maps.LatLng(4.34873216325493, -74.0880658292598);
        var Pf56 = new google.maps.LatLng(4.3538284945374, -74.0737802779795);
        var Pf57 = new google.maps.LatLng(4.36172924969107, -74.060697255172);
        var Pf58 = new google.maps.LatLng(4.37164538655243, -74.0491271247111);
        var Pf59 = new google.maps.LatLng(4.40077643868244, -74.0474805254383);
        var Pf60 = new google.maps.LatLng(4.41056237341517, -74.0398931898407);
        var Pf61 = new google.maps.LatLng(4.42843778684547, -74.0389250606771);
        var Pf62 = new google.maps.LatLng(4.43629626558732, -74.0327977608653);
        var Pf63 = new google.maps.LatLng(4.44335411809828, -74.0263848778278);
        var Pf64 = new google.maps.LatLng(4.45174046433945, -74.021667008947);
        var Pf65 = new google.maps.LatLng(4.45768960015716, -74.0140276397214);
        var Pf66 = new google.maps.LatLng(4.46381168358062, -74.0056960805851);
        var Pf67 = new google.maps.LatLng(4.47321057689302, -74.0026334659762);
        var Pf68 = new google.maps.LatLng(4.48055536406995, -73.9945784579012);
        var Pf69 = new google.maps.LatLng(4.48565705343487, -73.974843287132);
        var Pf70 = new google.maps.LatLng(4.49628784647607, -73.968438708328);
        var Pf71 = new google.maps.LatLng(4.50848189607286, -73.9707911037389);
        var Pf72 = new google.maps.LatLng(4.52009426982021, -73.9848351243515);

        var flightPath2 = new google.maps.Polygon({
            path: [Pf0, Pf1, Pf2, Pf3, Pf4, Pf5, Pf6, Pf7, Pf8, Pf9, Pf10, Pf11, Pf12, Pf13, Pf14, Pf15, Pf16, Pf17, Pf18, Pf19, Pf20, Pf21, Pf22, Pf23, Pf24, Pf25, Pf26, Pf27, Pf28, Pf29, Pf30, Pf31, Pf32, Pf33, Pf34, Pf35, Pf36, Pf37, Pf38, Pf39, Pf40, Pf41, Pf42, Pf43, Pf44, Pf45, Pf46, Pf47, Pf48, Pf49, Pf50, Pf51, Pf52, Pf53, Pf54, Pf55, Pf56, Pf57, Pf58, Pf59, Pf60, Pf61, Pf62, Pf63, Pf64, Pf65, Pf66, Pf67, Pf68, Pf69, Pf70, Pf71, Pf72],

            strokeColor: "#DF0101",
            strokeOpacity: 0.4,
            strokeWeight: 2,
            fillColor: "#DF0101",
            fillOpacity: 0.1
        });
        //Fin Sta
        // RDS1
var Ph0= new google.maps.LatLng(4.62300335201773,-74.1923332259559);
var Ph1= new google.maps.LatLng(4.62320453268704,-74.1923676196464);
var Ph2= new google.maps.LatLng(4.62339098516204,-74.192468615485);
var Ph3= new google.maps.LatLng(4.62354945856799,-74.1926285444787);
var Ph4= new google.maps.LatLng(4.6236696249107,-74.19283553866);
var Ph5= new google.maps.LatLng(4.62374507787803,-74.1930748009495);
var Ph6= new google.maps.LatLng(4.62377383939467,-74.1933301560788);
var Ph7= new google.maps.LatLng(4.62375831758471,-74.1935856837403);
var Ph8= new google.maps.LatLng(4.62370473968175,-74.1938272234125);
var Ph9= new google.maps.LatLng(4.6236221620979,-74.1940435622009);
var Ph10= new google.maps.LatLng(4.62352122123389,-74.1942271716169);
var Ph11= new google.maps.LatLng(4.62341281886315,-74.1943744365116);
var Ph12= new google.maps.LatLng(4.62330692887334,-74.1944854027565);
var Ph13= new google.maps.LatLng(4.62321167125462,-74.1945631410483);
var Ph14= new google.maps.LatLng(4.6231327368969,-74.1946128683564);
var Ph15= new google.maps.LatLng(4.62307318006254,-74.1946409801049);
var Ph16= new google.maps.LatLng(4.62303353942409,-74.1946541290866);
var Ph17= new google.maps.LatLng(4.62301221314764,-74.194658451631);
var Ph18= new google.maps.LatLng(4.62300599994493,-74.194659000417);
var Ph19= new google.maps.LatLng(4.62301072182628,-74.1946594067366);
var Ph20= new google.maps.LatLng(4.62302185669098,-74.1946617683229);
var Ph21= new google.maps.LatLng(4.62303512238728,-74.1946667417001);
var Ph22= new google.maps.LatLng(4.6230469637205,-74.1946738064108);
var Ph23= new google.maps.LatLng(4.62305490010708,-74.1946816573829);
var Ph24= new google.maps.LatLng(4.62305769878328,-74.1946886683884);
var Ph25= new google.maps.LatLng(4.62305535204289,-74.1946933553804);
var Ph26= new google.maps.LatLng(4.62304886166022,-74.1946947596647);
var Ph27= new google.maps.LatLng(4.62303986805364,-74.1946926757282);
var Ph28= new google.maps.LatLng(4.62303019844115,-74.1946876739056);
var Ph29= new google.maps.LatLng(4.62302143410597,-74.1946809140399);
var Ph30= new google.maps.LatLng(4.62301459828072,-74.1946738032279);
var Ph31= new google.maps.LatLng(4.62301003601195,-74.1946676005892);
var Ph32= new google.maps.LatLng(4.62300750031643,-74.1946630940488);
var Ph33= new google.maps.LatLng(4.62300639266201,-74.1946604544282);
var Ph34= new google.maps.LatLng(4.62300605547064,-74.1946593121708);
var Ph35= new google.maps.LatLng(4.62300600176484,-74.1946590208801);
var Ph36= new google.maps.LatLng(4.62300599994493,-74.194659000417);
var Ph37= new google.maps.LatLng(4.62300599817155,-74.1946590208842);
var Ph38= new google.maps.LatLng(4.6230059451282,-74.1946593122954);
var Ph39= new google.maps.LatLng(4.62300561053489,-74.1946604553113);
var Ph40= new google.maps.LatLng(4.62300450888511,-74.1946630974263);
var Ph41= new google.maps.LatLng(4.62300198344273,-74.1946676096811);
var Ph42= new google.maps.LatLng(4.62299743528868,-74.1946738226058);
var Ph43= new google.maps.LatLng(4.62299061564876,-74.1946809488352);
var Ph44= new google.maps.LatLng(4.62298186670578,-74.1946877284736);
var Ph45= new google.maps.LatLng(4.62297220849051,-74.1946927521175);
var Ph46= new google.maps.LatLng(4.62296321964509,-74.1946948563563);
var Ph47= new google.maps.LatLng(4.62295672608626,-74.1946934667314);
var Ph48= new google.maps.LatLng(4.6229543686953,-74.1946887850511);
var Ph49= new google.maps.LatLng(4.62295715142362,-74.194681767745);
var Ph50= new google.maps.LatLng(4.62296506993917,-74.194673898873);
var Ph51= new google.maps.LatLng(4.6229768951789,-74.1946668074421);
var Ph52= new google.maps.LatLng(4.62299014953307,-74.1946618041224);
var Ph53= new google.maps.LatLng(4.62300127899956,-74.1946594173982);
var Ph54= new google.maps.LatLng(4.62300599994493,-74.194659000417);
var Ph55= new google.maps.LatLng(4.62299978551037,-74.1946584656627);
var Ph56= new google.maps.LatLng(4.62297844946026,-74.1946541912875);
var Ph57= new google.maps.LatLng(4.62293877902565,-74.1946411318567);
var Ph58= new google.maps.LatLng(4.62287915842246,-74.194613154681);
var Ph59= new google.maps.LatLng(4.62280011118967,-74.1945636057843);
var Ph60= new google.maps.LatLng(4.6227046770279,-74.1944860828883);
var Ph61= new google.maps.LatLng(4.62259853492805,-74.1943753562205);
var Ph62= new google.maps.LatLng(4.62248979784178,-74.1942283367915);
var Ph63= new google.maps.LatLng(4.62238843948269,-74.1940449562255);
var Ph64= new google.maps.LatLng(4.62230536976837,-74.1938288050317);
var Ph65= new google.maps.LatLng(4.6222512421536,-74.1935873876024);
var Ph66= new google.maps.LatLng(4.62223513851493,-74.1933318962463);
var Ph67= new google.maps.LatLng(4.62226331829672,-74.1930764772514);
var Ph68= new google.maps.LatLng(4.62233822590184,-74.192837045307);
var Ph69= new google.maps.LatLng(4.62245792016194,-74.19262978001);
var Ph70= new google.maps.LatLng(4.62261602857335,-74.1924694928457);
var Ph71= new google.maps.LatLng(4.62280225029513,-74.192368075144);
var Ph72= new google.maps.LatLng(4.62300335201773,-74.1923332259559);

             var flightPath3 = new google.maps.Polygon({
                 path: [Ph0, Ph1, Ph2, Ph3, Ph4, Ph5, Ph6, Ph7, Ph8, Ph9, Ph10, Ph11, Ph12, Ph13, Ph14, Ph15, Ph16, Ph17, Ph18, Ph19, Ph20, Ph21, Ph22, Ph23, Ph24, Ph25, Ph26, Ph27, Ph28, Ph29, Ph30, Ph31, Ph32, Ph33, Ph34, Ph35, Ph36, Ph37, Ph38, Ph39, Ph40, Ph41, Ph42, Ph43, Ph44, Ph45, Ph46, Ph47, Ph48, Ph49, Ph50, Ph51, Ph52, Ph53, Ph54, Ph55, Ph56, Ph57, Ph58, Ph59, Ph60, Ph61, Ph62, Ph63, Ph64, Ph65, Ph66, Ph67, Ph68, Ph69, Ph70, Ph71, Ph72],

                 strokeColor: "#0000FF",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#0000FF",
                 fillOpacity: 0.1
             });
             //Fin RDS1

             // RDS2
var Pi0= new google.maps.LatLng(4.5845547171763,-74.0981287507777);
var Pi1= new google.maps.LatLng(4.58484868973354,-74.0981789685506);
var Pi2= new google.maps.LatLng(4.5851211532813,-74.0983265031);
var Pi3= new google.maps.LatLng(4.58535274417898,-74.0985601514455);
var Pi4= new google.maps.LatLng(4.58552836895619,-74.0988625748371);
var Pi5= new google.maps.LatLng(4.58563866400212,-74.099212154003);
var Pi6= new google.maps.LatLng(4.58568073603222,-74.0995852551577);
var Pi7= new google.maps.LatLng(4.58565810096097,-74.0999586162567);
var Pi8= new google.maps.LatLng(4.58557985553768,-74.1003115458493);
var Pi9= new google.maps.LatLng(4.58545923106329,-74.1006276588504);
var Pi10= new google.maps.LatLng(4.58531176819261,-74.1008959532932);
var Pi11= new google.maps.LatLng(4.58515339604373,-74.1011111450635);
var Pi12= new google.maps.LatLng(4.58499868855094,-74.1012732994363);
var Pi13= new google.maps.LatLng(4.58485951125393,-74.1013869016708);
var Pi14= new google.maps.LatLng(4.58474418065065,-74.1014595734306);
var Pi15= new google.maps.LatLng(4.58465716078584,-74.1015006587118);
var Pi16= new google.maps.LatLng(4.58459923995036,-74.1015198779974);
var Pi17= new google.maps.LatLng(4.58456807861987,-74.1015261975254);
var Pi18= new google.maps.LatLng(4.58455899994445,-74.1015270004619);
var Pi19= new google.maps.LatLng(4.58456589966017,-74.1015275933173);
var Pi20= new google.maps.LatLng(4.5845821704147,-74.1015310419392);
var Pi21= new google.maps.LatLng(4.58460155521595,-74.1015383063441);
var Pi22= new google.maps.LatLng(4.58461885909821,-74.101548626702);
var Pi23= new google.maps.LatLng(4.58463045718584,-74.101560096573);
var Pi24= new google.maps.LatLng(4.58463454786897,-74.1015703400482);
var Pi25= new google.maps.LatLng(4.58463111962492,-74.1015771887488);
var Pi26= new google.maps.LatLng(4.58462163608347,-74.101579241725);
var Pi27= new google.maps.LatLng(4.58460849419838,-74.1015761984085);
var Pi28= new google.maps.LatLng(4.58459436401333,-74.1015688918097);
var Pi29= new google.maps.LatLng(4.5845815563147,-74.1015590163287);
var Pi30= new google.maps.LatLng(4.58457156650534,-74.1015486277324);
var Pi31= new google.maps.LatLng(4.58456489899208,-74.1015395656933);
var Pi32= new google.maps.LatLng(4.58456119302068,-74.1015329815125);
var Pi33= new google.maps.LatLng(4.58455957404223,-74.1015291248874);
var Pi34= new google.maps.LatLng(4.58455908113409,-74.1015274559639);
var Pi35= new google.maps.LatLng(4.58455900260733,-74.1015270303608);
var Pi36= new google.maps.LatLng(4.58455899994445,-74.1015270004619);
var Pi37= new google.maps.LatLng(4.5845589973568,-74.1015270303673);
var Pi38= new google.maps.LatLng(4.58455891990102,-74.1015274561653);
var Pi39= new google.maps.LatLng(4.58455843119312,-74.1015291263149);
var Pi40= new google.maps.LatLng(4.58455682192227,-74.1015329869726);
var Pi41= new google.maps.LatLng(4.58455313252688,-74.101539580391);
var Pi42= new google.maps.LatLng(4.58454648783253,-74.1015486590585);
var Pi43= new google.maps.LatLng(4.58453652418953,-74.1015590725782);
var Pi44= new google.maps.LatLng(4.58452374137495,-74.1015689800232);
var Pi45= new google.maps.LatLng(4.58450962961537,-74.1015763218974);
var Pi46= new google.maps.LatLng(4.58449649542745,-74.101579398034);
var Pi47= new google.maps.LatLng(4.58448700675121,-74.1015773687558);
var Pi48= new google.maps.LatLng(4.58448356128879,-74.1015705286424);
var Pi49= new google.maps.LatLng(4.58448762618952,-74.1015602749822);
var Pi50= new google.maps.LatLng(4.5844991953856,-74.1015487761751);
var Pi51= new google.maps.LatLng(4.58451647324991,-74.101538412622);
var Pi52= new google.maps.LatLng(4.58453583971457,-74.1015310998125);
var Pi53= new google.maps.LatLng(4.58455210174192,-74.1015276105529);
var Pi54= new google.maps.LatLng(4.58455899994445,-74.1015270004619);
var Pi55= new google.maps.LatLng(4.58454991927752,-74.101526220209);
var Pi56= new google.maps.LatLng(4.58451874214611,-74.1015199785512);
var Pi57= new google.maps.LatLng(4.58446077313943,-74.1015009040346);
var Pi58= new google.maps.LatLng(4.58437365017923,-74.1014600363096);
var Pi59= new google.maps.LatLng(4.58425813708744,-74.101387652988);
var Pi60= new google.maps.LatLng(4.58411867436093,-74.1012743990067);
var Pi61= new google.maps.LatLng(4.5839635592493,-74.101112632022);
var Pi62= new google.maps.LatLng(4.58380464589591,-74.1008978372197);
var Pi63= new google.maps.LatLng(4.58365650793098,-74.1006299129546);
var Pi64= new google.maps.LatLng(4.58353508761545,-74.1003141035017);
var Pi65= new google.maps.LatLng(4.58345595315687,-74.0999613718442);
var Pi66= new google.maps.LatLng(4.58343237701949,-74.099588069736);
var Pi67= new google.maps.LatLng(4.58347350804466,-74.0992148655489);
var Pi68= new google.maps.LatLng(4.58358292083871,-74.0988650121764);
var Pi69= new google.maps.LatLng(4.58375778184663,-74.0985621503525);
var Pi70= new google.maps.LatLng(4.58398878218891,-74.0983279226268);
var Pi71= new google.maps.LatLng(4.58426087236286,-74.0981797055519);
var Pi72= new google.maps.LatLng(4.5845547171763,-74.0981287507777);

             var flightPath4 = new google.maps.Polygon({
                 path: [Pi0, Pi1, Pi2, Pi3, Pi4, Pi5, Pi6, Pi7, Pi8, Pi9, Pi10, Pi11, Pi12, Pi13, Pi14, Pi15, Pi16, Pi17, Pi18, Pi19, Pi20, Pi21, Pi22, Pi23, Pi24, Pi25, Pi26, Pi27, Pi28, Pi29, Pi30, Pi31, Pi32, Pi33, Pi34, Pi35, Pi36, Pi37, Pi38, Pi39, Pi40, Pi41, Pi42, Pi43, Pi44, Pi45, Pi46, Pi47, Pi48, Pi49, Pi50, Pi51, Pi52, Pi53, Pi54, Pi55, Pi56, Pi57, Pi58, Pi59, Pi60, Pi61, Pi62, Pi63, Pi64, Pi65, Pi66, Pi67, Pi68, Pi69, Pi70, Pi71, Pi72],

                 strokeColor: "#0000FF",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#0000FF",
                 fillOpacity: 0.1
             });
             //Fin RDS2

             // RDS3
var Pj0= new google.maps.LatLng(4.76044379902037,-74.0359516773987);
var Pj1= new google.maps.LatLng(4.76064592372199,-74.0359750895185);
var Pj2= new google.maps.LatLng(4.76083910048308,-74.0360433815511);
var Pj3= new google.maps.LatLng(4.76101602610486,-74.0361493807241);
var Pj4= new google.maps.LatLng(4.76117243504312,-74.03628263926);
var Pj5= new google.maps.LatLng(4.76130807273921,-74.0364306043243);
var Pj6= new google.maps.LatLng(4.76142625129238,-74.0365818221379);
var Pj7= new google.maps.LatLng(4.76153339906946,-74.0367267706744);
var Pj8= new google.maps.LatLng(4.76163758670733,-74.0368595684231);
var Pj9= new google.maps.LatLng(4.76174662733429,-74.0369788246577);
var Pj10= new google.maps.LatLng(4.76186670031116,-74.0370870737508);
var Pj11= new google.maps.LatLng(4.76200022826746,-74.0371905645386);
var Pj12= new google.maps.LatLng(4.76214609582834,-74.0372968906424);
var Pj13= new google.maps.LatLng(4.76229814724999,-74.0374142896569);
var Pj14= new google.maps.LatLng(4.76244698187816,-74.0375491014253);
var Pj15= new google.maps.LatLng(4.76258095933772,-74.037704701703);
var Pj16= new google.maps.LatLng(4.7626877993398,-74.0378807724624);
var Pj17= new google.maps.LatLng(4.76275685397272,-74.0380731472382);
var Pj18= new google.maps.LatLng(4.76278074248966,-74.0382745665991);
var Pj19= new google.maps.LatLng(4.76275725372258,-74.038476037522);
var Pj20= new google.maps.LatLng(4.76268873920149,-74.0386685892978);
var Pj21= new google.maps.LatLng(4.76258239506585,-74.0388449423335);
var Pj22= new google.maps.LatLng(4.76244870308276,-74.039000844907);
var Pj23= new google.maps.LatLng(4.76230025688719,-74.03913604333);
var Pj24= new google.maps.LatLng(4.76214854746274,-74.0392538390379);
var Pj25= new google.maps.LatLng(4.76200312773915,-74.0393606396519);
var Pj26= new google.maps.LatLng(4.76186989829986,-74.0394644897211);
var Pj27= new google.maps.LatLng(4.76175025435173,-74.0395731771038);
var Pj28= new google.maps.LatLng(4.76164165326104,-74.0396928611558);
var Pj29= new google.maps.LatLng(4.76153782588386,-74.0398259566394);
var Pj30= new google.maps.LatLng(4.76143115393455,-74.0399713517574);
var Pj31= new google.maps.LatLng(4.76131337309992,-74.0401229106426);
var Pj32= new google.maps.LatLng(4.76117812299719,-74.0402712630308);
var Pj33= new google.maps.LatLng(4.76102201697447,-74.0404048062035);
var Pj34= new google.maps.LatLng(4.76084537416243,-74.0405112996287);
var Pj35= new google.maps.LatLng(4.76065237459855,-74.040580129906);
var Pj36= new google.maps.LatLng(4.76045030131041,-74.0406039402522);
var Pj37= new google.maps.LatLng(4.76024817649479,-74.0405805267447);
var Pj38= new google.maps.LatLng(4.76005499993361,-74.0405122333804);
var Pj39= new google.maps.LatLng(4.75987807478507,-74.0404062330553);
var Pj40= new google.maps.LatLng(4.75972166649926,-74.0402729736166);
var Pj41= new google.maps.LatLng(4.75958602953957,-74.0401250079094);
var Pj42= new google.maps.LatLng(4.75946785171959,-74.0399737896737);
var Pj43= new google.maps.LatLng(4.75936070460443,-74.0398288408637);
var Pj44= new google.maps.LatLng(4.75925651753233,-74.0396960429216);
var Pj45= new google.maps.LatLng(4.75914747736743,-74.0395767865128);
var Pj46= new google.maps.LatLng(4.75902740477163,-74.039468537239);
var Pj47= new google.maps.LatLng(4.75889387714878,-74.0393650462732);
var Pj48= new google.maps.LatLng(4.75874800990579,-74.039258720029);
var Pj49= new google.maps.LatLng(4.75859595882424,-74.0391413209926);
var Pj50= new google.maps.LatLng(4.75844712457348,-74.0390065094002);
var Pj51= new google.maps.LatLng(4.75831314752984,-74.0388509095789);
var Pj52= new google.maps.LatLng(4.75820630795838,-74.0386748395984);
var Pj53= new google.maps.LatLng(4.75813725372862,-74.0384824658992);
var Pj54= new google.maps.LatLng(4.75811336554196,-74.0382810478396);
var Pj55= new google.maps.LatLng(4.75813685452786,-74.0380795783021);
var Pj56= new google.maps.LatLng(4.75820536913805,-74.0378870278579);
var Pj57= new google.maps.LatLng(4.75831155452281,-74.0377106338236);
var Pj58= new google.maps.LatLng(4.75844540508289,-74.0375547743036);
var Pj59= new google.maps.LatLng(4.75859385106724,-74.0374195765253);
var Pj60= new google.maps.LatLng(4.75874556023515,-74.0373017812387);
var Pj61= new google.maps.LatLng(4.75889097966697,-74.0371949808971);
var Pj62= new google.maps.LatLng(4.75902420877596,-74.037091131024);
var Pj63= new google.maps.LatLng(4.75914385234237,-74.0369824438129);
var Pj64= new google.maps.LatLng(4.75925245296929,-74.0368627599428);
var Pj65= new google.maps.LatLng(4.75935627978046,-74.0367296646376);
var Pj66= new google.maps.LatLng(4.7594630333626,-74.0365844113296);
var Pj67= new google.maps.LatLng(4.75958073105776,-74.0364327107977);
var Pj68= new google.maps.LatLng(4.7597159802582,-74.0362843582308);
var Pj69= new google.maps.LatLng(4.75987208534753,-74.0361508146023);
var Pj70= new google.maps.LatLng(4.76004872729644,-74.0360443203999);
var Pj71= new google.maps.LatLng(4.76024172616563,-74.0359754890439);
var Pj72= new google.maps.LatLng(4.76044379902037,-74.0359516773987);

             var flightPath5 = new google.maps.Polygon({
                path: [Pj0, Pj1, Pj2, Pj3, Pj4, Pj5, Pj6, Pj7, Pj8, Pj9, Pj10, Pj11, Pj12, Pj13, Pj14, Pj15, Pj16, Pj17, Pj18, Pj19, Pj20, Pj21, Pj22, Pj23, Pj24, Pj25, Pj26, Pj27, Pj28, Pj29, Pj30, Pj31, Pj32, Pj33, Pj34, Pj35, Pj36, Pj37, Pj38, Pj39, Pj40, Pj41, Pj42, Pj43, Pj44, Pj45, Pj46, Pj47, Pj48, Pj49, Pj50, Pj51, Pj52, Pj53, Pj54, Pj55, Pj56, Pj57, Pj58, Pj59, Pj60, Pj61, Pj62, Pj63, Pj64, Pj65, Pj66, Pj67, Pj68, Pj69, Pj70, Pj71, Pj72],

                 strokeColor: "#0000FF",
                 strokeOpacity: 0.4,
                 strokeWeight: 2,
                 fillColor: "#0000FF",
                 fillOpacity: 0.1
             });
             //Fin RDS3


        var deviceMarker = "RDS.png";
        var antenaMarker = "bts2.png";

        var markerDevice = new google.maps.Marker({ position: myCenterDevice, icon: deviceMarker });
        var infowindowD = new google.maps.InfoWindow({
            content: name
        });


        var myCenter = new google.maps.LatLng(4.52025, -74.102806);
        var marker = new google.maps.Marker({ position: myCenter, icon: antenaMarker });
        var infowindow2 = new google.maps.InfoWindow({
            content: "SANTA LIBRADA"
        });

            var myCenter2 = new google.maps.LatLng(4.743539, -74.074769);
            var marker2 = new google.maps.Marker({ position: myCenter2, icon: antenaMarker });
        var infowindow5 = new google.maps.InfoWindow({
            content: "SUBA"
        });

        var myCenter3 = new google.maps.LatLng(4.623006, -74.194659);
        var marker3 = new google.maps.Marker({ position: myCenter3, icon: deviceMarker });
        var infowindow6 = new google.maps.InfoWindow({
            content: "RDS1"
        });
        var myCenter4 = new google.maps.LatLng(4.584559, -74.101527);
        var marker4 = new google.maps.Marker({ position: myCenter4, icon: deviceMarker });
        var infowindow7 = new google.maps.InfoWindow({
            content: "RDS2"
        });
        var myCenter5 = new google.maps.LatLng(4.760447054149487, -74.03827780748605);
        var marker5 = new google.maps.Marker({ position: myCenter5, icon: deviceMarker });
        var infowindow8 = new google.maps.InfoWindow({
            content: "RDS3"
        });
        var i;
        google.maps.event.addListener(markerDevice, 'click', (function (markerDevice, i) {
            return function () {
                infowindowD.setContent(markerDevice);
                infowindowD.open(map, markerDevice);
            }
        })
            (markerDevice, i));



        var k;
        google.maps.event.addListener(marker, 'click', (function (marker, k) {
            return function () {
                infowindow2.setContent(marker);
                infowindow2.open(map, marker);
            }
        })
            (marker, k));



        var m;
        google.maps.event.addListener(marker2, 'click', (function (marker2, m) {
            return function () {
                infowindow5.setContent(marker2);
                infowindow5.open(map, marker2);
            }
        })
            (marker2, m));
        var n;
        google.maps.event.addListener(marker3, 'click', (function (marker3, m) {
            return function () {
                infowindow6.setContent(marker3);
                infowindow6.open(map, marker3);
            }
        })
            (marker3, n));

        var o;
        google.maps.event.addListener(marker4, 'click', (function (marker4, o) {
            return function () {
                infowindow7.setContent(marker4);
                infowindow7.open(map, marker4);
            }
        })
            (marker4, o));
        var p;
        google.maps.event.addListener(marker5, 'click', (function (marker5, p) {
            return function () {
                infowindow8.setContent(marker5);
                infowindow8.open(map, marker5);
            }
        })
            (marker5, p));


        marker.setMap(map);//Sta Librada
        marker2.setMap(map);//Suba
        marker3.setMap(map)//rds1
        marker4.setMap(map)//rds2
        marker5.setMap(map)//rds3
        markerDevice.setMap(map);

        flightPath0.setMap(map);  //Grafica rado RDS actual
        flightPath.setMap(map);   //Sta Librada
        flightPath2.setMap(map); // Suba
        flightPath3.setMap(map); //RDS1
        flightPath4.setMap(map); //RDS2
        flightPath5.setMap(map); //RDS3
    
   //FIN

        });
         }



         function UpdateDevice()
         {          
              var device = '<%= HttpContext.Current.Session["DeviceName"].ToString().ToLower() %>';
              var name = document.getElementById("txtName").value;
              var description = document.getElementById("txtDescription").value;
              var channel = $('#ddlChannels :selected').val();
              var model = $('#ddlMethod :selected').val();
              var pattern =  $('#ddlPattern :selected').val();
              var latitude = document.getElementById("txtLat").value;
              var longitude = document.getElementById("txtLong").value;
   

              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "/EditDevices.aspx/UpdateDevice",
                  data: '{id: "' + device + '", name: "' + name + '", description: "' + description + '", channel: "' + channel + '",  model: "' + model + '",  pattern: "' + pattern + '", latitude: "' + latitude + '", longitude: "' + longitude + '"}',
                  dataType: "json",
                  success: function (data) {
                      alert('msg: ' + data['d']['Message']);
                      location.href = "EditDevices.aspx";
                  },
                  error: function () {
                  
                      alert("No fue posible actualizar el dispositivo.");
                  }                 
                 
              });
     }

      function Default2() {

         
                  window.location.href = '/Default2.aspx';
              
          }
   

          function EditLocation() {

         
                  window.location.href = '/EditLocation.aspx';
              
          }


          function ConsultRange() {


              var name = document.getElementById("txtName").value;
              var latitud = document.getElementById("txtLat").value;
              var longitud = document.getElementById("txtLong").value;
              var method = document.getElementById('ddlMethod').selectedIndex.toString() == "0" ? "1" : $('#ddlMethod :selected').val();
              var patternDrop = $('#ddlPattern :selected').val();

              if (!name) {
                  alert("Error ingrese el nombre primero.");

              } else {

                  $.ajax({
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      url: "/EditDevices.aspx/ConsultRange",
                      data: '{latitud: "' + latitud + '", longitud: "' + longitud + '", method: "' + method + '", patternDrop: "' + patternDrop + '"}',
                      dataType: "json",
                      success: function (data) {
                          if (method === "0") {
                              myMap(latitud, longitud, name);
                          }

                          else if (method === "1") {
                              myMap1(latitud, longitud, name);
                          }
                          else if (method === "2") {

                              myMap2(latitud, longitud, name);
                          }
                          else if (method === "3") {
                              myMap3(latitud, longitud, name);
                          }

                          var lankanListArray = JSON.parse(data.d);

                          ///Limpiar dropdownlist
                          $("#ddlChannels").empty();
                          $.each(lankanListArray, function (key, value) {

                              $("#ddlChannels").append($("<option></option>").val(value).html(value));

                          });

                      },
                      error: function () {

                          alert("Error en peticion POST.");
                      }


                  });

              }

          }

         function Grafiquinha() {
                var latitud = document.getElementById("txtLat").value;
                var longitud = document.getElementById("txtLong").value;
                var name = document.getElementById("txtName").value;
                var pattern = $("#ddlPattern").val();
                var gain = document.getElementById("gainh").value;
                var pwfactor = document.getElementById("pwfactorh").value
                var high = document.getElementById("highh").value
          

            return $.ajax({
             type: "POST",
             contentType: "application/json; charset=utf-8",
             url: "/EditDevices.aspx/Grafiquinha",
             data: '{latitud: "' + latitud + '", longitud: "' + longitud + '", fixedDevice: "' + name + '", patternDrop: "' + pattern + '", gain: "' + gain + '", powerFactor: "' + pwfactor + '", high: "' + high + '"}',
             dataType: "json",
             //async: false, 

                 error: function () {

                 alert("Error en peticion POST.");
             }
             

         });
         
         
         }

         function strtofloat(cadena)
         {var strEx = cadena;
         //primer paso: fuera puntos
         strEx = strEx.replace(".","");
         //cambiamos la coma por un punto
         strEx = strEx.replace(",",".");
         //listo
         return numFinal = parseFloat(strEx);
          }

</script> 
 
    

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCfIeL5pi2G_CsF21w0FFZrmO4sEEl8So8&callback=myMap"></script>  
<script src="Public/js/locationpicker.jquery.js"></script> 



</body>       
</html>

