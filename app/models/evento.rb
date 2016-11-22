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

  after_create :schedule_push_notification
  after_destroy :destroy_scheduled_push_notification

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

  def schedule_push_notification
    binding.pry
    Resque.enqueue_at(
      EventoPushNotificationJob.date_to_perform(self),
      EventoPushNotificationJob,
      user_id: self.user.id,
      evento_id: self.id,
    )
  end

  def destroy_scheduled_push_notification
    Resque.remove_delayed_selection { |args| args[0]['evento_id'] == self.id }
  end
end
