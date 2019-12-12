# Project made for Information Security Management class at DSU
# Made during the Fall Semester of 2019 by Noah Woodman

# Goal of project is to be able to identify a phishing email
# Currently will be taking input from the raw data of the email
# Currently will be assuming you use yahoo mail as that is my test case

#setting up variables
expected_sender = "" # variable to store who you expect the email to be from
sender_from = ""
reciever_to = ""
flags = "" # this is a varaible which is used to help discuss if the email is a phishing email
file_given = ""
ans = ""
tot_ans = 0
orig_test = 0
user_test = ""

# this will give a help message or start the program
puts "Do you want to know about this program? (use 'Y' for Yes and 'N' for No)"
ans = gets.chomp
if ans == "Y"
  puts "The purpose of this program is to help you identify if a email is likely to be a phishing attempt.  It can also be used to help learn to analyze if an email is a phishing attempt."
end
puts ""

# this program will have the feature of analyzing the email itself or walking through the email
# this segment will be to check which functionality will be being used in this run-through of the program
puts "Do you want to have the program walk through the email with you, or analyze the email itself?"
puts "Press 1 to walk through, and 2 to analyze"
orig_test = gets.chomp

# this checks if the user wants to walk through the email
if orig_test == "1"
# one thing that phishing email like to do is impersonate a different company or person.
# However, since they may not have an email associated with that person or that company, they may have a different email address
# this sets up a varable which will check for any impersonations without an expected email address
# also a variable to take in the file to analyze
  begin # this begin rescue group is used to make sure that the file given is actualy a file that can be opened
    puts "What is the name of the file to walk through?"
    file_given = gets.chomp
    puts ""
    file = open(file_given)
    if file
      puts "File opened successfully"
    end
  rescue
    puts "That is not the name of a file which can be accessed"
    puts "Please try again"
    retry # retries the statement if necessary
  end
  puts "Who should this email address be from?"
  expected_sender = gets.chomp
  puts "Please answer any folowing questions with a 'Y' for Yes and a 'N' for No"
  puts ""
  # a feature which allows the user to search for a specific word- in case if they think that word is suspicious, or if they need help clasifying an email
  puts "Is there a specific phrase that you wish to search for?"
  puts "That you think would be suspicious?"
  puts "Type 'Y' for yes and anything else for no"
  ans = gets.chomp
  if ans == "Y"
    puts "What is the word that you would like to search for?"
    user_test = gets.chomp
  else
    user_test = ""
  end
# opening the file we want to use
  File.open(file_given).each do |line|
