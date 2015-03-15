class HomeController < LoginController

  def index
    printf "Hi this is index method";
  end

  def getCities
    @cities = ServicableCity.order(:city_name).where("city_name LIKE ?", "%#{params[:city]}%")
    respond_to do |format|
      format.html
      format.json {
        render json: @cities.map(&:name)
      }
    end
  end

  def getLocalities
    city = ServicableCity.find_by_city_name(params[:city])
    city_id = city.id if(city.present?)

    @localities = ServicableCityLocality.order(:locality_name).where("locality_name LIKE ? ", "%#{params[:locality]}%")
    respond_to do |format|
      format.html
      format.json {
        render json: @localities.map(&:locality_name)
      }
    end
  end

  def getLocations
    locality = ServicableCityLocality.find_by_locality_name(params[:locality])
    locality_id = locality.id if(locality.present?)

    @locations = ServicableCityLocalityLocation.order(:location_name).where("location_name LIKE ? and servicable_city_locality_id = ? ", "%#{params[:location]}%", locality_id)
    respond_to do |format|
      format.html
      format.json {
        render json: @locations.map(&:location_name)
      }
    end
  end
end
