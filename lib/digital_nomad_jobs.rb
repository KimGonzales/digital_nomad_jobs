require_relative "./digital_nomad_jobs/version"
require_relative "./digital_nomad_jobs/cli"
require_relative "./digital_nomad_jobs/company"
require_relative "./digital_nomad_jobs/job"
require_relative "./digital_nomad_jobs/scraper"
require_relative "./digital_nomad_jobs/concerns/validate_module"

require "nokogiri"
require "open-uri"
require "pry"


#this file sets up the gem's environment