namespace :dump_records do
  desc 'Migrate data to new db structure'
  task dump: :environment do

    MODEL_CLASSES = [Client, Service, ClientPrice, Invoice, InvoiceItem, Payment]

    def run
      MODEL_CLASSES.each { |klass| export_class_to_csv(klass)}
    end

    def export_class_to_csv(klass)
      CSV.open("#{klass.to_s}_export.csv", 'w') do |csv|
        csv << klass.column_names
        klass.all.each do |record|
          csv << record.attributes.values_at(*klass.column_names)
        end
      end
    end

    run
  end
end
