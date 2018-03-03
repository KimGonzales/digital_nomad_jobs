class DigitalNomadJobs::Job

    attr_accessor :title, :company, :description, :job_url, :skills, :time_posted
    @@all = [ ]

    def initialize(hash)
        hash.each {|key, value| self.send(("#{key}="), value)}
        self << @@all 
    end 

    def self.reset
        @@all.clear
    end 

end