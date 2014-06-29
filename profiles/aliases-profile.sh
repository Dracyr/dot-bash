#!/bin/bash


## __LTH__ ##
alias lthssh="ssh dat12pp1@login.student.lth.se"
alias lthmount="gvfs-mount sftp://dat12pp1@login.student.lth.se"

## __HEROKU__ ##

alias hdeploy='git push heroku master'
alias hconsole='heroku run console'
alias hmigrate='heroku run rake db:migrate && heroku restart'
alias hdeploymigrate='hdeploy && hmigrate'

## __Ruby / RAILS__ ##

# Rails aliases
alias rc='rails console'
alias rd='rails destroy'
alias rdb='rails dbconsole'
alias rg='rails generate'
alias rgm='rails generate migration'
alias rp='rails plugin'
alias ru='rails runner'
alias rs='rails server'
alias rsd='rails server --debugger'

#Rake aliases
alias rdm='rake db:migrate'
alias rdr='rake db:rollback'
alias rdc='rake db:create'
alias rds='rake db:seed'
alias rdd='rake db:drop'
alias rdtc='rake db:test:clone'
alias rdtp='rake db:test:prepare'
alias rdmtc='rake db:migrate db:test:clone'
