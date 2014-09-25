# Takes each invoice file and prints the filename and linecount.
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

# Takes the folder location and, for each invoice file within,
# and parses the filename and linecount, assigning them variables.
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

invoice_folder = InvoiceFolder.new(ARGV.first)
invoice_folder.process_invoices
invoice_folder.invoices.each do |invoice|
  puts "Invoice file: #{invoice[:filename]}"
  puts "Linecount: #{invoice[:linecount]}"
  puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
end
