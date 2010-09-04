class MembersController < ApplicationController
  def index
  end
  
  def signup
    @member = Member.new
  end
  
  def create
    @member = Member.new(params[:member])
    if @member.save
      render 'members/thanks'
    else
      render 'members/signup'
    end
  end
  
end
