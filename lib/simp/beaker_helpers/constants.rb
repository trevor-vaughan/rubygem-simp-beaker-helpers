module Simp; end

module Simp::BeakerHelpers
  # This is the *oldest* version that the latest release of SIMP supports
  #
  # This is done so that we know if some new thing that we're using breaks the
  # oldest system that we support
  DEFAULT_PUPPET_AGENT_VERSION = '1.10.4'

  if ['true','yes'].include?(ENV['BEAKER_online'])
    ONLINE = true
  elsif ['false','no'].include?(ENV['BEAKER_online'])
    ONLINE = false
  else
    require 'open-uri'

    begin
      ONLINE = true if open('http://google.com')
    rescue
      ONLINE = false
    end
  end

end
