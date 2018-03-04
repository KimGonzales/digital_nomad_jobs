class DigitalNomadJobs::Scraper

  def self.scrape_jobs(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    posts = doc.css(".company_and_position_mobile")

    job_array = posts.first(5).collect do |post|
      {:title => post.css('h2').text, 
      :company => post.css('.preventLink h3').text,
      :job_url => post.css('a')[0]['href'],
      :company_url => post.css('a')[1]['href'],}
    end
  end  

  def self.scrape_descriptions(job_url)
    html = open(job_url)
    page = Nokogiri::HTML(html)

    details = {}
    details[:description] = page.css('.description').text
    details[:time_posted] = page.css('.time').text
    details[:skills] = page.css('.tags').text.gsub('3>', ' | ').insert(0,' | ')
    
    details
  end 


end
 