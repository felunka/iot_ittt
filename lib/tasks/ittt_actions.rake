namespace :ittt_actions do

  desc 'Check all ITTT due and evaluate them'
  task check: :environment do
    ittts_due = Ittt.where(%(
      (ittts.last_evaluated_at IS NULL OR EXTRACT(EPOCH FROM (now() - ittts.last_evaluated_at)) > (ittts.interval * 60))
    ))

    ittts_due.each do |ittt|
      ittt.execute
    end
  end
end
