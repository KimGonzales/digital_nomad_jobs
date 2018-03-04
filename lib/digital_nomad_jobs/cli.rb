class DigitalNomadJobs::CLI

  PATH =('https://remoteok.io')

  def call 
    welcome 
    main_menu
  end 
  


#---------------------    CLI MENUS ----------------------------------------#
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
    select_job_maker 
  end 

  def select_job_maker
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
        puts "Whoops that input isn't valid! Hit me Again."
        main_menu
    end
  end 

  def list_menu
    puts "===========     LIST MENU    ==================="
    puts ""
    puts "Enter '1' For A List of The Most Recent Job Postings"
    puts "Enter '2' For A List of The Companies Hiring"
    puts "Enter '0' To Exit"
    puts "Enter 'Main' To Go Back To The Main Menu"
    puts "================================================"
    user_input = gets.strip.to_s

    case user_input 
      when '1'
        display_jobs
      when '2'
        display_companies 
      when 'Main', 'main'
        main_menu
      when '0', 'exit'
        exit 
      else 
        "That input isn't valid! Try again."
        list_menu
      end 
  end 




  #-----------------------------  COMPANY LIST -------------------------------------#

    def choose_company_description
      puts "Choose The Number of A Company To See It's Recent Job Posts"
      ######action here - enter other menu options
      company_number = gets.strip.to_i 
      chosen_company = DigitalNomadJobs::Company.all[company_number-1]
      chosen_company.print_company_jobs
      navigation 
      #TO DO: VALIDATE INPUT 
    end 


  #-------------------------- CLI JOB FACTORY -------------------------------------#

  
  def make_dev_jobs
    DigitalNomadJobs::Job.reset
    job_array = DigitalNomadJobs::Scraper.scrape_jobs(PATH + '/remote-dev-jobs')
    DigitalNomadJobs::Job.create_from_collection(job_array)
    puts ""
    puts "   NABBING AWESOME AVAILABLE WEB-DEV JOBS       "
    puts "------------------------------------------------"
    puts "            WEB DEVELOPER JOBS "
    add_descriptions_to_jobs
    list_menu
  end


  def make_design_jobs
    DigitalNomadJobs::Job.reset
    job_array = DigitalNomadJobs::Scraper.scrape_jobs(PATH + '/remote-design-jobs')
    DigitalNomadJobs::Job.create_from_collection(job_array)
    puts ""
    puts "A LIST OF NEW UX AND DESIGN JOBS ARE ON ZE WAY" 
    puts "------------------------------------------------"
    puts "              WEB DESIGN JOBS"
    add_descriptions_to_jobs
    list_menu
  end

  def make_all_the_jobs
    DigitalNomadJobs::Job.reset
    job_array = DigitalNomadJobs::Scraper.scrape_jobs(PATH)
    DigitalNomadJobs::Job.create_from_collection(job_array)
    puts ""
    puts "10 Latest Remote Jobs - Coming Right Up!" 
    puts "------------------------------------------------"
    puts "              REMOTE JOBS"
    puts "Loading Some Pretty Sweet Gigs..."
    add_descriptions_to_jobs
    list_menu 
  end

#--------------------------------   CLI DISPLAY METHODS -----------------------------#
  def display_companies
    DigitalNomadJobs::Company.list_companies
    choose_company_description 
  end 


  def display_jobs
    DigitalNomadJobs::Job.list_all_jobs
    select_job_description 
  end



  def select_job_description
    puts "Enter The Number of a Job Posting For a Detailed  Description"
    job_input = gets.strip.to_i
    selected_job = DigitalNomadJobs::Job.all[(job_input.to_i - 1)]
    selected_job.print_job_description
    navigation
    # TO DO: VALIDATE INPUT 
  end



  def navigation
    puts ""
    puts "========         NAVIGATION          ==========="                                              
    puts "              Where Ya Headed Now?"    
    puts ""
    puts "Enter 'Main' to go Back to the Main Menu"
    puts "Enter 'List' To Go Back to the List Menu"
    puts "Enter 'Exit' to Exit."
    puts "=========       x x x x x x x      ============="
    puts ""
    input = gets.strip.to_s

    case input 
      when 'main', 'Main'
        main_menu
      when 'list', 'List'
        list_menu
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
