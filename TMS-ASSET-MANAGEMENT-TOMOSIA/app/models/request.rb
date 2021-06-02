class Request < ApplicationRecord
  extend Enumerize
  WEBHOOK_URL = 'https://hooks.slack.com/services/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'
  
  belongs_to :user
  has_one :deliver
  belongs_to :product, class_name: 'Item', foreign_key: :item_id

  enumerize :status, :in => {
    pending: 0,
    approve: 1,
    reject: 2
  }, predicates: true

  enumerize :type_request, :in => {
    Borrow: 0,
    Restore: 1,
    Break: 2
  }

  validates :reason,:start_date, :end_date, presence: true

  validate :start_date_is_equal_today
  validate :end_date_is_after_start_date

  def self.search(term)
    if term.present?
      where(status: term)
    else
      all
    end
  end

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?
  
    if  start_date > end_date 
      errors.add(:end_date, "cannot be before the start date") 
    end 
  end

  def start_date_is_equal_today
    return if start_date.blank?
    to_date =  Time.zone.now
    if start_date < to_date
      errors.add(:start_date, " must not be less than current date") 
    end 
  end

  scope :status_pending, -> {where status: 'pending'}
  scope :status_approve, -> {where status: 'approve'}
  scope :status_reject, -> {where status: 'reject'}

end
