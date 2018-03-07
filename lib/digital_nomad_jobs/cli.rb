class DigitalNomadJobs::CLI

  PATH =('https://remoteok.io')

  def call 
    welcome 
    main_menu
  end 

  #----------------------------------        CLI MENUS      ----------------------------------#
 
  def welcome
    puts "================================================".blue 
    puts ")       Welcome to DIGITAL NOMAD JOBS!         (".blue  
    puts "================================================".blue
    puts "                 LET'S EXPLORE                  ".white.on_blue
  end 


  def main_menu
    puts ""
    puts "========     🌎    MAIN MENU    🌎     ==========".blue 
    puts "                                                ".blue 
    puts "            What Are You Looking For?".blue 
    puts ""
    puts "Enter '1' for The Latest Web Developer Jobs" 
    puts "Enter '2' for The Latest UX/UI & Web Design Jobs" 
    puts "Enter '3' for The Latest Remote Jobs"
    puts "Enter '0' or type 'exit' to exit"
    puts ""
    puts "=========       x x x x x x x      =============".blue 
    select_job_maker 
  end 


  def list_menu
    puts "===========     LIST MENU    ===================".blue 
    puts ""
    puts "Enter '1' For A List of The Most Recent Job Postings"
    puts "Enter '2' For A List of The Companies Hiring"
    puts "Enter '0' To Exit"
    puts "Enter 'Main' To Go Back To The Main Menu"
    puts "================================================".blue 
    user_input = gets.strip.to_s

    case user_input 
    when '1'
      display_jobs
    when '2'
      display_companies 
    when 'Main', 'main'
      main_menu
    when '0', 'exit'
      puts "Thanks for Visiting!"
      exit 
    else 
      error
      list_menu
    end 
  end 


  def navigation
    puts ""
    puts "========         NAVIGATION          ===========".blue                                              
    puts "              Where Ya Headed Now?".blue     
    puts ""
    puts "Enter 'Main' to go Back to the Main Menu"
    puts "Enter 'List' To Go Back to the List Menu"
    puts "Enter 'Exit' to Exit."
    puts "=========       x x x x x x x      =============".blue
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
      puts 'Not All Those Who Wander Are Lost... But You Might Be!'.cyan 
      error 
      navigation   
    end
  end 

  #----------------------------------        CLI INPUT SELECTORS      ----------------------------------#
  
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
      puts "Bye!".blue 
      exit 
    else 
      puts "Whoops! Please enter a valid option.".magenta 
      main_menu
    end
  end 


  def select_company
    puts ""
    puts "Enter The Number of A Company To See It's Recent Job Posts" 
    cn = gets.strip.to_i    
    if valid_company?(cn) 
      comp = DigitalNomadJobs::Company.all[cn-1]
      comp.print_company_jobs
      navigation 
    else 
      error
      select_company 
    end 
  end


  def valid_company?(input)
    input.between?(1, DigitalNomadJobs::Company.all.size)
  end 


  def valid_job?(input)
    input.between?(1, DigitalNomadJobs::Job.all.size)
  end 


  def select_job
    puts ""
    puts "Enter The Number of a Job Post For a Detailed Description"
    jp = gets.strip.to_i
  
    if valid_job?(jp)
      job = DigitalNomadJobs::Job.all[jp - 1]
      job.print_job_description
      navigation 
    else 
      error 
      select_job
    end 
  end 

  def error
    puts 'Whoops! Please Enter A Valid Option.'.magenta 
  end 
  #------------------------------------        CLI JOB FACTORY      --------------------------------------#
  
  def make_dev_jobs
    DigitalNomadJobs::Job.reset
    DigitalNomadJobs::Company.reset
    job_array = DigitalNomadJobs::Scraper.scrape_jobs(PATH + '/remote-dev-jobs')
    DigitalNomadJobs::Job.create_from_collection(job_array)
    puts ""
    puts '                      🖥️                        '
    puts "------------------------------------------------".blue 
    puts "           NABBING WEB DEVELOPER JOBS           ".white.on_blue 
    add_descriptions_to_jobs
    list_menu
  end


  def make_design_jobs
    DigitalNomadJobs::Job.reset
    DigitalNomadJobs::Company.reset
    job_array = DigitalNomadJobs::Scraper.scrape_jobs(PATH + '/remote-design-jobs')
    DigitalNomadJobs::Job.create_from_collection(job_array)
    puts ""
    puts "                     🎨 " 
    puts "------------------------------------------------".blue 
    puts "           LOADING WEB DESIGN JOBS              ".white.on_blue 
    add_descriptions_to_jobs
    list_menu
  end


  def make_all_the_jobs
    DigitalNomadJobs::Job.reset
    DigitalNomadJobs::Company.reset
    job_array = DigitalNomadJobs::Scraper.scrape_jobs(PATH)
    DigitalNomadJobs::Job.create_from_collection(job_array)
    puts ""
    puts "                      🌎 " 
    puts "------------------------------------------------".blue 
    puts "         NABBING THE NEWEST REMOTE JOBS         ".white.on_blue 
    add_descriptions_to_jobs
    list_menu 
  end


  def add_descriptions_to_jobs
    DigitalNomadJobs::Job.all.each do |job|
    description_hash = DigitalNomadJobs::Scraper.scrape_descriptions(PATH + job.job_url)
    job.add_job_description(description_hash)
    end 
  end 

#--------------------------------   CLI DISPLAY METHODS -----------------------------#
  
  def display_companies
    DigitalNomadJobs::Company.list_companies
    select_company 
  end 


  def display_jobs
    DigitalNomadJobs::Job.list_all_jobs
    select_job 
  end

  
end
