class MainController < Volt::ModelController
  def about
  end

  def about_ready
    `mapOptions = {
      center: new google.maps.LatLng(43.4615875, -80.54107),
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var mapCanvas = document.getElementById('map_canvas');
    var map = new google.maps.Map(mapCanvas, mapOptions);`
  end

  def index
  end

  def social
    HTTP.get("https://api.github.com/users/danReynolds/events/public") do |response|
      if response.ok?
        pushes = response.json.select{ |event| event[:type] == "PushEvent" }.first(5)
        page._activities = []
        pushes.each do |p|
          page._activities << {
            repo: p[:repo][:name],
            description: p[:payload][:commits].first[:message],
            head: p[:payload][:head]
          }
        end
      else
        page._activities = []
      end
    end
  end

  def recreation
  end

  def recreation_ready
    `var svg = new Walkway({
        selector: '#monitor',
        duration: 2500
      });`
    `svg.draw();`
  end

  private

  # the main template contains a #template binding that shows another
  # template.  This is the path to that template.  It may change based
  # on the params._controller and params._action values.
  def main_path
    params._controller.or('main') + '/' + params._action.or('index')
  end
end
