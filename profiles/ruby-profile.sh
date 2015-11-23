## __Ruby / RAILS__ ##

# Rails aliases
alias rc='rails console'
alias rs='rails server'
alias rg='rails generate'
#Rake aliases
alias rdm='rake db:migrate'
alias rdr='rake db:rollback'

## __HEROKU__ ##
alias hdeploy='git push heroku master; heroku run rake db:migrate'
alias hrc='heroku run console'
alias hrdm='heroku run rake db:migrate && heroku restart'

# Rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Also node 
. ~/.nvm/nvm.sh