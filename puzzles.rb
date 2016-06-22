#Alec Webb
#Ruby Exercises

$min  = Proc.new{|x,y| if x<=y then x else y end}
$max  = lambda{|x,y| if x>=y then x else y end}
$addy = lambda{|x,y| return x+y}

$grid  = [[1,2,3, 4,5,6, 7,8,9],
        [4,5,6, 7,8,9, 1,2,3],
        [7,8,9, 1,2,3, 4,5,6],

        [2,3,4, 5,6,7, 8,9,1],
        [5,6,7, 8,9,1, 2,3,4],
        [8,9,1, 2,3,4, 5,6,7],

        [3,4,5, 6,7,8, 9,1,2],
        [6,7,8, 9,1,2, 3,4,5],
        [9,1,2, 3,4,5, 6,7,8],
       ]

$grid_rows_bad = [
       [1,2,3, 1,2,3, 1,2,3],
       [4,5,6, 4,5,6, 4,5,6],
       [7,8,9, 7,8,9, 7,8,9],

       [2,3,4, 2,3,4, 2,3,4],
       [5,6,7, 5,6,7, 5,6,7],
       [8,9,1, 8,9,1, 8,9,1],

       [3,4,5, 3,4,5, 3,4,5],
       [6,7,8, 6,7,8, 6,7,8],
       [9,1,2, 9,1,2, 9,1,2],
       ]

$grid_cols_bad = [
       [1,2,3, 4,5,6, 7,8,9],
       [4,5,6, 7,8,9, 1,2,3],
       [7,8,9, 1,2,3, 4,5,6],

       [1,2,3, 4,5,6, 7,8,9],
       [4,5,6, 7,8,9, 1,2,3],
       [7,8,9, 1,2,3, 4,5,6],

       [1,2,3, 4,5,6, 7,8,9],
       [4,5,6, 7,8,9, 1,2,3],
       [7,8,9, 1,2,3, 4,5,6],
       ]

$grid_grps_bad = [
       [1,2,3, 4,5,6, 7,8,9],
       [2,3,4, 5,6,7, 8,9,1],
       [3,4,5, 6,7,8, 9,1,2],
       [4,5,6, 7,8,9, 1,2,3],
       [5,6,7, 8,9,1, 2,3,4],
       [6,7,8, 9,1,2, 3,4,5],
       [7,8,9, 1,2,3, 4,5,6],
       [8,9,1, 2,3,4, 5,6,7],
       [9,1,2, 3,4,5, 6,7,8],
       ]

class Report
#constructor, getters and setters
  def initialize(mean,median,mode)
    @mean = mean
    @median = median
    @mode = mode
  end

  def setmean(mean)
    @mean = mean
  end

  def setmedian(median)
    @median = median
  end

  def setmode(mode)
    @mode = mode
  end

  def mean
    return @mean
  end

  def median
    return @median
  end

  def mode
    return @mode
  end

  def str
    summary = "(" + @mean.to_s + ", " + @median.to_s + ", " + @mode.to_s + ")"
    return summary
  end
end


def is_prime(n)
#prime numbers are greater than 1, and not divisible by anything but themselves
#cycle through 2 to n-1 to try all possibilities.
  if n>1 then
    for i in 2..(n-1)
      if n%i == 0 then
        return false
      end
    end
    return true
  else
    return false
  end
end

def fib(n, results={})
#base conditions
  if n == 0 || n == 1 then
    return n
  end

#recursion through the results set
  if !results.include?(n) then
    results[n] = fib(n-1, results) + fib(n-2, results)
  end

  return results[n]
end

def reversed(xs)
#make a copy of the list
#swap the items to reverse
  i = 0
  j = (xs.length) -1
  xscopy = xs.dup

  while i<j do
    last = xscopy[j]
    first = xscopy[i]
    xscopy[i] = last
    xscopy[j] = first
    i += 1
    j -= 1
  end
  return xscopy
end

def nub(xs)
#create an empty list, traverse the given list
#place items from xs that dont exist yet in nub, into nub
  nub = []
  for item in xs
    if !nub.include?(item) then
      nub.push(item)
    end
  end
  return nub
end

def zipwith(f, xs, ys)
#determine which list is smaller then apply zip to avoid nil values
#then use collect to call the function on the pairs
  if xs.length < ys.length then
    return xs.zip(ys).collect{|x,y| f.call(x,y)}
  else
    return ys.zip(xs).collect{|x,y| f.call(x,y)}
  end
end

def collatz(n)
  colist = []
  while n!= 1 do
    colist.push(n)
    #is even
    if n%2 == 0 then
      n = n/2
    #is odd
    else
      n = 3*n+1
    end
  end
  #all roads lead to 1
  colist.push(1)
  return colist
end

def mean(xs)
#find the sum and divide by the length to find the average
  l = xs.length
  sum = xs.inject(0, :+)
  return sum/l.to_f
end

def median(xs)
#sort the list, find the middle position
#check if the list is even or odd
#if odd take the middle number, if even average the two middle numbers
  numbers = xs.sort
  middle = (numbers.length)/2
  if numbers.length % 2 == 0 then
    median = (numbers[middle] + numbers[middle-1])/2.to_f
  else
    median = numbers[middle]
  end
  return median
end

def mode(xs)
  #create a hash for the counts of each item
  cnt = Hash.new(0)
  xs.each do |i|
    cnt[i] += 1
  end
  #create a list for the modes, place the items with the max count in it
  mode = []
  cnt.each do |i,j|
    if j == cnt.values.max
      mode.push(i)
    end
  end
  return mode.sort
end

def file_report(filename)
  #create list for numbers and read from file
  numbers = []
  f = File.open(filename, "r")
  f.each_line do |line|
    numbers.push(line.chop)
  end
  #convert list to integers
  numbers.map!{|x| x.to_i }

  #create object and use setters
  rep = Report.new(0,0,0)
  rep.setmean(mean(numbers))
  rep.setmedian(median(numbers))
  rep.setmode(mode(numbers))
  return rep
end

def check_sudoku(grid)
#to check the rows, pull the rows and check each ones mode, if not equal to nine
#there are not 9 different elements 1..9
  for row in grid 
    if mode(row).length != 9 then
      return false
    end
  end

#do the same but traverse the columns instead
  for i in (0..8)
    check = []
    for j in (0..8)
      check.push(grid[j][i])
    end
    if mode(check).length != 9 then
      return false
    end
  end

#to check 3x3 grids, offset allows traversal through the component grids
  for i in (0..2)
    for j in (0..2)
      check = []
      roffset = i*3
      coffset = j*3
      for x in (0..2)
        for y in (0..2)
          check.push(grid[x + roffset][y + coffset])
        end
      end
      if mode(check).length != 9 then
        return false
      end
    end
  end
#if the above do not fail, valid grid
  return true
end
