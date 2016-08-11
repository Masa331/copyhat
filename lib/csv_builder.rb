require 'csv'

class CsvBuilder
  attr_accessor :data_entries

  def initialize(data_entries)
    @data_entries = data_entries
  end

  def self.call(data_entries)
    new(data_entries).call
  end

  def call
    CSV.generate do |csv|
      csv << ['h1', 'h2']
      csv << ['bla', 'bla222']
    end
  end
end
