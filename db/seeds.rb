# Sample ideas so the app isn't empty on first run: bin/rails db:seed
[
  { title: "Plant subscription box", category: "E-commerce", status: "researching", potential: 4, starred: true,
    description: "Monthly curated houseplants delivered with care guides and a QR code for plant-specific tips.",
    target_market: "Urban renters aged 22–40", revenue_model: "Subscription ($29/mo)" },
  { title: "Invoice reminder SaaS", category: "SaaS", status: "validating", potential: 3,
    description: "Automatically sends polite, escalating payment reminders for freelancers' overdue invoices.",
    target_market: "Freelancers and small agencies", revenue_model: "Tiered monthly plan" },
  { title: "Local tool library app", category: "Marketplace", status: "brainstorming", potential: 2,
    description: "Neighbours lend and borrow tools instead of buying them.",
    target_market: "Suburban homeowners", revenue_model: "Small rental fee per transaction" }
].each do |attrs|
  Idea.find_or_create_by!(title: attrs[:title]) { |idea| idea.assign_attributes(attrs) }
end
