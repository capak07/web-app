class UserMailer < ApplicationMailer

    default from: "atharvabkadam@gmail.com"
    
    

    def demo
        mail(to: "akadam1@unb.ca", subject: "Test", message: "Test Email sent successfully")

    end

    def welcome_email
        @user = params[:user]
        mail(to: @user.email, subject: "Welocme Email")

    end
    
    def credit_email
        @user = params[:user]
        mail

    end
end
