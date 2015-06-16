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
alias rs='rails server'
alias rsd='rails server --debugger'

#Rake aliases
alias rdm='rake db:migrate'
alias rdr='rake db:rollback'

# Rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Also node 
. ~/.nvm/nvm.sh