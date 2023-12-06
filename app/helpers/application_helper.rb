module ApplicationHelper
  def full_address(address)
    return 'Not set' if address.nil?

    "#{address.street_address}, #{address.barangay&.name}, #{address.city&.name}, #{address.province&.name}"
  end
end