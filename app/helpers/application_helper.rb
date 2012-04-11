module ApplicationHelper
  def class_for_light_or_dark_text_on_bar percent
    if percent < 10
      'dark' 
    else
      'light'
    end
  end

  def simple_time_format time
    time.strftime('%l:%M %P')
  end

  def duration_in_words duration
    minutes = (duration / 60).floor
    seconds = duration  - (minutes * 60)
    hours = (minutes / 60).floor
    minutes = minutes - (hours * 60)

    str = []
    str << "#{hours}h" unless hours == 0
    str << "#{minutes}m" unless minutes == 0
    str << "#{seconds.floor}s"
    str.join ' '
  end
end
