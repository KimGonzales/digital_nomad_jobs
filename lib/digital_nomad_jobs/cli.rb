class DigitalNomadJobs::CLI

    PATH =("https://remoteok.io")

    def call
        puts "Welcome to Digital Nomad Jobs!"
        main_menu 
    end 


    def main_menu
        puts "###################################"
        puts "======== +  MAIN MENU + ==========="
        puts "What Are You Looking For?"
        puts "Enter '1' for Web Developer Jobs"
        puts "Enter '2' for UX/UI and Design Jobs"
        puts "Enter '3' to List All Jobs"
        puts "Enter '0' to exit"
        puts "###################################"
        select_list
    end 

    def select_list
        input = gets.strip.to_i

        case input
            when input = 1
                make_dev_jobs
            when input = 2
                make_design_jobs
            when input = 3
                make_jobs
            when input = 0
                puts "Bye!"
                exit 
            else 
                "Whoops didn't get that! Say it again."
                main_menu
        end
    end 

    def make_dev_jobs
        puts "SCRAPE THAT WEB DEVELOPER."
    end

    def make_design_jobs
        puts "SCRAPE THE DESIGN!" 
    end

    def make_jobs
        puts "ALL THE THINGS!" 
        job_hash = DigitalNomadJobs::Scraper.scrape_jobs(PATH)
    end

    
end