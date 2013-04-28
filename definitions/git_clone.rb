define :git_clone, :repository => :null, :directory=> :null , :project => :null do

#createte directory to clone repository into
directory "#{params[:directory]}" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

project_home = params[:directory] + "/" + params[:project]

execute "git_clone" do
  command "git clone #{params[:repository]}"
  action :run
  cwd "#{params[:directory]}"
  not_if {File.exist?(project_home)}
end

execute "git_up" do
  command "git pull"
  action :run
  cwd {project_home}
  not_if {File.exist?(project_home)}
end


end

