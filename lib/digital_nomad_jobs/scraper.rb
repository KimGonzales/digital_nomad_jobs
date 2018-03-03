

class DigitalNomadJobs::Scraper

    def self.scrape_jobs(url)
        html = open(url)
        doc = Nokogiri::HTML(html)
        posts = doc.css(".company_and_position_mobile")

        job_array = posts.collect do |post|
            {:title => post.css('h2').text, 
            :company => post.css('.preventLink h3').text,
            :job_url => post.css('a')[0]['href'],
            :company_url => post.css('a')[1]['href']}
        end
        puts job_array 
    end  
    
end
 