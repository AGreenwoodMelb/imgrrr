require_relative 'base_sql'
require 'bcrypt'


def create_user (username, password, email)
    digest_password = BCrypt::Password.create(password)
    return run_sql("INSERT INTO users(username, password, email) VALUES ('#{username}', '#{digest_password}', '#{email}');")
end

def update_user_password (username,new_password)
    digest_password = BCrypt::Password.create(new_password)
    return run_sql("UPDATE users SET password='#{digest_password}' WHERE username ='#{username}'")
end

def check_new_user (username, password, email)
    does_username_exist = run_sql("SELECT FROM users WHERE username ='#{username}';")
    does_email_exist = run_sql("SELECT FROM users WHERE email ='#{email}';")

    if does_username_exist.first != nil
        return 1
    elsif does_email_exist.first != nil
        return 2
    else
        create_user(username, password, email)
        return
    end
end

def check_login (username, password)
    user_to_check = run_sql("SELECT * FROM users WHERE username = '#{username}';").first
    if user_to_check != nil
         if BCrypt::Password.new(user_to_check['password']) == password
            return user_to_check
         end
    end
    return
end

def delete_user (username, password,user_id)
    valid_user = check_login(username,password)
    if  valid_user ==nil
        return nil
    end
    # Handle Deleting albums from this user
    user_albums = get_user_albums(user_id);
    user_albums.each do |album|
        delete_album(album["album_id"].to_i)
    end
    return run_sql("DELETE FROM users WHERE user_id =#{user_id};")
end

def get_user (user_id)
    return run_sql("SELECT * FROM users WHERE user_id =#{user_id};").first
end

def get_user_by_username(username)
    return run_sql("SELECT * FROM users WHERE username ='#{username}';").first
end

def get_all_users #THIS IS STUPID
    return run_sql("SELECT * FROM users")
end
