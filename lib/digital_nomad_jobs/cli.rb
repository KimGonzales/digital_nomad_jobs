class DigitalNomadJobs::CLI

    PATH =("https://remoteok.io")

    def call 
        welcome 
        main_menu
    end 
    
    def welcome
        puts "###################################"
        puts ")))Welcome to Digital Nomad Jobs((("
        puts "###################################"
    end 


    def main_menu
        puts "======== +  MAIN MENU + ==========="
        puts "What Are You Looking For?"
        puts "Enter '1' for Web Developer Jobs"
        puts "Enter '2' for UX/UI and Design Jobs"
        puts "Enter '3' to List All Jobs"
        puts "Enter '0' to exit"
        puts "========= + + + + + + +============"
        select_option
    end 

    def select_option
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
        job_array = DigitalNomadJobs::Scraper.scrape_jobs(PATH)
        DigitalNomadJobs::Job.create_from_collection(job_array)
        display_jobs
    end

    def display_jobs
        puts ''
        puts 'CHECK OUT NEW REMOTE JOB POSTINGS BELOW' 
        puts '------------------------------------------------'
        puts ''
        DigitalNomadJobs::Job.all.each.with_index(1) do |job, i|
            puts "#{i}. #{job.title} - #{job.company}"
            puts ''
        end 
    end

    
end