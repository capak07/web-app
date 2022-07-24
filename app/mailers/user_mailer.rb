class UserMailer < ApplicationMailer

    default from: "atharvabkadam@gmail.com"
    
    

    def demo
        mail(to: "atharvabkadam@gmail.com", subject: "Test", message: "Test Email sent successfully")

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
