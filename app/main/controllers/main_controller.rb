class MainController < Volt::ModelController

  def about
  end

  def index
  end

  def recreation
  end

  def social
    get_commits
  end

  #### Ready Functions ####

  def about_ready
    set_height
    `mapOptions = {
      center: new google.maps.LatLng(43.4615875, -80.54107),
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var mapCanvas = document.getElementById('map_canvas');
    var map = new google.maps.Map(mapCanvas, mapOptions);`
  end

  def index_ready
    set_height
  end

  def recreation_ready
    `var svg = new Walkway({
        selector: '#monitor',
        duration: 2500
      });`
    `svg.draw();`
    set_height(50)
  end

  def social_ready
    set_height
  end

  private

  def get_commits
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

  def set_height(offset = 0)
    child_height = Element.find(".container").height + offset
    Element.find(".section").css 'height', child_height
  end

  def main_path
    params._controller.or('main') + '/' + params._action.or('index')
  end
end
