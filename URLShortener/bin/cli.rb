#!/usr/bin/env ruby
require 'byebug'

print "Please enter email: "
email = gets.chomp
user = User.find_by(email: email)

if user
  print "What would you like to do? Enter 1 or 2:\n"
  print "1. Visit a short URL; or \n"
  print "2. Create a new URL\n"

  option = gets.chomp

  if option == "1"
    # debugger
    print "Please choose from the below URLs.\n"
    ShortenedUrl.all.each_with_index do |url, i|
      # debugger
      print "#{i+1}. #{url.short_url}\n"
    end
    print "Type your number here -->"
    chosen_num = gets.chomp.to_i
    chosen_url_obj = ShortenedUrl.find(chosen_num)
    chosen_url = chosen_url_obj.long_url
    Visit.record_visit!(user, chosen_url_obj)
    system("launchy #{chosen_url}")
  else
    print "Please enter URL that you would like to shorten: \n"
    old_url = gets.chomp
    new_url = ShortenedUrl.create_short_url(user, old_url)
    print "Your short URL is #{new_url.short_url}.\n"
  end
else
  print "You are not a registered user.\n"
end
