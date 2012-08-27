require 'airs_tools'
require 'thor'

module AirsTools
  module CLI
    class GitHooks < Thor
      desc "install_post_checkout", ""
      def install_post_checkout
        install_hook("post-checkout")
      end
      
      protected
        def install_hook(hook_name)
          erb = ERB.new(File.read(template_path(hook_name)))
          path = output_path(hook_name)
          File.open(path, 'w') do |f|
            f.puts erb.result(binding)
          end
          File::chmod(0100755, path)
          say "Git hook script '#{hook_name}' installed.", :green
        end
      
        def template_path(hook_name)
          local_path = File.join(Dir::getwd, '.templates', "#{hook_name}.erb")
          return local_path if File.exist?(local_path)
          File.expand_path(File.join(File.dirname(__FILE__), '..', 'templates', "#{hook_name}.erb"))
        end
        
        def output_path(hook_name)
          File.join(Dir::getwd, '.git', 'hooks', hook_name)
        end
    end
  end
end