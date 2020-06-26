require 'nokogiri'
require 'httparty'
require 'byebug'

def scrapper
  url = "https://www.motorcyclevalley.com/info/bike-price/"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)

  tables = parsed_page.css('.table')
  header_of_the_tables = parsed_page.css('h2')

  first_row = tables.first.css("tr[1] > th")
  table_header_row = []
  first_row.each_with_index {|first, index|
    if index == 3
      table_header_row << "View Details"
    else
      table_header_row << first.text
    end
  }

  arrayOfTabels = []
  tables.each_with_index {|table, index|
    arrayOfRows = []
    rows = table.css("tr")
    rows.each_with_index {|row, index|
      next if index == 0
      arrayOfColumns = []
      columns = row.css("td")
      columns.each_with_index {|column, index|
        if index == 3
          column = column.css("a").attribute("href").value()
        else
          column = column.text
          column = column.gsub(/\s+/, " ").strip
        end
        arrayOfColumns << column
      }
      arrayOfRows << arrayOfColumns
    }
    hashOfTable = {
      header: header_of_the_tables[index].text,
      tableHeader: table_header_row,
      allRows: arrayOfRows
    }
    arrayOfTabels << hashOfTable
  }
  puts arrayOfTabels
  #byebug
end

scrapper




