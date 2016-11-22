module EventoPushNotificationJob
  @queue = :evento_push_notification

  def self.perform(args)
    require 'exponent-server-sdk'
    @evento = Evento.find args['evento_id']
    @token = Token.where(user: @evento.user).first

    message = sprintf "%s hoje às"\
      +" #{sprintf '%02d', @evento.hora_inicio.hour}"\
      +"h#{sprintf '%02d', @evento.hora_inicio.min}: ",\
      @evento.tipo
    description = "#{@evento.universidade.abreviacao}"\
              + ", #{@evento.unidade.nome}"\
              + ", #{@evento.curso.abreviacao}"
    description = @evento.titulo if @evento.tipo == 'Outros'

    Exponent::Push::Client.new.publish(
      exponentPushToken: @token.value,
      message: message + description,
      data: {},
    )
  end

  def self.date_to_perform(evento)
    time_to_perform = evento.hora_inicio \
      - (evento.notify_at.hour).hours \
      - (evento.notify_at.min).minutes \
      - (evento.notify_at.sec).seconds

    evento.data_inicio.to_time.change({
      hour: time_to_perform.hour,
      min: time_to_perform.min,
      sec: time_to_perform.sec,
    })
  end
end
