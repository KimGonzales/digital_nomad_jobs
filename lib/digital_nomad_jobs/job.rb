class DigitalNomadJobs::Job

  attr_accessor :title, :company, :description, :job_url, :skills, :time_posted
  @@all = [ ]

  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value) unless key == :company_url}
    @@all << self  
    company = DigitalNomadJobs::Company.find_or_create_by_name(self.company)
    company.add_job(self)
    company.company_url = attributes[:company_url]
  end 

  def self.create_from_collection(array)
    array.each do | hash |
      job = new(hash)
    end 
  end 

  def add_job_description(hash)
    hash.each {|key, value| self.send(("#{key}="), value)}
  end 

  def self.all
    @@all 
  end 

  def self.reset
    @@all.clear
  end 

  def self.list_all_jobs
    all.each.with_index(1) do | job, i |
      puts "-----------------------------------------------------------------------------------------------"
      puts "#{i}. #{job.title} - #{job.company} - Posted:#{job.time_posted} Ago"
      puts "-----------------------------------------------------------------------------------------------"
      puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    end 
  end 

  def print_job_description
    puts "=========================================================================================="
    puts ""
    puts "Position: #{self.title}"
    puts "Company : #{self.company}"
    puts "Posted  : #{self.time_posted} ago"
    puts "Tags    : #{self.skills}"
    puts ""
    puts "Description : #{self.description}"
    puts ""
    puts "Learn More or Apply at: #{'https://remoteok.io' + self.job_url}"
    puts "=========================================================================================="
  end 

end