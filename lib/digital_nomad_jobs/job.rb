class DigitalNomadJobs::Job

    attr_accessor :title, :company, :description, :job_url, :skills, :time_posted
    @@all = [ ]

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
        @@all << self 
    end 

    def self.reset
        @@all.clear
    end 

end