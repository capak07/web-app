class Account < ApplicationRecord

    def credit(id, amount)
        @account = Account.find(id)
        curr = @account.balance + amount
        @account.update(balance: curr)
        @account.save
        @account.reload
    end
end
