require "rubygems"
require "pivotal-tracker"
namespace :pt do

  desc "list avail pivotal tracker tix from which to create a git fea branch"
  task :list do
    def truncate_words(text, length = 5)
      return if text == nil
      words = text.split()
      words = words - %w(feature scenario for in on a an the of so that they be able to are it its with) #remove non critical words (experiment with this)
      words[0..(length-1)].join(' ')
    end

    def gitflow_helper(story_type, branch_name, parent_branch)
      puts ""
      puts "Summary of actions:"
      puts "- A file located at doc/current_pt_story.txt was created with the details of this story."
      puts "    Reference that file easily with cat doc/current_pt_story.txt"
      puts "- A new branch '#{story_type}/#{branch_name}' was created, based on '#{parent_branch}'"
      puts "- You are now on branch '#{story_type}/#{branch_name}'"
      puts ""
      puts "Now, start committing on your #{story_type}. When done, use:"
      puts ""
      if %w(feature hotfix).include?(story_type)
        puts "     git flow #{story_type} finish #{branch_name}"
      else
        puts "     git checkout #{parent_branch}"
        puts "     git merge --no-ff #{branch_name}"
        puts "     git branch -d #{branch_name}"
      end
      puts ""
    end

    token = `git config --get tinytim.token`
    projectid = `git config --get tinytim.projectid`

    PivotalTracker::Client.token = token
    PivotalTracker::Client.use_ssl = false
    project = PivotalTracker::Project.find projectid
    conditions = {
      :state => ['rejected', 'started', 'unstarted', 'finished'],
      :story_type => ['feature', 'bug', 'chore']
    }
    projects = project.stories.all(conditions)

    if projects.count > 0
      branches = []
      stories = []
      projects.each_with_index do |story, index|
        name = story.name.downcase
        # remove individual offending chars: single quote, double quote, open
        # paren, close paren, colon, backslash, forwardslash and replace with
        # an empty string (aka nothing)
        name.gsub!(/['"\.\(\)\[\]:\\\/]/,"")
        # remove remaining cl.ly links
        name.gsub!(/httpclly\S*/,"")
        # remove dash and replace with space
        name.gsub!(/-/," ")
        # do the truncate here, after all the removal & before the _ injection
        name = truncate_words(name)
        # replace all instances of one or more spaces with _
        name.gsub!(/\s+/,"_")
        # create final display
        display = "#{name}_#{story.id}"
        branches[index + 1] = "#{display}"
        stories[index + 1] = story
        puts "(#{index + 1}) #{display}"
      end

      puts ""
      puts "(0) EXIT WITHOUT ANY ACTION"
      puts ""
      puts "For which story do you want to create a new git feature branch?"
      puts "    Note: type 1 to create a feature branch for the first story."
      puts "    Note: type 1,hotfix to create a hotfix for the first story."
      puts "    Note: type 1,bugfix to create a bugfix for a release."

      input = STDIN.gets.strip
      story_num = input.split(",")[0].to_i
      story_type = input.split(",")[1]
      story_type ||= "feature"

      if (1..projects.count).include?(story_num)
        story = stories[story_num]
        story_description = <<EOF

Tracker Story: #{story.id} | Type: #{story.story_type} | Estimate: #{story.estimate}

Tracker Name:
-------------
#{story.name}

Tracker Description:
====================
#{story.description}

EOF
        File.open(Rails.root.join("doc/current_pt_story.txt"), 'w') {|f| f.write(story_description) }

        if story_type == 'feature'
          gitflow_helper(story_type, branches[story_num], 'develop')
          `git flow #{story_type} start "#{branches[story_num]}"`
        elsif story_type == 'hotfix'
          gitflow_helper(story_type, branches[story_num], 'master')
          `git flow #{story_type} start "#{branches[story_num]}"`
        elsif story_type == 'bugfix'
          parent_branch = `git branch`.split("\n").delete_if { |i| i[0] != "*" }[0].gsub('* ','')
          gitflow_helper(story_type, branches[story_num], parent_branch)
          `git checkout -b bugfix/"#{branches[story_num]}"`
        else
          puts "Error: unknown feature type"
        end
      else
        exit
      end
    else
      puts "There are no available stories right now!"
    end
  end

  desc "sets the state of a pivotal tracker story to 'delivered'"
  task :deliver do
    token = `git config --get tinytim.token`
    projectid = `git config --get tinytim.projectid`

    if Rails.env == "development"
      commit_sha = `cat .git/refs/remotes/origin/master`
      commit_msg = `git cat-file commit #{commit_sha}`
      hit = commit_msg.match(/^(delivered)\s#(\d+):/)

      if hit
        state = hit[1]
        storyid = hit[2]
        PivotalTracker::Client.token = token
        PivotalTracker::Client.use_ssl = false
        project = PivotalTracker::Project.find projectid
        story = project.stories.find(storyid)

        unless story.current_state == "accepted"
          story.update(:current_state => "#{state}")
          puts "Set pivotal tracker story '##{storyid} - #{story.name}' to #{state}"
        end
      end
    end
  end
end
