class AccountsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_account, only: %i[ show edit update destroy deposit ]

  $amount

  # GET /accounts or /accounts.json
  def index
    @accounts = Account.all
    
  end

  # GET /accounts/1 or /accounts/1.json
  def show
    @account = Account.find(params[:id])
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  def transact
    @account = Account.find(params[:id])  
  end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(account_params)
    respond_to do |format|
      if @account.save
        format.json { render json: { status: 'success', message: 'Account was created', data: @account } }
        format.html { redirect_to @account, notice: 'Account was successfully created.' } 
      else
        format.json { render json: { status: 'error', error: @account.errors.get_message }, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    @account = Account.find(params[:id])
    respond_to do |format| 
      if @account.update(account_params)
        format.json { render json: { status:'success', message: 'Account was updated', data: @account }, status: :ok }
        format.html { redirect_to @account, notice: 'Account was updated' }
      else
        format.json { render json: { status: 'error', error: @account.errors.gets_message }, status: :unprocessable_entity }
        format.html { render :edit, status: :ok }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      redirect_to accounts_path
    end
  end

  # PATCH /accounts/1/transact or /accounts/1/transact.json
  def deposit
    @account = Account.find( params[:id])
    t = @account.update(balance: @account.balance.to_i + account_params[:balance].to_i)
    respond_to do |format|
      if t
        @account.reload
        format.json { render json: { status: 'success', message: 'Amount was deposit successfully',data: @account }, status: :ok }
        format.html { redirect_to @account, notice: 'Amount was successfully added.' }
      else
        format.json { render json: { status: 'error', message: t.errors.get_message, data: @account }, status: :unprocessable_entity }
        format.html { render :transact, status: :unprocessable_entity }
      end
    end
  end

  def withdraw
    @account = Account.find( params[:id])
    t = @account.update(balance: @account.balance.to_i - account_params[:balance].to_i)
    respond_to do |format|
      if t
        @account.reload
        format.json { render json: { status: 'success', message: 'Amount was debited successfully', data: @account }, status: :ok }
        format.html { redirect_to @account, notice: 'Amount was depposited successfully' }
      else
        format.json { render json: { status: 'error', message: t.errors.get_message }, status: :unprocessable_entity }
        format.html { render :transact, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:first_name, :last_name,:balance, :email)
    end
end
