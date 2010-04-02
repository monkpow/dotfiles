require 'irb/completion'
ARGV.concat [ "--readline", "noprompt" ]

module Readline
  module History
    LOG = "#{ENV['HOME']}/.irb-history"

    def self.write_log(line)
      File.open(LOG, 'ab') {|f| f << "#{line}\n"}
    end

    def self.start_session_log
      write_log("\n# session start: #{Time.now}\n\n")
      at_exit { write_log("\n# session stop: #{Time.now}\n") }
    end
  end

  alias :old_readline :readline
  def readline(*args)
    ln = old_readline(*args)
    begin
      History.write_log(ln)
    rescue
    end
    ln
  end
end

Readline::History.start_session_log

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"


IRB.conf[:PROMPT_MODE] = :XMP
class Object
  def request(options = {})
    method = options.delete(:method) || :get
    options.reverse_merge!(:only_path => true)
    ENV['REQUEST_URI'] = app.url_for(options)
    ENV['REQUEST_METHOD'] = method.to_s
    Dispatcher.dispatch
  end
end

def sel_init(env)
# for selenium testing at viewpoints
  load "spec/views/fixtures/#{env}.rb"
  load 'spec/views/lib/spec_helper.rb'
  setup
  end
