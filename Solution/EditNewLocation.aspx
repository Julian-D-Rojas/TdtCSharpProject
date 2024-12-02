<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditNewLocation.aspx.cs" Inherits="EditNewLocation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nueva Locacion</title>


<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css"/>
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

 <!--complementos de plugin -->
 <script type="text/javascript" src='https://maps.google.com/maps/api/js?sensor=false&libraries=places&key=AIzaSyCw_uSfTejgg_CRh1XOwXM-fRZFWYWfw1M'></script>
 <script src="Public/js/locationpicker.jquery.js"></script>

</head>
<body>
    <form id="form1" runat="server">
<div class="page-header"style="margin-top:0px;padding-top:9px ;margin-bottom:0px;background-color:#0c3c60">
    <div class="row" style="margin-left:20px">
  <h1><strong style="color:#d1f4eb">Editar Ubicación del Dispositivo</strong></h1>
       </div>
    </div>
   <!--container -fluid -->
        <div class="container-fluid"> 
             <!--Row-->
             <div class="row" style="padding-left:20px;padding-top: 50px;padding-bottom:50px; background-image:url(Background2.png)">
               <div class="col-md-12" style=" color:#0c3c60"> 
                          <div class="modal-fade" id="ModalMap" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-body"style="background-color:#d2e0eb">
                                        <div class="from-horizontal">
                                           
                                            <div id="ModalMapPreview" style="width:100%; height:380px;">
                                            </div>
                                            <div class="clearfix">&nbsp;</div>

                                            <div class="m-t-small">
                                                <label class="p-r-small col-sm-1 control-label">Lat:</label>
                                                <div class="col-sm-4">
                                                   <input type="text" style="color:#6ea4ca" class="form-control" id="ModalMapLat" runat="server" />      
                                                    
                                                </div>
                                                <label class="p-r-small col-sm-1 control-label">Long:</label>
                                                <div class="col-sm-4">
                                                      <input type="text" style="color:#6ea4ca" class="form-control" id="ModalMapLon" runat="server" />                                                   
                                                </div>
                                                <button id="btnCreate" type="button" class="btn btn-primary" onclick="UpdateLocation();"  style="margin-top:0px ; float:right"<span id="spnEdit">Actualizar</span></button>                                                                                                     
                                              
                                               
                                            </div>


                                            <div class="clearfix"></div>
                              
 
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                     </div>
             </div>
             <!-- End-Row-->          
          </div> 
      <!--end container - fluid -->
            

 </form>
  <script type="text/javascript">
         
      $(document).ready(function () {

         

          $('#ModalMapPreview').locationpicker({
              radius: 0,
              location: {
                  latitude: 4.579483322960404,
                  longitude: -74.15749985784913
              },
              enableAutocomplete: true,
              inputBinding: {

                  latitudeInput: $('#ModalMapLat'),
                  longitudeInput: $('#ModalMapLon'),

              },
              onchanged: function (currentLocation, radius, isMarkerDropped) {
                  $('#ubicacion').html($('#ModalMapaddress').val());
              }
          });


          $('#ModalMapPreview').locationpicker({
              radius: 0,
              location: {
                  latitude: 4.579483322960404,
                  longitude: -74.15749985784913
              },
              enableAutocomplete: true,
              inputBinding: {

                  latitudeInput: $('#ModalMapLat'),
                  longitudeInput: $('#ModalMapLon'),

              },
              onchanged: function (currentLocation, radius, isMarkerDropped) {
                  $('#ubicacion').html($('#ModalMapaddress').val());
              }

          });
          $('#ModalMap').on('shown.bs.modal', function () {
              $('#ModalMapPreview').locationpicker('autosize');
          });

      });

          function UpdateLocation() {

          
              var latitud = document.getElementById("ModalMapLat").value;
              var longitud = document.getElementById("ModalMapLon").value;
              window.location.href = '/NewDevice.aspx?latitud='+latitud+'&longitud='+longitud;
     
          }

     


</script> 
    



</body>       
</html>

