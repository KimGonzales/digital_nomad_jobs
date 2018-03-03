

class DigitalNomadJobs::Scraper



    # The keys to the hash are the jobs attributes :title,
    # :company, :skills, :time_posted and :job_url. 
    # :titles = doc.css(".company_and_position_mobile h2") [iterate and grab .text]
    # :companies = doc.css(".company_and_position_mobile .preventLink h3") [iterate and grab .text]
    # :times_posted = doc.css(".time") [.text]
    # :job_url = doc.css(".company_and_position_mobile a").attribute("href").value
    def self.scrape_jobs(url)
        html = open(url)
        doc = Nokogiri::HTML(html)

        job_hash = {}

        doc.css(".company_and_position_mobile").each do |pos|
            job_hash [:title] = pos.css("h2").text
            job_hash [:company] = pos.css(".preventLink h3").text 
        end 
        
        doc.css(".time").each do |t|
            job_hash[:time_posted] = t.text
        end     
        puts job_hash         
    end  
    
    
end

#urls?!!? = doc.css(".company_and_position_mobile").first.css("a")[0]['href']
# doc.css(".company_and_position_mobile").css("a")[0]['href']