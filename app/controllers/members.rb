Cowpu.controllers :members do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :respond_to => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end
  
  get :index do
    render 'members/index'
  end

  get :signup do
    @member = Member.new
    render 'members/signup' 
  end
  
  post :create do
    @member = Member.new(params[:member])
    if @member.save
      render 'members/thanks'
    else
      render 'members/signup'
    end
  end

end
