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

[ ]Call CLI 
[ ]CLI will greet user and print out main menu which consists of WEB DEV or WEB DESIGN or ALL
[ ]Get user input
[ ]Scrape job postings from website and instantiate a new job object for every posting AND 
[ ]Instatiate a new company for each job posting as well UNLESS it has already been created.
[ ]Establish relationship between each Job and Company. A Job BELONGS TO a company. A Company     has many jobs.     

Class Outlines:

************  CLI  ************* 
attributes
    PATH to websites

methods
#call
#main_menu
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


***********  JOB  **************
attributes
    :title, :company, :description, :url

methods
#self.create_from_collection(array)
    creates jobs and assigns each job instance its attributes based on the array passed in

#self.add_description(hash)
    adds the description of a job


**********  COMPANY  **********
attributes
    :name, :jobs, url 


**********  SCRAPER ************
methods:
#.scrape_jobs
    class method that should take in an argument of list of jobs URL (index, web dev OR
    web design) and returns an array of hashes. Each hash represents
    one job posting. The keys to the hash are the jobs attributes :title,
    :company and :url. 

#.scrape_job_descriptions
    this class method takes an argument of a singular job posting's url
    and scrapes the :description and :company_url and returns a hash.
