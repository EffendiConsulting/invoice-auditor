# def linecount(fname)
#   File.open(fname, 'r') do |f|
#     return f.readlines.length
#   end
# end

# Dir['/Users/Jason/Desktop/refund_retriever/2014-09-13/*.csv'].each do |fname|
#   puts "#{fname} #{File.open(fname, 'r').readlines.length}"
# end

path = '../invoice-auditor/' # relative path from current file to
#                              required folder

Dir["File.dirname(__FILE__) + '/' + path + '*.csv'"].each do |fname|
  require_relative path + File.basename(fname) # require all files with .csv
  #                                              extension in this folder
  puts "#{fname} #{File.open(fname, 'r').readlines.length}"
end

# def invoice_info
#
