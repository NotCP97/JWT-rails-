class CreateUser <  ActiveInteraction::Base

    string :username
    string :password
    string :email


    def execute
        new_user = User.new(username:self.username,password:self.password,email:self.email)
        if new_user.save
            return "user_created"
        else    
            return "user not created"
        end
    end

end