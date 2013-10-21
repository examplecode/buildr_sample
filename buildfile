project_layout = Layout.new
project_layout[:source,:main,:java] = 'src'

define 'buildr-sample', :layout => project_layout do
	  project.version = '0.1.0'
	  package :jar
end
