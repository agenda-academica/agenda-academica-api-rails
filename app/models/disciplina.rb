class Disciplina < ActiveRecord::Base
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

  def as_json(*)
    super(:include => {
      :user => {},
      :universidade => {},
      :unidade => {},
      :curso => {},
      :turma => {}
    })
  end
end
