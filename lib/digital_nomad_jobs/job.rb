class DigitalNomadJobs::Job

    attr_accessor :title, :company, :description, :job_url, :skills, :time_posted

    def initialize(hash)
        hash.each {|key, value| self.send(("#{key}="), value)}
    end 

end