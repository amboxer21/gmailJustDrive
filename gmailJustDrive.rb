#!/usr/bin/ruby

require 'gmail'
require 'date'

@entries = Array.new
@final   = Array.new
@array   = Array.new

def sort(arr1,arr2)
  arr1.each_index do |f|
    next if arr2[f+1].nil?
    @final.push(arr1[f-1]) if !arr1[f-1].match(/#{arr2[f]}/i)
  end
  return @final
end
 
Gmail.new('username', 'pasword') do |gmail|
  gmail.inbox.emails.each do |item|
    if item.subject =~ /\d+/
      @entries.push("#{item.subject},#{item.date}")
      @array.push(item.subject)
    end
  end

  sort(@entries.sort,@array.sort)

  @count = @final.count.to_i

  gmail.inbox.emails.each do |t| 
    (0..@count).each do |i|
      next if @final[i].nil?
      if @final[i].split(/\d{10},/)[1].match(t.date)
        puts "#{t.subject} - #{t.date} - #{t.body}"
      end
    end
  end

end
