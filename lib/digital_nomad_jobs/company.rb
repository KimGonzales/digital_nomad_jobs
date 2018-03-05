class DigitalNomadJobs::Company
 
  @@all = []
  attr_accessor :name, :company_url 
  attr_reader :jobs

  def initialize(name)
    @name = name 
    @jobs = []
    @@all << self 
  end 

  def self.find_by_name(name)
    @@all.find {|company| company.name == name}
  end 

  def self.create_by_name(name)
    company = self.new(name)
  end 

  def self.find_or_create_by_name(name)
    find_by_name(name) || create_by_name(name)
  end

  def self.all
    @@all
  end 

  def self.reset
    @@all.clear
  end 

  def add_job(job)
    @jobs << job 
    job.company = self.name 
  end 

  def self.list_companies 
    puts ""
    puts "============ COMPANIES NOW HIRING! =============".blue 
    puts "================================================".blue 
    puts ""
    all.each.with_index(1) do |company, i| 
      puts "#{i}. #{company.name}"
    end 
    puts "================================================".blue 
  end 

  def print_company_jobs
    puts ""
    puts "#{self.name.upcase} IS LOOKING TO FILL THESE POSITIONS!".white.on_blue 
    puts "-----------------------------------------------------------------------------------------------".blue 
    jobs.each.with_index(1) do |job, i| 
      puts "#{i}. #{job.title} - Posted:#{job.time_posted} Ago"
      puts ""
      puts "About: ".blue + "#{job.description}"
      puts ""
      puts "TO APPLY OR SEE MORE FROM #{self.name.upcase} VISIT: ".blue + "#{'https://remoteok.io' + self.company_url}"
      puts "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -".blue 
    end
    puts "-----------------------------------------------------------------------------------------------".blue 
  end 
end 