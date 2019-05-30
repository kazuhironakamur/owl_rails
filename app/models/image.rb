class Image < ApplicationRecord
    validates :filename, uniqueness: true

    def to_param
        filename
    end

end
