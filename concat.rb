lines = File.readlines("results_yn_q").join(' ')
words = {}
out = lines.scan(/[a-zA-z']+/) do |w| 
	#print w,'_'
	ww = w.downcase
	n = words[ww].nil? ? 0 : words[ww]
	words[ww] = n+1
end

puts
sorted_words = words.sort_by { |k,v| -v }
sorted_words.each { |k,v| puts "#{k}: #{v}" }

