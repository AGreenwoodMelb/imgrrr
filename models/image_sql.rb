require_relative 'base_sql'

def find_image (image_id)
 return run_sql("SELECT * FROM images WHERE image_id = '#{image_id}';").first
end

def find_album_images(album_id)
    return run_sql("SELECT * FROM images WHERE album_id = '#{album_id}';")
end

def add_new_image (album_id, user_id, image_title, image_url, image_description )
    return run_sql("INSERT INTO images(album_id, user_id, image_title, image_url, image_description) VALUES ('#{album_id}', '#{user_id}','#{image_title}','#{image_url}','#{image_description}');")
end

def delete_image (image_id)
    return run_sql("DELETE FROM images WHERE image_id = #{image_id};")
end

def update_image (image_id, image_title, image_url, image_description)
    return run_sql("UPDATE images SET image_title = '#{image_title}', image_url = '#{image_url}', image_description ='#{image_description}' WHERE image_id=#{image_id}")
end
