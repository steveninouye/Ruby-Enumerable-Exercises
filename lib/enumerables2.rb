require 'byebug'

# EASY

# Define a method that returns the sum of all the elements in its argument (an
# array of numbers).
def array_sum(arr)
    arr.reduce(0, :+)
end

# Define a method that returns a boolean indicating whether substring is a
# substring of each string in the long_strings array.
# Hint: you may want a sub_tring? helper method
def in_all_strings?(long_strings, substring)
    long_strings.all? { |el| el.include? substring}
end

# Define a method that accepts a string of lower case words (no punctuation) and
# returns an array of letters that occur more than once, sorted alphabetically.
def non_unique_letters(string)
    letters = string.chars.select { |el| el != " "} 
    multi_ltrs = letters.reduce([]) do |acc, ltr|
        if (!acc.include?(ltr) && letters.count(ltr) > 1 )
            acc << ltr
        end
        acc.sort
    end
end

# Define a method that returns an array of the longest two words (in order) in
# the method's argument. Ignore punctuation!
def longest_two_words(string)
    string.split.reduce([]) do |acc, curr|
        if acc.length < 2
            acc.push(curr)
        elsif (acc.any? {|el| el.length < curr.length})
            acc[1] = curr
        end
        acc.sort{|a,b| b.length <=> a.length}
    end
end

# MEDIUM

# Define a method that takes a string of lower-case letters and returns an array
# of all the letters that do not occur in the method's argument.
def missing_letters(string)
    ("a".."z").select {|el| !string.include? el}
end

# Define a method that accepts two years and returns an array of the years
# within that range (inclusive) that have no repeated digits. Hint: helper
# method?
def no_repeat_years(first_yr, last_yr)
    (first_yr..last_yr).select{|yr| not_repeat_year?(yr)}
end

def not_repeat_year?(year)
    yr_str = year.to_s
    yr_str.each_char do |digit|
        return false if yr_str.count(digit) > 1
    end
    true
end

# HARD

# Define a method that, given an array of songs at the top of the charts,
# returns the songs that only stayed on the chart for a week at a time. Each
# element corresponds to a song at the top of the charts for one particular
# week. Songs CAN reappear on the chart, but if they don't appear in consecutive
# weeks, they're "one-week wonders." Suggested strategy: find the songs that
# appear multiple times in a row and remove them. You may wish to write a helper
# method no_repeats?
def one_week_wonders(songs)
   songs.each_with_index do |song, idx|
     songs.reject! {|el| el == song} if songs[idx + 1] == song
   end
   songs.uniq
end

# Define a method that, given a string of words, returns the word that has the
# letter "c" closest to the end of it. If there's a tie, return the earlier
# word. Ignore punctuation. If there's no "c", return an empty string. You may
# wish to write the helper methods c_distance and remove_punctuation.

def for_cs_sake(string)
    get_words(string).reduce(nil) do |acc, curr|
        if curr.include? "c"
            if (!acc || acc.reverse.index("c") > curr.reverse.index("c"))
                acc = curr
            end
        end
        acc
    end
end

# method that takes and string and gets only words with letters
# "acc!?!?...,, lock" => ["acc", "lock"]
def get_words(words)
    words.delete! "^[a-z ]"
    words.split
end

# Define a method that, given an array of numbers, returns a nested array of
# two-element arrays that each contain the start and end indices of whenever a
# number appears multiple times in a row. repeated_number_ranges([1, 1, 2]) =>
# [[0, 1]] repeated_number_ranges([1, 2, 3, 3, 4, 4, 4]) => [[2, 3], [4, 6]]

def repeated_number_ranges(arr)
    result = []
    start_idx = 0
    while start_idx < arr.length
        next_idx = start_idx + 1
        result.push([start_idx,next_idx]) if arr[start_idx] == arr[next_idx]
        while arr[start_idx] == arr[next_idx]
            result[-1][1] = next_idx
            start_idx = next_idx
            next_idx += 1
        end
        start_idx += 1
    end
    result
end
