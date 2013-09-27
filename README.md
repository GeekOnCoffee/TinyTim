YAY

# TinyTim 
No idea where we got the name, but TinyTim is a really cool blog :) The goal of the application is to facilitate learning and exploration in a collaborative setting with a known problem domain, a blog. This _should_ allow all who contribute to explore new technology and/or development techniques without needing to worry about the mental overhead of groking a totally new application concept. 

This application is being coded by the [Green Bay RUG](http://greenbayrug.com) who meets weekly from 12:00pm until 2:00pm CST. The first hour of each meeting will be spent recapping work (reviewing pull requests) that pairs or individuals did during the past week. The second hour will be spent divvying up new features or group/pair/individual coding.

**The application build is expected to go through several stages including:**

* Standalone Rails 3.2.x app built using BDD with Cucumber and MiniTest.
* Branching the project in Git to create a Rails engine that can make the blog easy to plug into existing Rails 3 applications.
* Converting either the engine or the standalone app (or both) to a JSON serving/consuming API.
* Building a rich client-side JS app that communicates with the blog's API.
* Potentially building an iPhone (or other mobile) app that can post data to the blog's API as well!


## Development Tools

###RVM 
To work on a feature of TinyTim please ensure you use the proper version of Ruby (aka the same one the rest of the group is using) which can be determined by looking at the purposely version controlled .rvmrc file in the root of the app. Currently TinyTim is being developed to the latest stable Ruby 1.9 release: 1.9.3-p194. Note: the -p stands for patch level. 

We recommend leveraging RVM to help with versioning Ruby on your machine and will help support developer environments utilizing that technology. We also recommend that you keep TinyTim's gems in an RVM gemset. You can read more about [installing RVM](https://rvm.io/rvm/install/), [RVM gemsets](https://rvm.io/gemsets/basics/), and the [.rvmrc](https://rvm.io/workflow/rvmrc/) if those concepts are foreign to you.

###Git Flow
Install [git-flow](https://github.com/nvie/gitflow) on your machine and initialize your local git repo of TinyTim with the default git-flow options by passing the -d flag to `git flow init`. Note: it is required to run `git flow init` on each local dev repository as it acts on your files locally.

        $ brew install git-flow
        $ git flow init -d                                                                                                             

## Contributing
1. Fork the project to your own personal Github account (using the Github interface is probably easiest for this step) and clone it locally to your dev machine **using the SSH url**.
    * Add a service hook from your individual fork of TinyTim to the Tracker project so that your commits will be visible in the stories before the pull requests are merged.
        - Click the "Admin" tab on your fork
        - Then click "Service Hooks" on the left menu
        - Then find 'PivotalTracker' in the list and click it, then scroll up to the top and add your Tracker Token from your [profile](https://www.pivotaltracker.com/profile) page.
1. Pull the latest code from the upstream master branch of the main project. Github has some [help on this topic](https://help.github.com/articles/fork-a-repo).

        $ git remote add upstream https://github.com/GreenBayRUG/TinyTim.git
        $ git fetch upstream
        $ git merge --no-ff upstream/master

1. Add a new feature story in Pivotal Tracker. 
    * The story name should be the feature name
    * The story description should contain a well formed Cucumber feature and at least one scenario. 
        - Additional scenarios could be handled as tasks in the story itself, or if it's a particularly large feature, perhaps leverage an [Epic](https://www.pivotaltracker.com/help#howcanmyteamplanandkeeptrackofbigfeaturesatahighlevel) by naming the Epic as the feature name and creating multiple stories inside it with the scenario description as the story name.
        - Always include the original feature definition when breaking apart a feature with multiple scenarios so that the context of the over-arching feature is preserved.
1. Create a new feature branch from your newly updated master branch utilizing [git-flow](https://github.com/nvie/gitflow): 

        $ git flow feature start my_cool_feature_12345678
    * Ensuring that the feature or bugfix has the story number appended will invoke [git\_tracker](https://github.com/highgroove/git_tracker) (once we properly configure it later) which will take care of including the story number in the commit message. We'll see later in the Pivotal Tracker section how we can create a feature directly from a Tracker story with our custom pivotal\_tracker.rake file without ever having to type the feature name or look up the story ID!
1. Code your awesome feature, committing early and often with [descriptive commit messages](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) ensuring:
    * The 'subject' (aka first line) is only 50 chars long.
    * The subject is of present tense.
    * Additional details are included in the commit message body when appropriate.
    * There is an empty line between the subject and the rest of the commit body.
1. Submit your new feature as a pull request to the main project so we can review and merge your code during the next meetup!!!


## Tracking Progress With Pivotal Tracker
We use [Pivotal Tracker](http://pivotaltracker.com) to keep track of who is doing what and our project is located at: [pivotaltracker.com/projects/569717](https://www.pivotaltracker.com/projects/569717). Please ensure all features have a story in Tracker to track them (hopefully creating the Tracker story before starting to code) so the whole group can follow along with commits and comments, etc.

### Attaching Commits To Stories
The Tracker project has been setup with a post commit service hook for the main repository. If you followed along with the Contributing section above, hopefully your fork has a service hook setup too. When you push your feature up to your fork the commits will show up attached to any Tracker story that was referenced. 

Here are some example commit messages that would link the commit to it's corresponding Tracker story:

    Adds comments to existing posts

    - Implemented with Disqus
    - Requires JavaScript
    - The disqus theme was customized to more closely match the app styles

    [Finishes #12345678]

Depending on what stage you're at, you can also use:

    [Fixes #12345678] or [Completes #12345678]

Or to just append the commit to the story and not change the state of the story itself just leave the story number by itself in brackets:

    [#12345678]

There are more options and tenses available too. Pivotal has [more info](https://www.pivotaltracker.com/help/api#scm_post_commit) about this feature if you'd like to check it out. 

### Creating New Features / Bugfixes Directly From Tracker Stories
To list stories from Pivotal Tracker at the command line and subsequently start a new feature or bugfix branch from the distilled story name, you can use the rake task "`bundle exec rake pt:list`". I created an alias 'ptl' on my system for this command.

To leverage this powerful rake task, you'll need to add the Tracker project details to your `~/.gitconfig` file (or create this file if it doesn't exist):

    $ vim ~/.gitconfig

Add the following anywhere in the file:

    [tinytim]
      projectid = 569717
      token = your_pivotal_tracker_token_here

Your Tracker token is located on your [profile](https://www.pivotaltracker.com/profile) page at the bottom in the API section.

Then at the root of the project type...

    bundle exec rake pt:list

Or use your alias, which will show a list of all undelivered stories that are in the 'current' or 'backlog' buckets:

    (1) add_project_readme_30887119
    (2) tagging_posts_30887549
    (3) commenting_posts_30887543

    (0) EXIT WITHOUT ANY ACTION

    For which story do you want to create a new git feature branch?
        Note: type 1 to create a feature branch for the first story.
        Note: type 1,hotfix to create a hotfix for the first story.
        Note: type 1,bugfix to create a bugfix for a release.

Typing 1 and pressing return (as the above prompt suggests) will use git-flow to create a new feature branch named after the story and append the story's ID to the end of the branch name. This lets the [git\_tracker](https://github.com/highgroove/git_tracker) gem use a (not yet installed) post-checkout hook to mark the story as started and will automatically add the story number to a new commit message for you!

In order to leverage these automatic features of git\_tracker, each dev must execute this command locally from the root of his or her local repository which will install the post-checkout hook:

    $ git-tracker install

You must also add the post-checkout hook described at the end of this guide.


## Coding Style

### Github Style Guide
Please refer to the [Github Ruby Styleguide](https://github.com/styleguide/ruby) for how code should be generally formatted. We won't flog you if your code doesn't exactly conform to the styleguide, but please try to follow it as cosely as possible. Of utmost importance are the first three "suggestions":

* Use soft-tabs with a two space indent.
* Keep lines fewer than 80 characters.
* Never leave trailing whitespace.

If you need help configuring your editor to use soft-tabs (spaces), or to making it automatically strip trailing white spaces, or setting the 80 column marker... please see the following references:

* [Sublime Text 2 Soft Tabs](http://screencast.com/t/0ronYzbZ)
* [Sublime Text 2 Auto Strip Trailing Whitespace](http://blog.nategood.com/sublime-text-strip-whitespace-save)
* [Sublime Text 2 80 Columns](http://www.sublimetext.com/forum/viewtopic.php?f=3&t=1510)
* Vim Soft Tabs - Add the following to your ~/.vimrc

        set shiftwidth=2         "number of spaces to use in each autoindent step
        set tabstop=2            "two tab spaces
        set softtabstop=2        "number of spaces to skip or insert when <BS>ing or <Tab>ing
        set expandtab            "spaces instead of tabs for better cross-editor compatibility
        set smarttab             "use shiftwidth and softtabstop to insert or delete (on <BS>) blanks

* [Vim Auto Strip Trailing Whitespace](https://github.com/itspriddle/vim-stripper)
* Vim 80 Columns (terminal vim)
        
        if version > 702         "Right margin settings for vim 7.2 or greater
          set colorcolumn=80
        endif



### Code Comments
Please use the following format when adding a NOTE or FIXME or TODO in a code comment:

    # NOTE (2012-06-07) j2fly => my cool note
    # FIXME (2012-06-07) j2fly => this is super busted 
    # TODO (2012-06-07) j2fly => put these inline styles into the sass file 

This will help keep track of when a comment was made and by whom more easily than having to do `git blame`


## Post Checkout Hook
Add the following to a file located at project\_root/.git/hooks/post-checkout where project\_root is whatever you called the root of the rails app locally on your machine.
    
    #!/usr/bin/env ruby
    require "rubygems"
    require "pivotal-tracker"
    branch =  `git symbolic-ref -q HEAD`
    branch_match = branch.match(/^refs\/heads\/(.+)/)
    branch = branch_match[1]
    story_id_match = branch.match(/_(\d{8,})/)

    if story_id_match
      storyid = story_id_match[1]
      token = `git config --get tinytim.token`
      projectid = `git config --get tinytim.projectid`
      PivotalTracker::Client.token = token
      PivotalTracker::Client.use_ssl = true
      project = PivotalTracker::Project.find(projectid)
      story = project.stories.find(storyid)
      case story.current_state
      when "unstarted"
        story.update(:current_state => "started")
        puts "started pivotal tracker story ##{storyid}: #{story.name}"
      when "started"
        puts "pivotal tracker story ##{storyid}: #{story.name} already started"
      end
    end

Change the permissions of the file as follows:

    $ chmod 755 post-checkout
