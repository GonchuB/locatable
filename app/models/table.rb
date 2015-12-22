class Table < ActiveRecord::Base
  has_many :reservation_table_audits

  def status
    self.reservation_table_audits.last.to
  end

  def change_status(new_status)
    last_audit = self.reservation_table_audits.last
    return if last_audit.to == new_status

    self.reservation_table_audits.create(reservation: last_audit.reservation, from: last_audit.to, to: new_status)
  end
end
