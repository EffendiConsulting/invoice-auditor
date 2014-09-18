# def linecount(fname)
#   File.open(fname, 'r') do |f|
#     return f.readlines.length
#   end
# end

# Dir['/Users/Jason/Desktop/refund_retriever/2014-09-13/*.csv'].each do |fname|
#   puts "#{fname} #{File.open(fname, 'r').readlines.length}"
# end

def parse_invoice(csv_filename)
  invoice_info = { file_name: csv_filename,
                   line_count: File.open(csv_filename, 'r').readlines.length }
  invoice_info
end

Dir[ARGV.first].each do |csv_filename|
  puts csv_filename
  invoice = parse_invoice(csv_filename)
  puts invoice
end
