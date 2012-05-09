class FnordMetric::TimelineWidget < FnordMetric::Widget
  
  @@series_colors = ["#FACE4F", "#42436B", "#CD645A", "#2F635E"]
  
  def react(ev)
    ev["ticks"] = ev["ticks"].map(&:to_i) if ev["ticks"]
    ev["tick"] = ev["tick"].to_i if ev["tick"]

    {
      :tick => ev["tick"],
      :cmd => "values_at",
      :values => Hash[@opts[:series].map{ |skey|
        vals =  call_handler(:values_at, skey, ev["ticks"], ev["tick"]) 
        ev["ticks"].each{ |_tick| vals[_tick.to_i] ||= 0 }
        [skey, vals]
      }]
    }
  end  

  def opts
    super.tap do |o|
      o[:series_titles] ||= Hash[o[:series].map{|s| [s, s]}]
    end
  end

end