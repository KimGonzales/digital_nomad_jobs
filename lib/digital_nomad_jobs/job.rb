class DigitalNomadJobs::Job

  attr_accessor :title, :company, :description, :job_url, :skills, :time_posted, :company_url
  @@all = [ ]

  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
    @@all << self 
    company = DigitalNomadJobs::Company.find_or_create_by_name(self.company)
    company.add_job(self)
    binding.pry
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

  def print_description
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