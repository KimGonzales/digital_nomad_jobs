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
    puts "                LET'S EXPLORE                   "
  end 


  def main_menu
    puts ""
    puts "========         MAIN MENU          ============"
    puts "                                                "
    puts "            What Are You Looking For?"
    puts ""
    puts "Enter '1' for Web Developer Jobs"
    puts "Enter '2' for UX/UI & Web Design Jobs"
    puts "Enter '3' to List The 10 Latest Remote Jobs"
    puts "Enter '0' or type 'exit' to exit"
    puts ""
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
    puts "   NABBING AWESOME AVAILABLE WEB-DEV JOBS       "
    puts "------------------------------------------------"
    puts ""
    add_descriptions_to_jobs
    list_menu
    #display_jobs
  end

  def list_menu
    puts "Enter '1' To See a List of The Most Recent Job Postings"
    puts "Enter '2' To See a List of The Companies Hiring"
    user_input = gets.strip.to_s

    case user_input 
      when '1'
        display_jobs
      when '2'
        DigitalNomadJobs::Company.list_companies
        choose_company_description 
      else 
        main_menu
      end 
  end 


  #------------------------- COMPANY------------------------------------#

    def choose_company_description
      puts "Choose A Number of A Company If You'd like to See a detailed list of it's Open Job Positions"
      company_number = gets.strip.to_i 
      chosen_company = DigitalNomadJobs::Company.all[company_number-1]
      chosen_company.print_company_jobs 
    end 


  #-------------------------- JOB  -------------------------------------#

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
    puts "10 Latest Remote Jobs - Coming Right Up!" 
    puts "------------------------------------------------"
    puts ""
    puts "Loading Some Pretty Sweet Gigs..."
    add_descriptions_to_jobs
    display_jobs
  end

  def display_jobs
    DigitalNomadJobs::Job.list_all_jobs
    select_position
  end

  def select_position
    #turn into description menu for List or To see Company information?
    puts ""
    puts ""
    puts "Interested in a Position?"
    puts "Enter It's Number to Learn More!"
    puts "Rather go back? Type 'main' to Head Back to the Main Menu" 
    puts "Enter 'exit' to Peace Out"

    position = gets.strip.to_s

    if position == 'main'
      main_menu
    elsif position == 'exit'
      exit 
    elsif position.to_i.between?(0,(DigitalNomadJobs::Job.all.size))
      selected_job = DigitalNomadJobs::Job.all[(position.to_i - 1)]
    else 
      puts "Pick Another Number, Friend. That One Isn't Valid."
      select_position
    end 

    selected_job.print_job_description
    navigation
  end 

  def navigation
    puts ""
    puts "========         NAVIGATION          ==========="                                              
    puts "              Where Ya Headed Now?"    
    puts ""
    puts "Enter 'Main' to go Back to the Main Menu"
    puts "Enter 'List' To See That List of Jobs Again."
    puts "Enter 'Companies' to See a List of The Companies Hiring"
    puts "Enter 'Exit' to Exit."
    puts "=========       x x x x x x x      ============="
    puts ""
    input = gets.strip.to_s

    case input 
      when 'main', 'Main'
        main_menu
      when 'list', 'List'
        display_jobs
      when 'exit', 'Exit'
        exit 
      else 
        puts 'Not All Those Who Wander Are Lost... But You Might Be!'
        puts 'Please Pick a Valid Option'
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
