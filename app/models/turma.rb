class Turma < ActiveRecord::Base
  validates :user, :universidade, :unidade, :curso, presence: true

  belongs_to :curso
  has_one :user, through: :universidade
  has_one :universidade, through: :unidade
  has_one :unidade, through: :curso
  has_many :disciplina, :dependent => :destroy

  delegate :user, to: :universidade
  delegate :universidade, to: :unidade
  delegate :unidade, to: :curso

  def as_json(*)
    super(:include => {
      :user => {},
      :universidade => {},
      :unidade => {},
      :curso => {},
      :disciplina => {}
    })
  end
end
