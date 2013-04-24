define :mvn_install, :directory => :null do

execute "mvn_install" do
  command "mvn clean install"	
  action :run
  cwd "#{params[:directory]}"	
end

end