# these following include? statements are used to check if the specific line of the file we are on has a flag word that we want to know if is included
  if line.include? "From: " # this should tell us who sent the message
    sender_from = line
    if !(sender_from.include? expected_sender)
      puts "This is who the sender is listed as " + sender_from
      puts "This might be fishy, the expected sender was " + expected_sender
      puts ""
      puts ""
    end
  end
      if line.include? "username" # this will check if the phrase username was mentioned in the email.  Phishers will sometimes ask for usernames
        puts "Is this asking for your username?"
        puts line
        ans = gets.chomp
        if ans == "Y"
          tot_ans = tot_ans + 1
        end
        puts ""
      end
      if line.include? "password" # this will check if password appears in the email, which phishers may ask extend for
        puts "Is this asking for your password?"
        puts line
        ans = gets.chomp
        if ans == "Y"
          tot_ans = tot_ans + 1
        end
        puts ""
      end
      if line.include? "card" # will be used to check if the email asks for credit card information
        puts "Is this asking for your credit card information?"
        puts line
        ans = gets.chomp
        if ans == "Y"
          tot_ans = tot_ans + 1
        end
        puts ""
      end
    # the following are a list of some common words which may appear in a phishing email
    # these will be used to ask the user if they think that this email is suspicious
    # currently this program only helps in figuring out if an email is phishing
      if line.include? "infect" # searching for if the email claims there is an infection in the computer- should not be discussed in anything by a corporate email
        puts "Is this implying that your computer has a virus?"
        puts line
        ans = gets.chomp
        if ans == "Y"
          tot_ans = tot_ans + 1
        end
        puts ""
      end
      if line.include? "virus" # pretty much the same as above
        puts "Is this implying that your computer has a virus?"
        puts line
        ans = gets.chomp
        if ans == "Y"
          tot_ans = tot_ans + 1
        end
        puts ""
      end
      if line.include? "withdraw" # checking if asking to withdraw money from a bank account- however may be a bank saying that money was withdrawn
        puts "Is this asking about your bank account information?" # this could also help someone catch if there was suspicious activity
        puts line
        ans = gets.chomp
        if ans == "Y"
          tot_ans = tot_ans + 1
        end
        puts ""
      end
      if line.include? "bank" # may accidentally trigger in non-suspicious situations
        puts "Is this asking about your bank account information?"
        puts line
        ans = gets.chomp
        if ans == "Y"
          tot_ans = tot_ans + 1
        end
        puts ""
      end
      if line.include? "account" # may accidentally trigger in non-suspicious situations, account information should typically not be discussed over email
        puts "Is this asking about any account information?"
        puts line
        ans = gets.chomp
        if ans == "y"
          tot_ans = tot_ans + 1
        end
        puts ""
      end
      if line.include? "legal" # legal trouble is typically not assigned over email, however this may trigger by a recomendation for legal groups
        puts "Is this implying that you are in legal trouble?" #  may also trigger for an email from a legal company
        puts line
        ans = gets.chomp
        if ans == "Y"
          tot_ans = tot_ans + 1
        end
        puts ""
      end
      if line.include? "win" # don't click on random emails that say you won
        puts "Is this saying that you are the winner of a prize?"
        puts line
        ans = gets.chomp
        if ans == "Y"
          tot_ans = tot_ans + 1
        end
        puts ""
      end
      if line.include? "expire" # this can cause people to be anxious and click on things that they wouldn't already
        puts "Is this implying that your account of password is about to expire?"
        puts line
        ans = gets.chomp
        if ans == "Y"
          tot_ans = tot_ans + 1
        end
        puts ""
      end
      if line.include? "claim" # you probably shouldn't click on this
        puts "Is this prompting you to claim a prize?"
        puts line
        ans = gets.chomp
        if ans == "Y"
          tot_ans = tot_ans + 1
        end
        puts ""
      end
      # This was a good but triggers too often
      #if line.include? "http"
        #puts "Does this look like a link to an external site?"
        #puts line
        #ans = gets.chomp
        #if ans == "Y"
          #tot_ans = tot_ans + 1
        #end
        #puts ""
      #end
      if line.include? "link" # links are usually suspicious, you may want to paste these into a browser before you visit them and review their content
        puts "Is this asking you to click on a link?"
        puts line
        ans = gets.chomp
        if ans == "Y"
          tot_ans = tot_ans + 1
        end
        puts ""
      end
      if user_test != ""
        if line[user_test]
          puts "The word you requested be searched for was encountered."
          puts "In this context is the word suspicious?"
          puts line
          ans = gets.chomp
          if ans == "Y"
            tot_ans = tot_ans + 1
          end
          puts ""
        end
      end
    end

# allows the user to search for multiple words, will loop through the email for as long as needed
puts "Are there any other words you would like to search for?"
ans = gets.chomp
while ans == "Y"
  puts "What is the word you would like to search for?"
  user_test = gets.chomp
  File.open(file_given).each do |line|
    if line.include? user_test
      puts "The word you request be searched for was encountered."
      puts "In this context is the word suspicious?"
      puts line
      ans = gets.chomp
      if ans == "Y"
        tot_ans = tot_ans + 1
      end
      puts ""
    end
  end
  puts "Are there any other words you would like to search for?"
  ans = gets.chomp
end

    # after tallying all the answers that the user found suspicious, it shows the data to the user so they can make their decision
    print_ans = tot_ans.to_s
    puts "You said that " + print_ans + " many lines were suspicious!"
    if tot_ans == 0
      puts "Congratulations, this email doesn't seem to be suspicious!"
    end
    if tot_ans > 0
      puts "This email is suspicious, best to review it crtically"
    end
  end

