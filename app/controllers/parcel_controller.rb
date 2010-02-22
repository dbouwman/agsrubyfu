require 'arcserver'
require 'json'
class ParcelController < ApplicationController
  
  def index
    #this is not needed
    @taxid = params[:id]
     service = ArcServer::MapServer.new('http://sampleserver1.arcgisonline.com/ArcGIS/services/Portland/ESRI_LandBase_WebMercator/MapServer')
      @jsonString = service.query(1,{:where=>"TLID = '#{@taxid}'",:outFields=>'TLID,RNO,OWNER1,OWNER2,OWNER3,OWNERADDR,OWNERCITY,OWNERZIP,SITESTRNO,SITEADDR,SITECITY,LANDVAL,BLDGVAL,BLDGSQFT,A_T_ACRES,YEARBUILT,PROP_CODE,LANDUSE,TAXCODE,SALEDATE,SALEPRICE,COUNTY,X_COORD,Y_COORD' })
      @json = JSON.parse(@jsonString)
      @results = @json['features']
      
      if @results.nil? || @results.length == 0
        flash[:notice] = 'No results found.'
      end
    
  end
end
