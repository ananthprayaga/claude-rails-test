class Idea < ApplicationRecord
  STATUSES = {
    "brainstorming" => "Brainstorming",
    "researching"   => "Researching",
    "validating"    => "Validating",
    "building"      => "Building",
    "launched"      => "Launched",
    "shelved"       => "Shelved"
  }.freeze

  SORTS = {
    "newest"    => { created_at: :desc },
    "oldest"    => { created_at: :asc },
    "potential" => { potential: :desc, created_at: :desc },
    "title"     => { title: :asc },
    "updated"   => { updated_at: :desc }
  }.freeze

  validates :title, presence: true, length: { maximum: 150 }
  validates :status, inclusion: { in: STATUSES.keys }
  validates :potential, numericality: { only_integer: true, in: 1..5 }

  normalizes :category, with: ->(value) { value.strip.presence }

  scope :starred, -> { where(starred: true) }
  scope :with_status, ->(status) { where(status: status) if status.present? }
  scope :in_category, ->(category) { where(category: category) if category.present? }
  scope :search, ->(query) {
    next all if query.blank?

    term = "%#{sanitize_sql_like(query.strip.downcase)}%"
    where(
      "LOWER(title) LIKE :term OR LOWER(description) LIKE :term OR LOWER(target_market) LIKE :term OR LOWER(notes) LIKE :term",
      term: term
    )
  }
  scope :sorted_by, ->(key) { order(SORTS.fetch(key.to_s, SORTS["newest"])) }

  def self.categories
    where.not(category: nil).distinct.order(:category).pluck(:category)
  end

  def status_label
    STATUSES.fetch(status, status.to_s.humanize)
  end
end
