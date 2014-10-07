# Takes each invoice file and prints the filename and total linecount.
class InvoiceFile
  attr_reader :csv_filename, :extracted_invoice_number, :total_linecount

  def initialize(csv_filename)
    @csv_filename = csv_filename
    @extracted_invoice_number = csv_filename.split('.').first
    @total_linecount = 0
  end

  def parse
    @total_linecount = File.open(@csv_filename, 'r').readlines.length
  end
end

# Takes the folder location and, for each invoice file within,
# and parses the filename and total linecount, assigning them variables.
class InvoiceFolder
  attr_reader :invoices

  def initialize(folder)
    @folder = folder
    @invoices = []
  end

  def process_invoices
    Dir[@folder].each do |csv_filename|
      invoice = InvoiceFile.new(csv_filename)
      invoice.parse
      invoices << {
        filename: invoice.csv_filename,
        extracted_invoice_number: invoice.extracted_invoice_number,
        total_linecount: invoice.total_linecount
      }
    end
  end
end

# Compares total linecount with imported_as_packages and invoice_raw_imported
# for each invoice, and expresses them as a percentage of total linecount.
class InvoiceCounts
  def initialize
    require 'csv'

    @rows = CSV.read('./ups-140913.csv', headers: true, header_converters:
      :symbol).map.&:to_hash # { |row| row.to_hash }
    # @invoice_number = invoice_number
    @imported_as_packages = imported_as_packages
    @invoice_raw_imported = invoice_raw_imported
  end

  def pull_counts(extracted_invoice_number)
    @rows.select { |row| row[:invoice_number] == extracted_invoice_number }
    @row << {
      invoice_number: rows.invoice_number,
      imported_as_packages: rows.imported_as_packages,
      invoice_raw_imported: rows.invoice_raw_imported
    }
  end

  def linecount_comparison(total_linecount)
    attr_reader :pkgs_vs_linecount, :raw_lines_vs_linecount

    @row.inspect
    pkgs_vs_linecount = (@imported_as_packages / total_linecount)
    raw_lines_vs_linecount = (@invoice_raw_imported / total_linecount)
  end
end

invoice_folder = InvoiceFolder.new(ARGV.first)
invoice_folder.process_invoices
invoice_folder.invoices.each do |invoice|  # explain
  invoice_counts.pull_counts(extracted_invoice_number)
  invoice_counts.linecount_comparison(total_linecount)
  puts "Invoice number: #{invoice[:invoice_number]}"
  puts "Total linecount: #{invoice[:total_linecount]}"
  puts "Pkgs vs linecount: #{sprintf '%.2f%%', 100 * pkgs_vs_linecount}"
  puts "Raw linecount vs linecount: #{sprintf '%.2f%%', 100 *
    raw_lines_vs_linecount}"
  puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
end
