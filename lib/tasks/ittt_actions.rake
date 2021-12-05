namespace :ittt_actions do

  desc 'Check all ITTT due and evaluate them'
  task check: :environment do
    ittts_due = Ittt.where(%(
      (ittts.last_evaluated_at IS NULL OR EXTRACT(EPOCH FROM (now() - ittts.last_evaluated_at)) > (ittts.interval * 60))
    ))

    ittts_due.each do |ittt|
      ittt.update last_evaluated_at: Time.zone.now
      if ittt.evaluate_conditions
        ittt.ittt_actions.each do |action|
          begin
            MqttClient.publish(action.topic, action.message, false, 1)
          rescue NameError
            Rails.logger.debug 'MqttClient not defined'
          end
        end
      end
    end
  end
end
