class AccountsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_account, only: %i[ show edit update destroy deposit ]

  $amount

  # GET /accounts or /accounts.json
  def index
    @accounts = Account.all

    render json: { status: 'success',message: 'Accounts List', data: @accounts }, status: :ok
  end

  # GET /accounts/1 or /accounts/1.json
  def show
    @account = Account.find(params[:id])
    render json: { status: 'success', message: 'Account Data', data: @account }
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
    if @account.save
      render json: { status: 'success', message: 'Account was created', data: @account }
    else
      render json: { status: 'error', error: @account.errors.get_message }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    @account = Account.find(params[:id])
    if @account.update(account_params)
      render json: { status:'success', message: 'Account was updated', data: @account }, status: :ok
    else
      render json: { status: 'error', error: @account.errors.gets_message }, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy
    render json: { status: :deleted, message: 'Account was successfully destroyed.', data: @account },status: :deleted 

  end

  # PATCH /accounts/1/transact or /accounts/1/transact.json
  def deposit
    @account = Account.find( params[:id])
    t = @account.update(balance: @account.balance.to_i + account_params[:balance].to_i)
    if t
      @account.reload
      render json: { status: 'success', message: 'Amount was deposit successfully',data: @account }, status: :ok
    else
      render json: { status: 'error', message: t.errors.get_message, data: @account }, status: :unprocessable_entity
    end
    
  end

  def withdraw
    @account = Account.find( params[:id])
    t = @account.update(balance: @account.balance.to_i - account_params[:balance].to_i)
    if t
      @account.reload
      render json: { status: 'success', message: 'Amount was debited successfully', data: @account }, status: :ok
    else
      render json: { status: 'error', message: t.errors.get_message }, status: :unprocessable_entity
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
