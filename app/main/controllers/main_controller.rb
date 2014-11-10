class MainController < Volt::ModelController
  model :page

  def index
  end

  def social
  end

  def about
    # Add code for when the ` view is loaded
  end

  def change_text
    page._social_text = "Monkeys"
  end

  private

  # the main template contains a #template binding that shows another
  # template.  This is the path to that template.  It may change based
  # on the params._controller and params._action values.
  def main_path
    params._controller.or('main') + '/' + params._action.or('index')
  end

end
