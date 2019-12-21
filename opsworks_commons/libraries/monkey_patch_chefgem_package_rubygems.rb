
require 'chef/provider/package'
require 'chef/provider/package/rubygems'

class Chef
  class Provider
    class Package
      class Rubygems < Chef::Provider::Package
        def install_via_gem_command(name, version)
          if @new_resource.source =~ /\.gem$/i
            name = @new_resource.source
          else
            src = @new_resource.source && "  --source=#{@new_resource.source} --source=http://rubygems.org"
          end
          if version
            shell_out!("#{gem_binary_path} install #{name} -q -N -v \"#{version}\"#{src}#{opts}", :env=>nil)
          else
            shell_out!("#{gem_binary_path} install \"#{name}\" -q -N #{src}#{opts}", :env=>nil)
          end
        end
      end
    end
  end
end
