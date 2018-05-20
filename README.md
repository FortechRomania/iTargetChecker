# itargetchecker plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-itargetchecker)

## About itargetchecker

Checks the xcode proj file for targets and points out which files from the project are not present in a certain target.
Usualy this helps if you have a project with multiple targets and you want to make sure that certain classes/resources from your project are present in each of the targets.

At the first run you should check the plugin without passing some ignore files just to see what the plugin finds. After the first run, you should check for false alarms and add those files to youre custom ignore list.

**Attention!**  You can use the plugin as a gem as well, without having to setup Fastlane(though it is recommended as it helps a lot)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. 

If you are new to Fastlane or haven't installed a plugin for Fastlane before, please check the plugins section below. 
Shortcut for those who don't have time to read more:
- Execute the following commands:
```bash
fastlane add_plugin fastlane-plugin-itargetchecker
fastlane install_plugins
 ```

 After these you should be able to use the plugin as pointed in the example below.


## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.
You can now use regex in the ignored files strings passed to the plugin. That can help you to ignore certain file types like .h or Tests.m.

**Note:** The ignored files added in the sample should be changed to match your own rules. 

## Run as gem executable

If you don't want to install the plugin for fastlane, you can simply run  ```gem install fastlane-plugin-itargetchecker``` and after that you should be able to use itargetchecker.

You can use the executable as following:

```
bundle exec itargetchecker "yourProject.xcodeproj" "\w*\.framework\b*#\w*\.xcconfig\b*#\w*\.h\b*#Info.plist" "yourProjectTests" 
```


Basicaly the command takes 3 parameters:
1. the xcodeproj file path
2. the files to be ignored (if more than 1, # is used to split them -see the exemple above-)
3. the targets to be ignored (if more than 1, # is used to split them -see the exemple above-)



**Quick ussage sample:**

```ruby 
itargetchecker(project_path:"../your_project.xcodeproj", 
                    ignore_files:["\w*\.framework\b*", "\w*\.xcconfig\b*", "\w*\.h\b*", "Info.plist"],
                    ignore_targets:["your_projectTests"])    
```

## Run tests for this plugin (to be continued..)

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
