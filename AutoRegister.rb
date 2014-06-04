##
# @author : Alan   
# @mail :  alan21120000@gmail.comment
# @Date : 2014/0525
# Program : for auto regiest and rank the ISBN book in the website  
# 
#

require 'http' 
require 'httpclient'

ISBN = { "isbn1" => 9574442527, "isbn2" => 9789867135575, "isbn3" => 9571341649, "isbn4" => 9789861857466 }
register_url = "http://140.114.77.202/Hbase/IBDb/addmember.php"
auth_url = "http://140.114.77.202/Hbase/IBDb/checkpwd.php"
score_url = 'http://140.114.77.202/Hbase/IBDb/Score_Hbase.php'


# random 100 users to register 
client = HTTPClient.new
user = nil
password = "dddd"
for id in 101..10000
    puts "register user stranger#{id} ......"  
    user = "stranger#{id}" 
    register_body = { "account" => user , "password" => password , "re_password" => password } 
    client.post(register_url,register_body)  

    puts " Now auto login user : #{user}   and add comment " 
    login_body = { 'account' => user , "password" => password } 
    client.post(auth_url,login_body)

    ISBN.each do |isbn| 
        random_score = 60 + rand(40)
        score_body = { 'search' => isbn[1], "score" => random_score.to_s } 
        puts "user : #{user} #{score_body}"
        client.post(score_url,score_body)
    end

end


