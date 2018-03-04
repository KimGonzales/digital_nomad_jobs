class DigitalNomadJobs::CLI

  PATH =('https://remoteok.io')

  def call 
    welcome 
    main_menu
  end 
  
  def welcome
    puts "================================================"
    puts ")       Welcome to DIGITAL NOMAD JOBS!         ("
    puts "================================================"
    puts "                LET'S EXPLORE                  "
  end 


  def main_menu
    puts ""
    puts "========         MAIN MENU          ============"
    puts "                                                "
    puts "            What Are You Looking For?"
    puts ""
    puts "Enter '1' for Web Developer Jobs"
    puts "Enter '2' for UX/UI & Web Design Jobs"
    puts "Enter '3' to List The 100 Latest Remote Jobs"
    puts "Enter '0' or type 'exit' to exit"
    puts "=========       x x x x x x x      ============="
    select_option
  end 

  def select_option
    input = gets.strip.to_s

    case input
      when '1'
        make_dev_jobs
      when '2'
        make_design_jobs
      when '3'
        make_all_the_jobs
      when '0','exit'
        puts "Bye!"
        exit 
      else 
        puts "Whoops didn't get that! Say it again."
        main_menu
    end
  end 

  def make_dev_jobs
    DigitalNomadJobs::Job.reset
    job_array = DigitalNomadJobs::Scraper.scrape_jobs(PATH + '/remote-dev-jobs')
    DigitalNomadJobs::Job.create_from_collection(job_array)
    puts ""
    puts "   NABBING THE MOST RECENT WEB-DEV JOBS         "
    puts "------------------------------------------------"
    puts ""
    add_descriptions_to_jobs
    display_jobs
  end

  def make_design_jobs
    DigitalNomadJobs::Job.reset
    job_array = DigitalNomadJobs::Scraper.scrape_jobs(PATH + '/remote-design-jobs')
    DigitalNomadJobs::Job.create_from_collection(job_array)
    puts ""
    puts "A LIST OF NEW UX AND DESIGN JOBS ARE ON ZE WAY" 
    puts "------------------------------------------------"
    puts ""
    add_descriptions_to_jobs
    display_jobs 
  end

  def make_all_the_jobs
    DigitalNomadJobs::Job.reset
    job_array = DigitalNomadJobs::Scraper.scrape_jobs(PATH)
    DigitalNomadJobs::Job.create_from_collection(job_array)
    puts ""
    puts "Latest 100 Remote Jobs - Coming Right Up!" 
    puts "------------------------------------------------"
    puts ""
    puts "We're Loading Some Pretty Sweet Gigs...."
    add_descriptions_to_jobs
    display_jobs
  end

  def display_jobs
    DigitalNomadJobs::Job.all.each.with_index(1) do |job, i|
      puts "-----------------------------------------------------------------------------------------------"
      puts "#{i}. #{job.title} - #{job.company} - #{job.time_posted}"
      puts "-----------------------------------------------------------------------------------------------"
      puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    end 
    select_position
  end

  def select_position
    puts ""
    puts ""
    puts "Interested in a Position?"
    puts "Enter It's Number to Learn More!"
    puts "Rather go back? Type 'main' to Head Back to the Main Menu" 
    puts "Enter 'exit' to Peace Out"

    position = gets.strip

    if position.to_s == 'main'
      main_menu
    elsif position.to_i.between?(0,(DigitalNomadJobs::Job.all.length-1))
      selected_job = DigitalNomadJobs::Job.all[(position.to_i - 1)]
    elsif position.to_s == 'exit'
      exit 
    else 
      puts "Pick another number, Friend. That one isn't valid."
      select_position
    end 

    selected_job.print_description
    navigation
  end 

  def navigation
    puts ''
    puts "Type 'main' to go back to the Main Menu"
    puts "Type 'list' if you'd like to the list again"
    puts "Type 'exit' if you're giving the job hunt a rest for now"

    input = gets.strip 

    case input 
      when 'main'
          main_menu
      when 'list'
          display_jobs
      when 'exit'
          exit 
      else 
          puts 'Not all who wander are lost! But you might be. Pick again.'
          navigation   
    end
  end
      

  def add_descriptions_to_jobs
    DigitalNomadJobs::Job.all.each do |job|
    description_hash = DigitalNomadJobs::Scraper.scrape_descriptions(PATH + job.job_url)
    job.add_job_description(description_hash)
    end 
  end 

  
end