class MyOrder < ActiveRecord::Base

  def is_valid_sla
    sla = Sla.first
    d1 = self.send(sla.sla1)
    d2 = self.send(sla.sla2)
    if (d2.day - d1.day > sla.diffnum)
      false
    else
      true
    end
  end

end
