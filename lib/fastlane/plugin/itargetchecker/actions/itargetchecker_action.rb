require 'fastlane/action'
require 'xcodeproj'
require_relative '../helper/itargetchecker_helper'

module Fastlane
  module Actions
    class ItargetcheckerAction < Action
      def self.run(params)
        
        project = Xcodeproj::Project.open(params[:project_path])

        lostFiles = Array.new

        # loop through all the project files
        project.files.each do |file|

          faultyFile = file.name == nil || file.name == "" 
          if params[:ignore_files]
             faultyFile = faultyFile || (params[:ignore_files].include? file.name)
          end   

          if faultyFile
            next
          end

          project.targets.each do |target|

            found = false

            if params[:ignore_targets]
              if (params[:ignore_targets].include? target.name)
                next
              end
            end

            target.build_phases.each do |buildPhase|

                correctTypes =  buildPhase.isa == "PBXSourcesBuildPhase" || buildPhase.isa == "PBXResourcesBuildPhase"
                if correctTypes
                  # get all files of a target
                  buildPhase.files.each do |targetFile|
                    if targetFile.display_name == file.name
                      found = true
                      break
                    end
                  end

                end
            end

            if found == false 
              UI.error "\n Can't find file: #{file.name} in target: #{target}"
              lostFiles.push("file: #{file.name} target: #{target}")
            end
      
          end

        end

        if lostFiles.length > 0
          UI.error "Lost files found!"
        else 
          UI.success "✅  Yupee! ✨  No lost files found! ✨"
        end

        lostFiles
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
