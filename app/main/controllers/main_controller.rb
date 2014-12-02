class MainController < Volt::ModelController

  def about
  end

  def index
  end

  def programming
    page._languages = [
      { icon: "ruby", name: "ruby", description: "def hello\n  puts 'I am a Rails dev at work and have come to know Ruby pretty well.'\nend" },
      { icon: "javascript", name: "javascript", description: "function hello() {\n  console.log('Plus I know Javascript. To a certain degree.');\n}" },
      { icon: "cplusplus", name: "cpp", description: "void hello() {\n std::cout << 'I have done a lot of C++ on the side, in apps and academia.';\n}"},
      { icon: "java", name: "java", description: "public void hello() {\n  System.out.println('And then there is Java.');\n}"}
    ]
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

  def programming_ready
    set_height
    `$('#languages').mCustomScrollbar({theme: 'dark'});`
    `$("pre").bind("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){ $(event.target).children().css("white-space","pre-wrap"); });`
    `Prism.highlightAll()`
  end

  def recreation_ready
    `var svg = new Walkway({
        selector: '#monitor',
        duration: 2500
      });`
    `svg.draw();`
    set_height
  end

  def social_ready
    set_height
  end

  private

  def get_commits
    HTTP.get("https://api.github.com/users/danReynolds/events/public") do |response|
      if response.ok?
        pushes = response.json.lazy.select { |event| event[:type] == "PushEvent" }.first(5)
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
