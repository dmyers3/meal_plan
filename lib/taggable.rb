module Taggable
  def attach_tags(params, user_id)
    # turn object's class name into symbol to use in params
    object_top_level_name = self.class.name.downcase.to_sym
    # make sure tag_categories is still array if nil
    params[object_top_level_name][:tag_categories] ||= []
    # start array of category id's from selected tag categories
    tag_category_ids = params[object_top_level_name][:tag_categories].map(&:to_i)
   
    # create new tag categories and push their id's to array
    new_tags = params[:new_tags].split(",").map(&:strip).map(&:downcase)
    new_tags.each do |tag_name|
      new_category = TagCategory.create(name: tag_name)
      tag_category_ids << new_category.id
    end
    
    # iterate through all the category id's and create tag's associated with the object
     tag_category_ids.each do |category_id|
      Tag.create(tag_category_id: category_id.to_i, taggable_type: self.class.name,
                 taggable_id: self.id, user_id: user_id)
    end
  end
end