module DisciplinaPushNotificationJob
  @queue = :disciplina_push_notification

  def self.perform(args)
    require 'exponent-server-sdk'
    @disciplina = Disciplina.find args['disciplina_id']
    @token = Token.where(user: @disciplina.user).first

    Exponent::Push::Client.new.publish(
      exponentPushToken: @token.value,
      message: "Aula hoje às"\
        +" #{sprintf '%02d', @disciplina.hora_inicio.hour}"\
        +"h#{sprintf '%02d', @disciplina.hora_inicio.min}: "\
        +"#{@disciplina.universidade.abreviacao}"\
        +", #{@disciplina.unidade.nome}"\
        +", #{@disciplina.curso.abreviacao}",
      data: {},
    )
    Resque.enqueue_at(
      DisciplinaPushNotificationJob.date_to_perform(@disciplina, include_today: false),
      DisciplinaPushNotificationJob,
      args,
    )
  end

  def self.date_to_perform(disciplina, include_today: true)
    time_to_perform = disciplina.hora_inicio \
      - (disciplina.notify_at.hour).hours \
      - (disciplina.notify_at.min).minutes \
      - (disciplina.notify_at.sec).seconds

    DisciplinaPushNotificationJob.date_of_next(
      DisciplinaPushNotificationJob.weekday_name(disciplina.dia_semana),
      include_today
    ).to_time.change({
      hour: time_to_perform.hour,
      min: time_to_perform.min,
      sec: time_to_perform.sec,
    })
  end

  def self.date_of_next(day, include_today)
    date  = Date.parse(day)
    condition = include_today ? date >= Date.today : date > Date.today
    delta = condition ? 0 : 7
    date + delta
  end

  def self.weekday_name(index)
    {
      0 => 'Sunday',
      1 => 'Monday',
      2 => 'Tuesday',
      3 => 'Wednesday',
      4 => 'Thursday',
      5 => 'Friday',
      6 => 'Saturday',
    }[index]
  end
end
