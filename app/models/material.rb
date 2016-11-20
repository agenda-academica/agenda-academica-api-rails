class Material < ActiveRecord::Base
  validates :user, :universidade, :unidade, :curso, :turma, presence: true

  belongs_to :turma
  has_one :user, through: :universidade
  has_one :universidade, through: :unidade
  has_one :unidade, through: :curso
  has_one :curso, through: :turma

  delegate :user, to: :universidade
  delegate :universidade, to: :unidade
  delegate :unidade, to: :curso
  delegate :curso, to: :turma

  after_create :send_share_email_to_representantes

  def as_json(*)
    super(:include => {
      :user => {},
      :universidade => {},
      :unidade => {},
      :curso => {},
      :turma => {}
    })
  end

  def send_share_email_to_representantes
    self.turma.representantes.each_with_index do |representante, index|
      MaterialMailer.share_email_to_representante(self.id, index).deliver_later
    end
  end
end
