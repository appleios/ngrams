lines = File.readlines("results_yn_q").join(' ')
bigrams = {}
prev_word = ""
lines.scan(/[a-zA-z']+/) do |w|
  ww = w.downcase
  if prev_word.length > 0
    b = "#{prev_word}-#{ww}"
    n = 0
    s = {}
    if not bigrams[b].nil?
      s = bigrams[b]
      n = s[:count]
    else
      s = {:first => prev_word, :second => ww, :count => 0}
    end
    s[:count] = n+1

    bigrams[b] = s
  end
  prev_word = ww
end

#puts
#sorted_words = bigrams.sort_by { |k,v| -v[:count] }
#sorted_words.each { |k,v| puts "#{k}: #{v}" }

#puts "Sorted 2-grams:"
sorted_by_second = bigrams.sort_by { |k,v| v[:second] }
#sorted_by_second.each { |k,v| puts "#{k}: #{v}" }

skip_bigrams = {}
prev_bigram = nil
sorted_by_second.each do |k,v|
  if not prev_bigram.nil?
    t1 = prev_bigram[:value][:second]
    t2 = v[:first]
    if t1 == t2
      a = prev_bigram[:value][:first]
      b = v[:second]
      sb = "#{a}-#{b}"
      count_a = prev_bigram[:value][:count]
      count_b = v[:count]
      skip_bigrams[sb] = {:first => a,
                          :second => b,
                          :count_a => count_a,
                          :count_b => count_b,
                          :count_avg => (count_a+count_b)/2
      }
    end
  end
  prev_bigram = {:key => k, :value => v}
end

puts "Sorted skip-2-grams (by avg count):"
sorted = skip_bigrams.sort_by { |k,v| v[:count_avg] }
sorted.each { |k,v| puts "#{k}: #{v}" }
