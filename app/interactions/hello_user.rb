class HelloUser < ActiveInteraction::Base
    integer :user_id

    def execute
        return "hell0 - #{self.user_id}"
    end

end