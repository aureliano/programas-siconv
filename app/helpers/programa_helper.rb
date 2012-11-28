ProgramasSiconv.helpers do

  def time_to_date_s(time)
    return '' if time.nil?
    time.strftime '%d/%m/%Y'
  end
end
