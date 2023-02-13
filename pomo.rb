
@countdown = 25 * 60

Dir.mkdir("logs", 0777) if !Dir.exist?('logs')


def date(time)
  year = time.year.to_s
  month = time.month.to_s.size == 2 ? time.month.to_s : '0' + time.month.to_s
  day = time.day.to_s.size == 2 ? time.day.to_s : '0' + time.day.to_s
  "#{year}-#{month}-#{day}"
end

def time(time)
  hour = time.hour.to_s.size == 2 ? time.hour.to_s : '0' + time.hour.to_s
  min = time.min.to_s.size == 2 ? time.min.to_s : '0' + time.min.to_s
  "#{hour}:#{min}"
end

def modulo
  modulo = @countdown % 60
  '%02d' % modulo
end

def division
  division = @countdown / 60
  '%02d' % division
end

def pomo
  puts "#{@task.capitalize} pomo is started at time: #{time(@start_time)}"
  
  while @countdown > 0
    print "\r#{division}:#{modulo} "
    @countdown -= 1
    sleep 1
  end

  if @countdown == 0
    puts '=' * 10
    @end_time = Time.now
    puts "#{@task.capitalize} pomo completed at time: #{time(@end_time)}"
    puts '=' * 10
  end
end

def log
  pomo_log = File.open("#{'./logs/' +"#{date(@start_time)}" + '.txt'}", "a+")
  pomo_log.puts ":task, #{@task}"
  pomo_log.puts ":start_time, #{time(@start_time)}"
  pomo_log.puts ":end_time, #{time(@end_time)}"
  puts "You can see the log in #{pomo_log.path}"
  pomo_log.close
end

print 'Write a task: '
puts
@task = gets.downcase.strip
@start_time = Time.now

pomo
log
