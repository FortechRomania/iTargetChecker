require 'xcodeproj'

class ITargetChecker
  def self.checkTarget(params)
      
    project = Xcodeproj::Project.open(params[:project_path])

        lostFiles = Array.new
        ignoredFiles = params[:ignore_files]

        # loop through all the project files
        project.files.each do |file|

          faultyFile = file.name == nil || file.name == "" 
          if ignoredFiles
            ignoredFiles.each do |ignoredItem|
                faultyFile = faultyFile || file.name.match(ignoredItem)
                if faultyFile
                  next
                end
            end
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
              lostFiles.push("file: #{file.name} target: #{target}")
            end
          end
    end

    lostFiles
  end
end