define :git_clone, :repository => :null, :directory=> :null do

#createte directory to clone repository into
directory "#{params[:directory]}" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

execute "git_clone" do
  command "git clone #{params[:repository]}"	
  action :run
  cwd "#{params[:directory]}"	
end

end

