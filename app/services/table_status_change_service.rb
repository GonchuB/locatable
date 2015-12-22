class TableStatusChangeService < TableBaseService
  def call(new_status)
    last_audit = audits.last
    return if last_audit.to == new_status

    audits.create(reservation: last_audit.reservation, from: last_audit.to, to: new_status)
    table.update_attributes(status: new_status)
  end
end
