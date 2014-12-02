class MembersController < ApplicationController
  before_action :set_client
  before_action :set_member, only: [:show, :edit, :update, :destroy, :log]

  respond_to :html

  def index
    authorize Member
    redirect_to client_path(@client)
  end

  def show
    authorize @member
    respond_with @client,@member
  end

  def new
    authorize Member
    @member = Member.new
  end

  def edit
    authorize @member
  end

  def create
    authorize Member
    @member = Member.new(member_registration_params)
    @member.client=@client
    @member.save
    respond_with @client, @member
  end

  def update
    authorize @member
    @member.update(member_update_params)
    @member.update_with_password(member_password_params) if member_password_params.delete_if{|k,v|v.empty?}.any?
    respond_with @client, @member
  end

  def log
    authorize @member
    @logs = @member.action_logs.order('created_at desc').paginate(:page=>params[:page], :per_page => 100)
  end

  # def destroy
  #   @member.destroy
  #   respond_to do |format|
  #     format.html { redirect_to client_path(@client), notice: 'Member was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      set_client unless @client
      @member = @client.members.find(params[:id])
    end

    def set_client
      @client ||= Client.find(params[:client_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_registration_params
      params.require(:member).permit(:email,:first_name,:last_name,:password,:password_confirmation,:avatar)
    end
    def member_update_params
      params.require(:member).permit(:email,:first_name,:last_name,:avatar)
    end
    def member_password_params
      params.require(:member).permit(:password,:password_confirmation,:current_password)
    end
end
