module DecksHelper
  def decks_options_for_select_tag
    current_user.decks.map {|obj| [obj.title, obj.id, {"data-text": obj.title}]}
  end
end
