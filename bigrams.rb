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

puts
sorted_words = bigrams.sort_by { |k,v| -v[:count] }
sorted_words.each { |k,v| puts "#{k}: #{v}" }

