require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "Post Model" do
  it 'can be created' do
    @post = Post.new
    @post.should_not be_nil
  end
end
