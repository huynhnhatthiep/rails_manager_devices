require "csv"
class ExportCsvService
  
  def initialize objects, attributes
    @attributes = attributes
    @objects = objects
    @header = attributes.map { |attr| I18n.t("header_csv.#{attr}") }
  end

  def perform
    CSV.generate do |csv|
      csv << header
      objects.each do |object|
        object.detail = attr_detail object
        csv << attributes.map{ |attr| object.public_send(attr) }
      end
    end
  end

  def attr_detail object
    detail = []
      object.detail.map do |key, value|
        detail << "#{key}: #{value}"
      end
    detail.join(' ')
  end

  private
  attr_reader :attributes, :objects, :header
end
