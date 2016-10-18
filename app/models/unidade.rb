class Unidade < ActiveRecord::Base
  validates :user, :universidade, presence: true

  belongs_to :universidade
  has_one :user, through: :universidade
  has_many :curso, :dependent => :destroy
  has_many :turma, through: :curso, :dependent => :destroy
  has_many :disciplina, through: :turma, :dependent => :destroy

  delegate :user, to: :universidade

  def as_json(*)
    super(:include => {
      :user => {},
      :universidade => {},
      :curso => { :include => {
        :turma => { :include => :disciplina }
      } }
    })
  end
end
