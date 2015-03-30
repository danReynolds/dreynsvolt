class MainController < Volt::ModelController
  model :store

  COLOURS = [
   {"name"=>"Bloody Mary", "colour1"=>"#FF512F", "colour2"=>"#DD2476"},
   {"name"=>"Sunrise", "colour1"=>"#FF512F", "colour2"=>"#F09819"},
   {"name"=>"Sea Weed", "colour1"=>"#4CB8C4", "colour2"=>"#3CD3AD"},
   {"name"=>"Cherry", "colour1"=>"#EB3349", "colour2"=>"#F45C43"},
   {"name"=>"Mojito", "colour1"=>"#1D976C", "colour2"=>"#93F9B9"},
   {"name"=>"Electric Violet", "colour1"=>"#4776E6", "colour2"=>"#8E54E9"},
   {"name"=>"Mantle", "colour1"=>"#24C6DC", "colour2"=>"#514A9D"},
   {"name"=>"Dracula", "colour1"=>"#DC2424", "colour2"=>"#4A569D"},
   {"name"=>"Stellar", "colour1"=>"#7474BF", "colour2"=>"#348AC7"},
   {"name"=>"Miaka", "colour1"=>"#FC354C", "colour2"=>"#0ABFBC"},
   {"name"=>"Pinot Noir", "colour1"=>"#4b6cb7", "colour2"=>"#182848"},
   {"name"=>"Day Tripper", "colour1"=>"#f857a6", "colour2"=>"#ff5858"},
   {"name"=>"A Lost Memory", "colour1"=>"#DE6262", "colour2"=>"#FFB88C"}
  ]

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
  end

  #### Ready Functions ####

  def about_ready
    setup
    `mapOptions = {
      center: new google.maps.LatLng(43.4615875, -80.54107),
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var mapCanvas = document.getElementById('map_canvas');
    var map = new google.maps.Map(mapCanvas, mapOptions);`
  end

  def index_ready
    setup
  end

  def programming_ready
    setup
    `$('#languages').mCustomScrollbar({theme: 'dark'});`
    `$("pre").bind("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){ $(event.target).children().css("white-space","pre-wrap"); });`
    `Prism.highlightAll()`
  end

  def recreation_ready
    setup
    `var svg = new Walkway({
        selector: '#monitor',
        duration: 2500
      });`
    `svg.draw();`
  end

  def social_ready
    setup
    get_commits
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

  def setup
    set_colours
    set_height
  end

  def set_colours
    page._colour = COLOURS.sample unless page._colour._name.or(nil)
    Element.find('a.nav-link').css('color', page._colour._colour1)
    Element.find('a.nav-link.back').css('color', page._colour._colour2)
  end

  def set_height
    child_height = Element.find(".container").height
    Element.find(".section").css 'height', child_height
  end

  def main_path
    params._controller.or('main') + '/' + params._action.or('index')
  end
end
