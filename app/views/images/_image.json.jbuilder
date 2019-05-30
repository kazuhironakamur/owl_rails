json.extract! image, :id, :code, :filename, :imagefile, :created_at, :updated_at
json.url image_url(image, format: :json)
