


# get a list of all css files
# process all, and write output to a named file

files = Dir.glob("**/*css")


def extract_tokens_from_file(file)
  d = File.open(file).read
  d.gsub!("\n",'')
  d.gsub!(/\{[^}]*\}/,'')
  d.gsub!(/[,.#]/, ' ')
  tokens = d.split(" ").sort.uniq
end

def parse_for_css_occurances(file)
tokens = extract_tokens_from_file(file)
tokens.each do |token|
  next if token.match(/\*/) || token.match(/:/)  # want to add next here if selector matches any kind of html element
  count = %x(grep -r "[ \\"]#{token}[ \\"]" ../../app).size
  #  token_map << {:token => token, :count => count}
  puts format("| %s\t\t\t| %d\t\t\t|", token, count)
end
end


files.each do |file| parse_for_css_occurances(file) end
