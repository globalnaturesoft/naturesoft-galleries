if Naturesoft::Core.available?("menus")
  Naturesoft::Menus::Menu.class_eval do
    @galleries = {
      "galleries_list" => {
        "label" => "Galleries List",
        "controller" => "/naturesoft/galleries/galleries",
        "action" => "listing"
      }
    }
  end
end