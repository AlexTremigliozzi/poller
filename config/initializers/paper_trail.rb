PaperTrail.config.track_associations = true


PaperTrail::Rails::Engine.eager_load!

PaperTrail.whodunnit =  if Rails.const_defined?('Console')
                          "#{`whoami`.strip}: console"
                        else
                          "#{`whoami`.strip}: #{File.basename($PROGRAM_NAME)} #{ARGV.join ' '}"
                        end
