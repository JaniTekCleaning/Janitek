class Staff < User
  has_many :clients, dependent: :nullify
  has_many :buildings, dependent: :nullify
end
