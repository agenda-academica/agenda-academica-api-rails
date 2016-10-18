class Curso < ActiveRecord::Base
  validates :user, :universidade, :unidade, presence: true

  belongs_to :unidade
  has_one :user, through: :universidade
  has_one :universidade, through: :unidade
  has_many :turma, :dependent => :destroy
  has_many :disciplina, through: :turma, :dependent => :destroy

  delegate :user, to: :universidade
  delegate :universidade, to: :unidade

  def as_json(*)
    super(:include => {
      :user => {},
      :universidade => {},
      :unidade => {},
      :turma => { :include => :disciplina }
    })
  end
end
