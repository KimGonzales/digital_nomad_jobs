
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "digital_nomad_jobs/version"

Gem::Specification.new do |spec|
  spec.name          = "digital_nomad_jobs"
  spec.version       = DigitalNomadJobs::VERSION
  spec.authors       = ["Kim Gonzales"]
  spec.email         = ["Kimgo589@gmail.com"]

  spec.summary       = "Remote Jobs for The Digital Nomad"
  spec.description   = "This CLI Ruby Gem provides users the most up-to-date web dev and design jobs from 'Remoteok.io'"
  spec.homepage      = "https://github.com/KimGonzales/digital_nomad_jobs"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   << 'digital_nomad_jobs'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri", ">= 0"
  spec.add_development_dependency "pry", ">= 0"
  spec.add_development_dependency "colorize", ">= 0"
end
