require 'airs_tools'
require 'thor'

module AirsTools
  module CLI
    class JIRA < Thor   
      desc "start <issue_key>", ""
      def start(issue_key)
        issue = client.Issue.find(issue_key)
        return unless ["Open", "Reopened"].include?(issue.status.name)
        
        message = client.assign_to_me(issue)
        say(message, :green) if message
        
        comment = client.exec_transition(issue_key, "Start Progress")
        if comment
          say(comment, :green)
        else
          say("Transition '#{transition_name}' can't execute for #{issue_key}", :red)
        end
      end

      
      protected
        def client
          @client ||= JiraClient.new
        end
    end
  end
end