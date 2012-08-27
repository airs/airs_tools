require 'grit'

class GitClient
  
  def initialize
    @repo = Grit::Repo.new(".")
  end
  
  def config
    @repo.config
  end
  
end