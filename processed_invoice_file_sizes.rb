# def linecount(fname)
#   File.open(fname, 'r') do |f|
#     return f.readlines.length
#   end
# end

Dir['/Users/Jason/Desktop/refund_retriever/2014-09-13/*.csv'].each do |fname|
  puts "#{fname} #{File.open(fname, 'r').readlines.length}"
end
