class DigitalNomadJobs::Job

    attr_accessor :title, :company, :description, :job_url, :skills, :time_posted, :company_url
    @@all = [ ]

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
        @@all << self 
    end 

    def self.reset
        @@all.clear
    end 

    def self.create_from_collection(array)
        array.each do | hash |
            job = new(hash)
        end 
    end 

    def self.all
        @@all 
    end 

end