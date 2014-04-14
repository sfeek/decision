#!/usr/bin/ruby 

def rank(scale,which_better,values)
    output=Array.new
    largest = values.max
    smallest = values.min
    m=0

    case scale
        when "1"
            m=0.2
        when "2"
            m=0.5
        when "3"
            m=1.0
        when "4"
            m=2.0
        when "5"
            m=5.0 
    end

    return nil if largest == 0 
    values.each_with_index do |value,index|
        output[index] = value / largest * m if which_better == "l"
        output[index] = smallest / value * m if which_better == "s"
    end
    return output
end

icount=0
ccount=0

items = Array.new
categories = Array.new
importance = Array.new
items_value = Array.new
better = Array.new
numbers = ["1","2","3","4","5"]
ls = ["l","s","L","S"]

while true
    print "Enter Item #{icount+1}: "
    i=$stdin.gets.strip
    if (i == "") 
        break;
    end
    items[icount] = i
    items_value[icount] = 0.0
    icount = icount + 1
end

puts

while true
    print "Enter Category #{ccount+1}: "
    i=$stdin.gets.strip
    if (i == "") 
        break;
    end
    categories[ccount] = i

    i="0"
    until (numbers.include?(i))
        print "Enter Importance (1-5)"
        i=$stdin.gets.strip
        puts 
    end 
    if (i.strip == "") 
        break;
    end
    importance[ccount] = i

    ans=""
    until (ls.include?(ans))
        print "Is <L>arger better, or <S>maller Better?"
        ans = $stdin.gets.strip.downcase
        better[ccount]=ans
        puts
    end
    ccount = ccount + 1
    puts
end

categories.each_with_index do |category,cindex|
    values=Array.new
    puts
    puts "For the Category #{category}, enter the Value for:"
    items.each_with_index do |item,iindex|
        print "#{item}:"
        values[iindex] = $stdin.gets.strip.to_f
    end
    output=rank(importance[cindex],better[cindex],values)
    items.each_with_index do |item,iindex|
        items_value[iindex]=items_value[iindex] + output[iindex]
    end
end

puts
puts "Results:"

items_value.each_with_index do |itemv,index|
    puts "#{items[index]} - Score: #{itemv.round(1)}"
end

 
    


