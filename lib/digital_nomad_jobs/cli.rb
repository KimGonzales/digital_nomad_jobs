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
        puts "Type 'exit' to exit"

        input = gets.strip

        case input
            when input == 1
                scrape and list web developer jobs from the website
            when input == 2
                scrape and list web design from the website 
            when input == 3
                scrape and list all the websites postings 
            when input == exit
                exit 
            else 
                puts 'not valid input'
                main menu 
            end
 
    end 


    
end