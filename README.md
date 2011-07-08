Code for America Geek Corps
=======

Our tool for micro-network building across our social networks

Installation
------------

We recommend using Ruby Version Manager

  git clone git@github.com:codeforamerica/geek_corps.git
  cd geek_corps
  bundle install
  bundle exec rake db:migrate
  bundle exec rake db:seed

For non-Code for America developers:
  Obtain API Keys for following services: Github, Facebook, Twitter, and Linkedin
  Copy the config/settings-local-sample.yml to config/settings.yml
  Alter the settings with your Github, LinkedIn, Twitter, Linkedin
  Alter the settings for AWS with your S3 credentials

For Code for America Developers (you'll need a google apps account):
  Copy https://docs.google.com/a/codeforamerica.org/document/d/1Z2a6XPjBU1bL763Y3y0etv3F84VJaeosaktaNB10UWw/edit?hl=en_US into config/settings.yml

To Reset the DB & Data

  bundle exec rake db:reset


Contributing
------------
In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues](http://github.com/codeforamerica/geek_corps/issues)
* by reviewing patches

Submitting an Issue
-------------------
We use the [GitHub issue tracker](http://github.com/codeforamerica/geek_corps/issues) to track bugs and
features. Before submitting a bug report or feature request, check to make sure it hasn't already
been submitted. You can indicate support for an existing issuse by voting it up. When submitting a
bug report, please include a [Gist](http://gist.github.com/) that includes a stack trace and any
details that may be necessary to reproduce the bug, including your gem version, Ruby version, and
operating system. Ideally, a bug report should include a pull request with failing specs.

Submitting a Pull Request
-------------------------
1. Fork the project.
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Add documentation for your feature or bug fix.
5. Run <tt>bundle exec rake doc:yard</tt>. If your changes are not 100% documented, go back to step 4.
6. Add specs for your feature or bug fix.
7. Run <tt>bundle exec rake spec</tt>. If your changes are not 100% covered, go back to step 6.
8. Commit and push your changes.
9. Submit a pull request. Please do not include changes to the gemspec, version, or history file. (If you want to create your own version for some reason, please do so in a separate commit.)

Copyright
---------
Copyright (c) 2011 Code for America Laboratories
See [LICENSE](https://github.com/codeforamerica/geek_corps/blob/master/LICENSE.mkd) for details.


[![Code for America Tracker](http://stats.codeforamerica.org/codeforamerica/geek_corps.png)](http://stats.codeforamerica.org/projects/geek_corps)