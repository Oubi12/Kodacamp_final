module ApplicationHelper
  def full_address(address)
    "#{address.street_address}, #{address.barangay.name}, #{address.city.name}, #{address.province.name}"
  end
end
