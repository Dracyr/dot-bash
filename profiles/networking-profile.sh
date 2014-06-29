#!/bin/bash

## __NETWORKING__ ##

# Quick look online hosts
alias whoisup='fping -c1 -gds 192.168.1.0/24 2>&1| egrep -v "ICMP|xmt"'
# Get local IP
alias localip="hostname -I"
# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# Show active network listeners
alias netlisteners='netstat -untap'
alias checkconnection="ping www.google.com"

# Get external IP
alias myip='curl ip.appspot.com'
alias externalip='myip'

# Logs all GET and POST requests on port 80
alias sniff="sudo ngrep -d 'wlan0' -t '^(GET|POST) ' 'tcp and port 80'"

headers() {
  curl -sv "$@" 2>&1 >/dev/null |
    grep -v "^\*" |
    grep -v "^}" |
    cut -c3-
}

# One of @janmoesen’s ProTips
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

# Create a data URL from a file
dataurl() {
  if [[ -z "$1" ]] || [[ $1 == "-help" ]] || [[ $1 == "--help" ]]; then
    echo "Usage:"
    echo -e "\t dataurl <path_to_file>"
    echo "creates a data URL from specified file."
  else
    local mimeType=$(file -b --mime-type "$1")
    if [[ $mimeType == text/* ]]; then
      mimeType="${mimeType};charset=utf-8"
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
  fi
}

# URL-encode strings
urlencode() {
  if [[ -z "$1" ]] || [[ $1 == "-help" ]] || [[ $1 == "--help" ]]; then
    echo "Usage:"
    echo -e "\t urlencode <any_string>"
    echo "URL-encodes specified string"
  else
    python -c "import sys, urllib as ul; print ul.quote_plus('$1');"
  fi
}

# Shorten given URL
shortenurl() {
  curl -s http://is.gd/api.php?longurl=`perl -MURI::Escape -e "print uri_escape('$1');"`
  echo
}

# Display URL true destination
expandurl() {
  curl -sIL $1 | grep ^Location
}