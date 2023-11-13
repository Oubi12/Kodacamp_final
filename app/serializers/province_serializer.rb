class ProvinceSerializer < ActiveModel::Serializer
  attributes :id, :region, :name

  def region
    object.region.region_name
  end
end