class DigitalNomadJobs::Company

    @@all = []
    attr_accessor :name
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
        job.company = self
    end 


    def print_jobs
        jobs.each_with_index(1) {|job, i| puts "#{i}. #{job.title}"}
    end 
end 