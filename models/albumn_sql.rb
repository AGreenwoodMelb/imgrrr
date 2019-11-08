require_relative 'base_sql'

def get_user_albums(user_id)
    return run_sql("SELECT * FROM albums WHERE user_id=#{user_id};")
end

def get_specific_album (album_id)
    return run_sql("SELECT * FROM albums WHERE album_id =#{album_id};").first
end

def delete_album (album_id)
    run_sql("DELETE FROM images WHERE album_id = #{album_id}") # Handle deleting album images here
    return run_sql("DELETE FROM albums WHERE album_id = #{album_id};")
end

def add_album (user_id, album_title, album_description, album_is_public, album_cover_image)
    return run_sql("INSERT INTO albums(user_id, album_title, album_description, album_is_public, album_cover_image) VALUES ('#{user_id}','#{album_title}','#{album_description}','#{album_is_public.to_i}','#{album_cover_image}');")
end


def update_album (album_id, album_title, album_description, album_is_public, album_cover_image)
    return run_sql("UPDATE albums SET album_title = '#{album_title}', album_description='#{album_description}',album_is_public='#{album_is_public.to_i}', album_cover_image='#{album_cover_image}' WHERE album_id='#{album_id}';")
end
