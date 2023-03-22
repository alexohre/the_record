class BusinessesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business, only: %i[ show edit update destroy ]
  before_action :set_auth, only: %i[ show edit update destroy ]
  before_action :check_admin, only: [:edit, :update, :destroy]

  # GET /businesses or /businesses.json
  def index
    @title = current_user.email + " Business"
    @businesses = current_user.business
  end

  # GET /businesses/1 or /businesses/1.json
  def show
    @title = @business.name
    @member = @business.members.find_by(user_id: current_user.id)
    @members = @business.members
    @email = ""
  end

  # GET /businesses/new
  def new
    @business = Business.new
  end

  # GET /businesses/1/edit
  def edit
  end

  def invite
    @business = Business.find(params[:business_id])
    email = invite_params[:email]

    if email == current_user.email
      flash[:alert] = "You can't invite yourself."
      redirect_to business_path(@business)
    else
      user = User.find_by_email(email)

      if user.present?
        @business.members.create(user: user, roles: params[:user][:roles])
        redirect_to business_path(@business), notice: "User has been invited successfully"
      else
        new_user = User.invite!({email: email}, current_user)
        if new_user.persisted?
          @business.members.create(user: new_user, roles: params[:user][:roles])
          flash[:notice] = "An invitation email has been sent to #{email}."
          redirect_to business_path(@business)
        else
          flash[:alert] = "Error! Please try again."
          redirect_to business_path(@business)
        end
      end
    end
  end



  def resend_invitation
    @business = Business.friendly.find(params[:business_id])
    @member = @business.members.find(params[:member_id])

    if @member.user.invitation_sent_at
      @member.user.invite!
      flash[:notice] = "Invitation has been re-sent to #{@member.user.email}."
    else
      flash[:alert] = "User has already accepted the invitation."
    end

    redirect_to business_path(@business)
  end


  def remove_member
    @business = Business.find(params[:business_id])
    member = @business.members.find(params[:id])
    user = member.user

    if user == current_user
      flash[:alert] = "You can't remove yourself from the business."
    elsif member.destroy
      flash[:notice] = "#{user.email} has been removed from the business."
    else
      flash[:alert] = "Error! Please try again."
    end

    redirect_to business_path(@business)
  end


  
  def block_user
    @business = Business.find(params[:business_id])
    member = @business.members.find(params[:member_id])
    user = member.user

    if user.present?
      user.update(blocked: true)
      BlockedStatusMailer.blocked_notice(user, @business).deliver_now
      flash[:notice] = "#{member.user.email} has been blocked from the business."
    else
      flash[:alert] = "#{member.user.email} is not a member of the business."
    end

    redirect_to business_path(@business)
  end


  def unblock_user
    @business = Business.find(params[:business_id])
    member = @business.members.find(params[:member_id])
    user = member.user

    if user.present?
      user.update(blocked: false)
      BlockedStatusMailer.unblocked_notice(user, @business).deliver_now
      flash[:notice] = "#{member.user.email} has been unblocked from the business."
    else
      flash[:alert] = "#{member.user.email} is not a member of the business."
    end

    redirect_to business_path(@business)
  end


  # POST /businesses or /businesses.json
  def create
    @business = Business.new(business_params)

    respond_to do |format|
      if @business.save
        @business.members.create(user: current_user, roles: :admin)
        format.html { redirect_to business_url(@business), notice: "Business was successfully created." }
        format.json { render :show, status: :created, location: @business }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/1 or /businesses/1.json
  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to business_url(@business), notice: "Business was successfully updated." }
        format.json { render :show, status: :ok, location: @business }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1 or /businesses/1.json
  def destroy
    @business.destroy

    respond_to do |format|
      format.html { redirect_to businesses_url, notice: "Business was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auth
      unless @business.users.include?(current_user)
        redirect_to "/404"
        return
      end
    end

    def check_admin
      unless @business.members.find_by(user_id: current_user.id, roles: :admin).present?
        # flash[:alert] = "You do not have permission to perform this action."
        redirect_to "/404"
      end
    end

    def invite_params
      params.require(:user).permit(:email, :roles)
    end

    def set_business
      @business = Business.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def business_params
      params.require(:business).permit(:name)
    end
end
