module Crops
  class UpdateCrop < Mutations::Command
    attr_reader :pictures

    include Crops::CropsConcern

    required do
      string :id
      model :user
      hash :crop do
        optional do
          string :name
          array :common_names
          string :binomial_name
          string :description
          string :sun_requirements
          string :sowing_method
          integer :spread
          integer :days_to_maturity
          integer :row_spacing
          integer :height
        end
      end
    end

    optional do
      array :images, class: String, arrayize: true
    end

    def validate
      validate_permissions
      validate_images
    end

    def execute
      @existing_crop = Crop.find(id)
      set_pictures
      @existing_crop.update(crop)
      @existing_crop
    end

    private

    def validate_permissions
      # TODO: This should call on the Pundit policy
      true
    end
  end
end
