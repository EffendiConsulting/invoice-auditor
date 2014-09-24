# InvoiceData takes a given folder and cycles through its invoices, returning
#
# class InvoiceData
#   def initialize
#     @invoice_info = {}
#     @csv_filename = ''
#     @invoice_folder = ''
#   end
#
#   def parse_invoice_data
#     @invoice_info = { file_name: @csv_filename,
#                       line_count: File.open(@csv_filename, 'r').readlines.length
#                     }
#   end
#
#   def pull_invoice_data
#     Dir[@invoice_folder].each do |csv_filename|
#       parse_invoice_data(@csv_filename)
#     end
#   end
# end

class Invoice

  attr_reader :csv_filename, :linecount

  def initialize(csv_filename)
    @csv_filename = csv_filename
    @linecount = 0
  end

  def parse
    puts @csv_filename
    @linecount = File.open(@csv_filename, 'r').readlines.length
  end
end

class InvoiceFolder
  attr_reader :invoices
  def initialize(folder)
    @folder = folder
    @invoices = []
  end

  def process_invoices
    Dir[@folder].each do |csv_filename|
      invoice = Invoice.new(csv_filename)
      invoice.parse
      invoices << {
        filename: invoice.csv_filename,
        linecount: invoice.linecount
      }
    end
  end
end

# def invoice_array_output
#   invoices_array = []
#   invoices_array.each do |invoices|
#     pull_invoice_data(ARGV.first)
#     # invoices_array.push { invoice_info }
#     invoices_array << invoice_info
#   end
#   puts invoices_array
# end

invoice_folder = InvoiceFolder.new(ARGV.first)
invoice_folder.process_invoices
invoice_folder.invoices.each do |invoice|
  puts "Invoice file: #{invoice[:filename]}"
  puts "Linecount: #{invoice[:linecount]}"
  puts "*********************"
end
