class Universidade < ActiveRecord::Base
  validates :user, presence: true

  belongs_to :user
  has_many :unidade, :dependent => :destroy
  has_many :curso, through: :unidade, :dependent => :destroy
  has_many :turma, through: :curso, :dependent => :destroy
  has_many :disciplina, through: :turma, :dependent => :destroy

  def as_json(*)
    super(:include => {
      :user => {},
      :unidade => { :include => {
        :curso => { :include => {
          :turma => { :include => :disciplina }
        } }
      } }
    })
  end
end
