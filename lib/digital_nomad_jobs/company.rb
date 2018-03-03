class DigitalNomadJobs::Company

    attr_accessor :name
    attr_reader :jobs

    def initialize(name)
        @name = name 
        @jobs = []
    end 

    def add_job(job)
        @jobs << job 
        job.company = self
    end 


    def print_jobs
        jobs.each_with_index(1) {|job, i| puts "#{i}. #{job.title}"}
    end 
end 