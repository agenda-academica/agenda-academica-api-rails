class Evento < ActiveRecord::Base
  validates :user, presence: true

  belongs_to :disciplina
  has_one :user, through: :universidade
  has_one :universidade, through: :unidade
  has_one :unidade, through: :curso
  has_one :curso, through: :turma
  has_one :turma, through: :disciplina

  delegate :user, to: :universidade
  delegate :universidade, to: :unidade
  delegate :unidade, to: :curso
  delegate :curso, to: :turma
  delegate :turma, to: :disciplina

  def as_json(*)
    super(:include => {
      :user => {},
      :universidade => {},
      :unidade => {},
      :curso => {},
      :turma => {},
      :disciplina => {},
    })
  end
end
