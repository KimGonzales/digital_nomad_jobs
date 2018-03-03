How To Build CLI GEM

1. Plan your gem, imagine the interface.
2. Project Structure
3. Start with Entry Point (The file run)
4. Force that to build the CLI interface 
5. Stub out interface
6. Start making things real 
7. Discover Objects
8. Program 


Flow

[X]Call CLI 
[X]CLI will greet user and print out main menu which consists of WEB DEV or WEB DESIGN or ALL
[X]Get user input
[ ]Scrape job postings from website and instantiate a new job object for every posting AND 
[ ]Instatiate a new company for each job posting as well UNLESS it has already been created.
[X]Establish relationship between each Job and Company. A Job BELONGS TO a company. A Company can have many jobs.     

Class Outlines:

************  CLI  ************* 
attributes
    PATH to websites

methods
#call
#main_menu
#make_jobs_based_on_input
    #make_web_developer_jobs
        calls Scraper.scrape_jobs(URL) where url is web-dev page
        creates new jobs with create_from_collection
    #make_web_design_jobs
        calls Scraper.scrape_jobs(URL) where url is web-design page
        creates new jobs with create_from_collection
    #make_all_jobs 
        calls Scraper.scrape_jobs(URL) where url is index page
        creates new jobs with create_from_collection
        
#display_jobs

#display_job_description


***********  JOB  **************
attributes
    :title, :company, :description, :url, :skills, :time_posted

methods
#self.create_from_collection(array)
    creates jobs and assigns each job instance its attributes based on the array passed in

#self.add_description(hash)
    adds the description of a job

#company_name
    self.company.name (returns the name of a given job's company)

#company_name=(company)
    if self.company.nil?
        self.company = Company.new(company)


**********  COMPANY  **********
attributes
    :name, :jobs, url 
    @@all

methods
#initialize(name)
    @jobs = []
    
#add_job(job)
    @jobs << job
    job.company = self

#add_job_by_title(title)
    job = Job.new(title)
    @jobs << job
    job.company = self

#self.find_or_create_by_name(name)
    self.all.detect{|name| name = self.name} || self.new(name)

#print_jobs
    jobs.each{|job| puts job.title}
#jobs
    returns an array of all the companies jobs


**********  SCRAPER ************
methods:
#.scrape_jobs
    class method that should take in an argument of list of jobs URL (index, web dev OR
    web design) and returns an array of hashes. Each hash represents
    one job posting. The keys to the hash are the jobs attributes :title,
    :company, :skills, :time_posted and :job_url. 

#.scrape_job_descriptions
    this class method takes an argument of a singular job posting's url
    and scrapes the :description and :company_url and returns a hash.
    It iterates over all existing Job.urls and scrapes each job description


@@@@@@@ OBJECT RELATIONSHIPS!
    A job belongs to a company while a company can have many jobs. 
    Scraper class grabs Job and Company attributes
    CLI 
