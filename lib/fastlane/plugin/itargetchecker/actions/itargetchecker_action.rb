require 'fastlane/action'
require 'xcodeproj'
require_relative 'itargetchecker'
require_relative '../helper/itargetchecker_helper'

module Fastlane
  module Actions
    class ItargetcheckerAction < Action
      def self.run(params)
        
        output = ITargetChecker.checkTarget(project_path:params[:project_path], ignore_files:params[:ignore_files], ignore_targets:params[:ignore_targets])
        if output.length > 0
          UI.error output
          UI.error "Lost files found!"
        else 
          UI.success "✅  Yupee! ✨  No lost files found! ✨"
        end

        output
      end

      def self.description
        "Checks the xcodeproj file for targets and points out which files from the project are not present in a certain target."
      end

      def self.authors
        ["Catalin Prata"]
      end

      def self.return_value
        [
          ['LOST_FILES', 'The files that could not be found in a certain target and the specific target.']
        ]
      end

      def self.details
        # Optional:
        "Can be used to point out which file from your project is missing from a target. It should be usefull for projects that have multiple targets to make sure all the files from the main target are also present in the other targets."
      end

      def self.available_options
        [
           FastlaneCore::ConfigItem.new(key: :project_path,
                                   env_name: "ITARGETCHECKER_PROJECT_PATH",
                                description: "The .xcodeproj path of your project",
                                   optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :ignore_files,
                                       env_name: "ITARGETCHECKER_IGNORE_FILES",
                                    description: "List of files that should not be scanned",
                                       optional: true,
                                           type: Array),
          FastlaneCore::ConfigItem.new(key: :ignore_targets,
                                           env_name: "ITARGETCHECKER_IGNORE_TARGETS",
                                        description: "List of targets that should not be scanned",
                                           optional: true,
                                               type: Array)
        ]
      end

      def self.is_supported?(platform)
        # only available for iOS for now, should check if works just well for Mac as well.
        [:ios].include?(platform)
        true
      end
    end
  end
end
