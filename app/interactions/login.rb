class Login < ActiveInteraction::Base
    string :username
    string :password


    def execute
        user = User.find_by(username:self.username)        
        if user.present? 
            a =  BCrypt::Password.new(user[:password_digest])
            if a == self.password

                token = JsonWebToken.new.jwt_encode({user:user[:username]})
                return {token: token}
            end
        else
            return {"jdnd":"wrong username or password"}
        end
    
    end

end