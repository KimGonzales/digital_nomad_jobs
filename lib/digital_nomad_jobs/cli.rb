class DigitalNomadJobs::CLI

    def call
        puts "Welcome to Digital Nomad Jobs!"
        main_menu 
    end 


    def main_menu
        puts "What Are You Looking For?"
        puts "Enter 1 for Web Developer Jobs"
        puts "Enter 2 for Web Design Jobs"
        puts "Enter 3 to List All Jobs"
        puts "Type '0' to exit"
    
        input = gets.strip.to_i
        
        case input
            when input = 1
                puts "scrape and list web developer jobs from the website"
            when input = 2
                puts "scrape and list web design from the website" 
            when input = 3
                puts "scrape and list all the websites postings" 
            when input = 0
                puts "Bye!"
                exit 
        end
    end 

    
end