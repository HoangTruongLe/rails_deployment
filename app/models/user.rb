# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\z}

  has_many :request_offs, dependent: :destroy
  belongs_to :department
  extend Enumerize

  enumerize :gender, in: %i[Male Female], default: :Male
  enumerize :position, in: %i[manager comtor hr account qc submanager developer accountant]
  scope :deleted_at_as_0, -> { where(deleted_at: 0) }
  scope :get_all_admin, -> { where(role: 'admin') }
  TRAMSLATE_VN = {
      'Male': 'Nam',
      'Female': 'Nữ',
      'manager': 'Quản lý',
      'comtor': 'Phiên Dịch',
      'hr': 'Nhân Sự',
      'account': 'Kế Toán',
      'qc': 'Kiểm thử phần mềm',
      'submanager': 'Quản lý',
      'developer': 'kỹ sư phần mềm',
      'accountant': 'Kế Toán'
  }
  validates :first_name, :last_name, :remaining_days_off, :chatwork_id, presence: true
  def full_name
    last_name.to_s + ' ' + first_name.to_s
  end

  def admin?
    role == 'admin' ? true : false
  end

  def active_for_authentication?
    super && deleted_at.zero?
  end

  def self.search(params)
    if params[:search].present?
      conditions = []
      if params[:email].present?
        conditions << ['email ILIKE ? OR lower_unaccent(first_name) ILIKE lower_unaccent(?) OR lower_unaccent(last_name) ILIKE lower_unaccent(?)',
                       "%#{params[:email]}%", "%#{params[:email]}%", "%#{params[:email]}%"]
      end
      if params[:position].present?
        conditions << ['position = ?', params[:position]]
      end
      if params[:department_id].present?
        conditions << ['department_id = ?', params[:department_id]]
      end
      if params[:join_date].present?
        conditions << ['join_date = ?', params[:join_date]]
      end
      if conditions.present?
        query = [conditions.map(&:first).join(' AND '), *conditions.flat_map { |c| c[1..-1] }]
        where(query)
      else
        self
      end
    else
      self
    end
  end
end
