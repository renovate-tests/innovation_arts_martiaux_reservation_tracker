json.extract! tarif, :id, :class_per_week, :price, :created_at, :updated_at
json.url tarif_url(tarif, format: :json)
