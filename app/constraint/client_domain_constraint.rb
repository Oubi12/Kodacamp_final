class ClientDomainConstraint
  def matches?(request)
    domains = ['client.com']
    domains.include?(request.domain.downcase)
  end
end