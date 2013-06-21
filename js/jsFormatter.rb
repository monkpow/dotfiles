for file in `find app -name "*.js"`; do
  ruby -pi -e "gsub(/function\(/, 'function (')" $file;
  #ruby -pi -e "gsub(/if\(/, 'if (')" $file;
  ruby -pi -e "gsub(/\( /, '(')" $file;
  ruby -pi -e "gsub(/\s\)/, ')')" $file;
  ruby -pi -e "gsub(/\t/, '  ')" $file;
  #ruby -pi -e "gsub(/\S{/, ' {')" $file;
done;
