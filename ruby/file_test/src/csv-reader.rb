#!/usr/local/bin/ruby


class Reader
    
      def self.make(file_name)
				fdir,base=File.split(file_name)
				@fdir=fdir
				puts @fdir
				data = File.new(file_name)
        header = data.gets.chomp
        data.close
        class_name = File.basename(file_name,".txt").capitalize  
        # "foo.txt" => "Foo"
        klass = Object.const_set(class_name,Class.new)
        names = header.split(",")
			

				#the next 5 lines (set and get dir) are beginners ruby.  
				# There is a scope problem that I haven't figured out yet with fdir
				
				def klass.setFdir(fdir)
						@fdir=fdir
				end
				def klass.getFdir
						@fdir
				end
				klass.setFdir(fdir);
    
        klass.class_eval do
          attr_accessor *names
    
          define_method(:initialize) do |*values| 
            names.each_with_index do |name,i| 
              instance_variable_set("@"+name, values[i])
            end
          end
    
          define_method(:to_s) do
            str = "<#{self.class}:"
            names.each {|name| str << " #{name}=#{self.send(name)}" }
            str + ">"
          end
          alias_method :inspect, :to_s
        end
    
        def klass.read
          array = []
					dir=self.getFdir
					filename=dir+"/"+self.to_s.downcase+".txt"
          data = File.new(filename)
          data.gets  # throw away header
          data.each do |line| 
            line.chomp!   
            values = eval("[#{line}]")
            array << self.new(*values)
          end
          data.close
          array
        end
    
        klass
      end
    
    end


