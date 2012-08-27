require 'airs_tools'
require 'jira'

class TransitionFactory < JIRA::BaseFactory # :nodoc:
end

class JiraClient < JIRA::Client
  def initialize
    config = GitClient.new.config
    options = {
      :username => config["jira.user"],
      :password => config["jira.password"],
      :site => config["jira.server"],
      :context_path => config["jira.context_path"] || "",
      :auth_type => :basic
    }
    # @client = JIRA::Client.new(options)
    super(options)
  end
  
  def exec_transition(issue_key, transition_name)
    path = "/rest/api/2/issue/#{issue_key}/transitions"
    transitions = JSON.parse(self.get(path).body)["transitions"]
    transition = transitions.find { |it| it["name"] == transition_name }
    if transition.present?
      comment = "#{transition['name']}: #{issue_key}"
      body = {
        "update" => {
          "comment" => [
            "add" => { "body" => comment }
          ]
        },
        "transition" => {
          "id" => transition["id"]
        }
      }.to_json
      self.post(path, body)
      comment
    else
      nil
    end
  end
  
  def assign_to_me(issue)
    name = options[:username]
    unless issue.assignee.try(:name) == name
      path = "/rest/api/2/issue/#{issue.key}/assignee"
      "Assign to #{name}" if self.put(path, { "name" => name }.to_json)
    end
  end
end