# if the user want the program to analyze the email, this will be much quicker than walking through it
  if orig_test == "2"
    begin
      puts "What is the name of the file to analyze?"
      file_given = gets.chomp
      puts ""
      file = open(file_given)
      if file
        puts "File opened successfully"
      end
    rescue
      puts "That is not the name of a file which can be accessed"
      puts "Please try again"
      retry
    end
    # flag variables to check if certain words are found in the email
    sender_flag = 0
    username_flag = 0
    password_flag = 0
    card_flag = 0
    infect_flag = 0
    virus_flag = 0
    withdraw_flag = 0
    bank_flag = 0
    account_flag = 0
    legal_flag = 0
    win_flag = 0
    expire_flag = 0
    claim_flag = 0
    http_flag = 0
    link_flag = 0
    user_flag = 0
    tot_flag = 0

    puts "Who should this email address be from?"
    expected_sender = gets.chomp
    puts ""
    puts "Are there any words that you would wish to search for? type 'Y' for yes and anything else for no."
    ans = gets.chomp
    if ans == "Y"
      puts "What is they word you are searching for?"
      user_test = gets.chomp
    else
      user_test = ""
    end
    puts "Analyzing email..."
    puts ""

    File.open(file_given).each do |line|
      if line.include? "From: " # this should tell us who sent the message
        sender_from = line
        if !(sender_from.include? expected_sender)
          sender_flag = 1
        end
      end
    if line.include? "username" # checks if word is found and then increments variables
        username_flag += 1
        tot_flag = 1
    end
    if line.include? "password"
        password_flag += 1
        tot_flag = 1
    end
    if line.include? "card"
        card_flag += 1
        tot_flag = 1
    end
    if line.include? "infect"
        infect_flag += 1
        tot_flag = 1
    end
    if line.include? "virus"
        virus_flag += 1
        tot_flag = 1
    end
    if line.include? "withdraw"
        withdraw_flag += 1
        tot_flag = 1
    end
    if line.include? "bank"
        bank_flag += 1
        tot_flag = 1
    end
    if line.include? "account"
        account_flag += 1
        tot_flag = 1
    end
    if line.include? "legal"
        legal_flag += 1
        tot_flag = 1
    end
    if line.include? "win"
        win_flag += 1
        tot_flag = 1
    end
    if line.include? "expire"
        expire_flag += 1
        tot_flag = 1
    end
    if line.include? "claim"
        claim_flag += 1
        tot_flag = 1
    end
    if line.include? "http"
      http_flag += 1
      tot_flag = 1
    end
    if line.include? "link"
      link_flag += 1
      tot_flag = 1
    end
    if line.include? user_test
      user_flag +=1
      tot_flag = 1
    end
  end


    output = File.open("results.txt", "w") # opens the results file to write to it- the export file is so the user can access the results at a later time
    if tot_flag == 0 # if nothing suspicous was found
      puts "This email did not show any obvious signs of being a phishing email."
      puts "However, it is still best to show caution."
      output << "This email did not show any obvious signs of being a phishing email.\n"
      output << "However, it is still best to show caution.\n"
    end
    if tot_flag == 1 # if there was somehting suspicious found
      puts "Signs were found that point to this being a potential phishing email."
      puts "Please hit enter after reading each of the warnings we have put togeather."
      puts ""
      output << "Signs were found that point to this being a potential phishing email.\n"
      output << "Please hit enter after reading each of the warnings we have put togeather.\n\n"
      ans = gets.chomp
      if sender_flag == 1 # each of these are for checking for a specific trigger
        puts "This email was from a email address which did not match who you expected it to be from."
        puts "This could mean that it is a phishing email which is pretending to be from a source it has no affiliation with."
        puts ""
        output << "This email was from a email address which did not match who you expected it to be from.\n"
        output << "This could mean that it is a phishing email which is pretending to be from a source it has no affiliation with.\n\n"
        ans = gets.chomp
      end
      if username_flag > 0
        puts "The email made mentions about a username."
        puts "If this email is asking for your username, it is likely a phishing email."
        puts "You should not have to provide your username over email."
        puts ""
        output << "The email made mentions about a username.\n"
        output << "If this email is asking for your username, it is likely a phishing email.\n"
        output << "You should not have to provide your username over email.\n\n"
        ans = gets.chomp
      end
      if password_flag > 0
        puts "The email made mentions about a password."
        puts "If this email is asking for your password, it is likely a phishing email."
        puts "You should not have to provide your password over email."
        puts ""
        output << "The email made mentions about a password.\n"
        output << "If this email is asking for your password, it is likely a phishing email.\n"
        output << "You should not have to provide your password over email.\n\n"
        ans = gets.chomp
      end
      if card_flag > 0
        puts "The email made mentions about a card (potentially a credit card)."
        puts "While regular emails do somethimes mention credit cards, check if this is asking for you to provide credit card information."
        puts "If so, this may be a phishing email."
        puts "It is not very secure to provide your credit card information over email."
        puts ""
        output << "The email made mentions about a card (potentially a credit card).\n"
        output << "While regular emails do somethimes mention credit cards, check if this is asking for you to provide credit card information.\n"
        output << "If so, this may be a phishing email.\n"
        output << "It is not very secure to provide your credit card information over email.\n\n"
        ans = gets.chomp
      end
      if infect_flag > 0
        puts "The email made mentions about an infection."
        puts "While this could be normal, check the email and see if it is implying that your computer is infected."
        puts "If so, this is likely a phishing email."
        puts ""
        output << "The email made mentions about an infection.\n"
        output << "While this could be normal, check the email and see if it is implying that your computer is infected.\n"
        output << "If so, this is likely a phishing email.\n\n"
        ans = gets.chomp
      end
      if virus_flag > 0
        puts "The email made mentions about a virus."
        puts "While this could be normal, check the email and see if it is implying that your computer has a virus."
        puts "If so, this is likely a phishing email."
        puts ""
        output << "The email made mentions about a virus.\n"
        output << "While this could be normal, check the email and see if it is implying that your computer has a virus.\n"
        output << "If so, this is likely a phishing email.\n\n"
        ans = gets.chomp
      end
      if withdraw_flag > 0
        puts "This email made mentions about withdrawing something (potentially money)."
        puts "While this may be from your bank, check to see if someone is pressuring you to withdraw money from your account."
        puts "If so, this may be a phishing email."
        puts ""
        output << "This email made mentions about withdrawing something (potentially money).\n"
        output << "While this may be from your bank, check to see if someone is pressuring you to withdraw money from your account.\n"
        output << "If so, this may be a phishing email.\n\n"
        ans = gets.chomp
      end
      if bank_flag > 0
        puts "This email made mentions about a bank (or banks)."
        puts "This could be perfectly normal, but if someone if asking for your banking information, it may be a sign of a phishing email."
        puts ""
        output << "This email made mentions about a bank (or banks).\n"
        output << "This could be perfectly normal, but if someone if asking for your banking information, it may be a sign of a phishing email.\n\n"
        ans = gets.chomp
      end
      if account_flag > 0
        puts "This email made mentions about an account."
        puts "This could be about creating an account of a change to your account."
        puts "However, if it is asking for your account information, it may be a phishing email."
        puts "It is best practice not to share your account information over email."
        puts ""
        output << "This email made mentions about an account.\n"
        output << "This could be about creating an account of a change to your account.\n"
        output << "However, if it is asking for your account information, it may be a phishing email.\n"
        output << "It is best practice not to share your account information over email.\n\n"
        ans = gets.chomp
      end
      if legal_flag > 0
        puts "This email made mentions about legality."
        puts "This could be normal, however, check to see if this is implying that you are in legal trouble."
        puts "If so, this could be a phishing email trying to scare you."
        puts ""
        output << "This email made mentions about legality.\n"
        output << "This could be normal, however, check to see if this is implying that you are in legal trouble.\n"
        output << "If so, this could be a phishing email trying to scare you.\n\n"
        ans = gets.chomp
      end
      if win_flag > 0
        puts "This email made mentions about winning."
        puts "This could be normal.  However, if it is claiming that you have won a prize, this could be a phishing email."
        puts ""
        output << "This email made mentions about winning.\n"
        output << "This could be normal.  However, if it is claiming that you have won a prize, this could be a phishing email.\n\n"
        ans = gets.chomp
      end
      if expire_flag > 0
        puts "This email made mentions about expiring."
        puts "If this email mentions that you have a prize that is about to expire, this could be a phishing email."
        puts "Do not click on the link unless you absolutely trust it."
        puts ""
        output << "This email made mentions about expiring.\n"
        output << "If this email mentions that you have a prize that is about to expire, this could be a phishing email.\n"
        output << "Do not click on the link unless you absolutely trust it.\n\n"
        ans = gets.chomp
      end
      if claim_flag > 0
        puts "This email made mentions about claiming something."
        puts "This could be a phishing email."
        puts "Do not click on the link to claim the prize, unless you are absolutely sure that it is legit."
        puts ""
        output << "This email made mentions about claiming something.\n"
        output << "This could be a phishing email.\n"
        output << "Do not click on the link to claim the prize, unless you are absolutely sure that it is legit.\n\n"
        ans = gets.chomp
      end
      if http_flag > 0
        puts "This email had a link embedded in it."
        puts "Please review this link."
        puts "On one hand, it may be a harmless link which directs you to a company's contact information or privacy policy"
        puts "On the other hand... It may be fishy.  Do not click on it if you suspect that it is dangerous."
        puts ""
        output << "This email had a link embedded in it.\n"
        output << "Please review this link.\n"
        output << "On one hand, it may be a harmless link which directs you to a company's privacy policy or contact information\n"
        output << "On the other hand..."
        output << "It may be fishy.  Do not click on it if you suspect that it is dangerous.\n\n"
        ans = gets.chomp
      end
      if link_flag > 0
        puts "This email asked you to click on a link."
        puts "Review this link and it's context, please."
        puts "If this seems suspicious or irrelevant, it is best to not interact with it."
        puts ""
        output << "This email asked you to click on a link.\n"
        output << "Please check for any links ans review them.\n"
        output << "If they seem suspicious or irrelevant, it is best to not interact with them.\n\n"
      end
      if user_flag > 0
        puts "The word you searched for appears in this email."
        puts "That word was: " + user_test
        puts "Please review its context."
        puts ""
        output << "The word you searched for appears in thie email.\n"
        output << "That word was: "
        output << user_test
        output << "\nPlease review its context.\n\n"
      else
        puts "The word you searched for does not appear in this email."
        puts "That word was: " + user_test
        puts ""
        output << "The word you searched for does not appear in this email.\n"
        output << "That word was: "
        output << user_test
        output << "\n\n"
      end
    end

    user_Test = ""
    user_flag = 0
    puts "Is there another word you want to search for? hit 'Y' for yes." # allows the user to search for another word
    ans = gets.chomp
    while ans == "Y"
      puts "What word do you want to search for?"
      user_test = gets.chomp
      File.open(file_given).each do |line|
        if line.include? user_test
          user_flag += 1
        end
      end
      if user_flag > 1
        puts "The word you searched for appears in this email."
        puts "That word was: " + user_test
        puts "Please review its context."
        puts ""
        output << "The word you searched for appears in thie email.\n"
        output << "That word was: "
        output << user_test
        output << "\nPlease review its context.\n\n"
      else
        puts "The word you searched for does not appear in this email."
        puts "That word was: " + user_test
        puts ""
        output << "The word you searched for does not appear in this email.\n"
        output << "That word was: "
        output << user_test
        output << "\n\n"
      end
      puts "Do you want to search for another word?"
      ans = gets.chomp
    end

    output << "End" # closes the export file
    output.close

    puts "" # does some cleanup and gives the user instructions for what to do next
    puts "Please review the points that were just mentioned."
    puts "For ease of use, they were put in a text file called results.txt."
    puts "These may be normal, but they could also be signs of a phishing email."
    puts "Use your best judgement, and rememeber to be cautious and safe!"
end
