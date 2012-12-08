# :title:rSort Documentation
#
# Author:: Dave Dembinski (mailto:dave@davedembinski.com)
# Copyright:: Copyright (c) 2003 Dave Dembinski
# License:: Distributes under the same terms as Ruby
#
# Sort is a mix-in module that provides methods implementing various common
# sort algorithms.  Including Sort in a class gives that class the ability to call 
# destructive and non-destructive versions of sorts ranging from the simple 
# bubbleSort to the sophisticated heapSort.  
#
# ==General Method Notes:
# All sort methods support at least 3 optional, boolean parameters:
# time:: records the total elapsed sort time
# verbose:: records compares and swaps
# visual:: gives a rudimentary visualisation of sort progress.  Typically, shows entire list with elements about to be swapped delimited by parentheses.  Obviously, this becomes less useful when list size is larger than screen width.
# In addition, all sorts come in destructive and non-destructive flavors.  Destructive 
# sorts are indicated by appending an exclamation point (!) to the method name.  
# Non-destructive sorts are obtained by excluding this exclamation point.
# 
# Currently, all sorts return one of three results:
# * If neither time nor verbose are true, sorted list will be returned as passed.
#  Example: [1, 2, 3, 4, 5]
# * If time is true, elapsed time in seconds will be returned as the second entry in an array consisting of the sorted list and the elapsed time.  
#  Example:  [[1, 2, 3, 4, 5], 0.000342]
# * If verbose is true, compares and swaps will be returned as the second and third entries (respectively) in an array consisting of the sorted list, compares, and swaps.
#  Example: [[1, 2, 3, 4, 5], 4, 4]
# * If both verbose and time are true, there will be two nested arrays returned.  Verbose alwasy returns before time, so the first sub array will be the sorted list, compares, and swaps.  The second sub-array, will contain the first sub-array and the elapsed time in seconds.
#  Example: [[[1, 2, 3, 5, 4], 1, 8], 0.000199]

module Sort

	# ===isSorted
	# Checks a list to see if it is sorted.  
	# 
	# Additional Optional Arguments:
	# * None
    def isSorted()
    
    	# Walk through the list just once.  If the current element is ever greater
    	# than its successor, the list is not sorted.  
        (self.length - 1).times do |i|
            if self[i] > self[i.succ]
                return false
            end
        end
        return true
    end


 
    def bSort(target, verbose,visual)
        swaps = 1	#bubble sort ends when there are no swaps, so to get it
        					# started the first time we pretend we've made one.
        compares = 0 if verbose  #bookkeeping
        vswaps = 0 if verbose		#ditto
        
        while swaps > 0
            swaps = 0	# here we're being optimistic.  If this stays at zero, the
            					# list must be sorted.  Otherwise, the sort will run again.
            					
            for i in 0...target.length - 1
                p "*" * target[i] if visual  #simple visualisation.  list[element] value 
                											  # number of asterisks.
                compares += 1 if verbose
                if target.at(i) > target.at(i.succ)		#this is where the sort itself starts.
                																# If the current element is greater than
                																# its successor. . . 
                    target[i],target[i.succ] = target[i.succ],target[i]	#swap 'em.  
                    swaps += 1	#we made a swap, so we can't be sure it's sorted yet
                    vswaps += 1 if verbose
                end
            end
        end
        return [target, vswaps, compares] if verbose
        return target
    end
    
    private :bSort
    
    # ===bubbleSort
	# Logic for the bubble sort algorithm. 
	# 1. For each entry in the list:
	# 2. If the entry is greater than the one next to it swap them
	# 3. Otherwise, move on to the next entry
	# 4. If swaps occured, repeat at step 1.  Otherwise, list is sorted.
	#
	# ====Available Optional Parameters: 
	# * None
    def bubbleSort(time=false,verbose=false,visual=false)

        startTime = Time.now() if time
        result = bSort(self.dup, verbose,visual)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
    # ===bubbleSort!
    # Destructive version of the bubbleSort algorithm.  Modifies list in-place.
    def bubbleSort!(time=false,verbose=false,visual=false)
        startTime = Time.now() if time
        result = bSort(self,verbose,visual)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
    def biBSort(target,verbose,visual)
        swaps = 1
        compares = 0 if verbose
        vswaps = 0 if verbose
        while swaps > 0
            swaps = 0
            system("clear") if visual
            for i in 0...target.length - 1
            	p "*" * target[i] if visual
                compares += 1 if verbose
                if target[i] > target[i.succ]
                    target[i],target[i.succ] = target[i.succ],target[i]
                    swaps += 1
                    vswaps += 1 if verbose
                end
            end
            i = target.length - 1
            while i > 0
            	p "*" * target[i] if visual
                compares += 1 if verbose
                if target[i] < target[i-1]
                    target[i-1],target[i] = target[i],target[i-1]
                    swaps += 1
                    vswaps += 1 if verbose
                    i -= 1
                end
                i -= 1
            end
        end
        return [target, vswaps, compares] if verbose
        return target
    end
    
    private :biBSort
    
    # ===biBubbleSort
    # Bi-directional bubble sort, also called <em>shaker</em> or <em>cocktail</em> sort,
    # is a simple variation of bubble sort that tries to alleviate the problem of "bubbles" by sorting boustrophedonically. In 
    # a standard bubble sort, values that are large tend to sink very rapidly to the end of the list,
    # but small values can only move one position at a time towards the beginning (ie. they "bubble" very slowly towards the top).  
    # By passing through the list in reverse order, one reverses the situation and small values rise
    # very rapidly towards the beginning of the list, whereas large values sink very slowly.  
    #
    # Bi-directional bubble sort includes two passes on the list each time: one forward and
    # one backward.  In this way, both large and small values get the opportunity to sink or rise 
    # quickly and, it is hoped, a significant performance gain can be had.  In practice, it is somewhat
    # faster on-average, but still an order n^2 algorithm.  
    #
    # ====Available Optional Parameters:
    # * None

    def biBubbleSort(time=false,verbose=false,visual=false)
        startTime = Time.now() if time
        result = biBSort(self.dup,verbose,visual)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
    #===biBubbleSort!
    # Destructive version of bi-directional bubble sort.  List is modified in-place.
    def biBubbleSort!(time=false,verbose=false,visual=false)
        startTime = Time.now() if time
        result = biBSort(self,verbose,visual)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
    def cSort(target,verbose,visual,eleven,shrink)
        swaps = 1
        compares = 0 if verbose
        vswaps = 0 if verbose
        gap = (target.length / shrink).to_i
        system("clear") if visual
        while swaps > 0 || gap >= 1
            swaps = 0
            for  i in 0..target.length - 1
            	p "*" * target[i] if visual
                compares += 1 if verbose
                if !(i + gap > target.length - 1)
                    if target[i] > target[i + gap]
                        target[i],target[i + gap] = target[i + gap],target[i]
                        swaps += 1
                        vswaps += 1 if verbose
                    end
                end
            end
            gap = (gap / shrink).to_i
                if eleven
                    if gap == 9 || gap == 10
                        gap = 11
                    end
                end
        end
        return [target, vswaps, compares] if verbose
        return target
    end
    
    private :cSort
    
    # ===combSort
    # Comb sort, first published by Richard Box and Stephen Lacey in the April 1991 issue of Byte magazine,
    # is a variation of bubble sort.  Whereas bi-directional bubble sort gives very modest performance gains, 
    # however, comb sort is an order n log n algorithm!  
    #
    # Comb sort focuses on the same problem as bi-directional bubble sort does, that of elminating bubbles.  
    # Instead of simply passing through the list backwards, though, comb sort examines the idea that there is
    # always a gap between two items being compared, and attempts to manipulate this gap.  By starting with a
    # very large gap, the algorithm gets a chance to bring any small items near the end of the list back to the beginning 
    # very quickly.  The gap is decreased each time through the list, so where it might start at 7 in a list of 10 elements, 
    # (meaning that the first pass would compare elements 0 and 7, 1, and 8, 2, and 9, and 3, and 10), it will eventually 
    # shrink to 1, at which point we're performing a bubble sort.  The trick is that this last bubble sort is in position for a 
    # close-to-best-case run.
    #
    # Obviously, the efficiency of comb sort is very much dependent on the "shrink" factor chosen.  The one suggested by
    # Box and Lacey was 1.3, which is very fast, and good enough for our purposes.  Later papers have suggested a value
    # closer to 1.279 would be more optimal. 
    #
    # A close variant of comb sort, Comb Sort11, operates on the principle that once the gap between elements reaches 9, 10, or
    # 11, the sequence of gap values afterwards is easily predicted and only one of these three values leads to an eventual gap 
    # value of 1, which is 11.  Thus, Comb Sort11 changes the gap size to 11 if it reaches 9 or 10. 
    #
    # ====Available Optional Parameters:
    # eleven (boolean)::  enables Comb Sort11 if true.  Default false.
    # shrink (float):: allows user to change shrink value.  Default 1.3
    
       
    def combSort(time=false,verbose=false,visual=false,eleven=false,shrink=1.3)
        startTime = Time.now() if time
        result = cSort(self.dup,verbose,visual,eleven,shrink)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
    # ===combSort!
    # Destructive version of combSort.  List is modified in-place.
    
    def combSort!(time=false,verbose=false,visual=false,eleven=false,shrink=1.3)
        startTime = Time.now() if time
        result = cSort(self,verbose,visual,eleven,shrink)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
    def sSort(target,verbose,visual)
        compares = 0 if verbose
        swaps = 0 if verbose
        for i in 0...target.length - 1
            min = i
            for j in i...target.length
                compares += 1 if verbose
                if target[j] < target[min]
                    min = j
                end
            end
            p "#{target[0...i]} (#{target[i]}) #{target[i.succ...min]}(#{target[min]})#{target[min.succ...target.length]}" if visual
            target[i],target[min] = target[min],target[i]
            swaps += 1 if verbose
        end
        return [target, swaps, compares] if verbose
        return target
    end
    
    private :sSort
    
    # ===selectionSort
    # Selection sort is one of the most intuitive sort algorithms. 
    # 1. Starting at the beinning of the list:
    # 2. Assume this item is the minimum value of the list. 
    # 3. Step through the rest of the list.  Whenever you find a value lower than the value marked at step 2, mark this new value the lowest.  When we reach the end of the list, swap the current lowest with the value marked at step 2.
    # 4. Repeat from step 1, working the sublist consisting of everything but the value started at in step 1.
    #
    # Notice that the list is not checked to see if it is sorted.  Once all 4 steps are repeated for every
    # element in the list, the list is sorted and need not be checked.  Though selection sort is an intuitive, 
    # simple algorithm, its performance is still order n^2, though the bulk of work is in compares, not swaps.  Still,
    # it is a marked improvement over bubble sort in practical speed, especially if swaps take longer than compares on
    # a machine.  
    #
    # ====Available Optional Parameters:
    # * None
    
    def selectionSort(time=false,verbose=false,visual=false)
        startTime = Time.now() if time
        result = sSort(self.dup,verbose,visual)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
    # ===selectionSort!
    # Destructive version of selectionSort.  Modifies list in-place.
    
    def selectionSort!(time=false,verbose=false,visual=false)
        startTime = Time.now() if time
        result = sSort(self,verbose,visual)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
    def iSort(target,verbose,visual)
        compares = 0 if verbose
        swaps = 0 if verbose
        for i in 1...target.length
            index = target[i]
            j = i
            while (j > 0) && (target[j-1] > index)
                compares += 1 if verbose
                p "#{target[0...j-1]} (#{target[j-1]}, #{target[j]}) #{target[j+1...target.length]}" if visual
                target[j] = target[j - 1]
                swaps += 1 if verbose
                j -= 1
            end
            target[j] = index
            swaps += 1 if verbose
        end
        return [target,swaps,compares] if verbose
        return target
    end
    
    private :iSort
    
    # ===insertionSort
    # Insertion sort can be thought of as a grown-up selection sort.  For every item in the list, 
    # it goes back through the items before it until it finds the proper spot for the current item.  
    # As it moves through previous items, if shifts them forward.  In this way, the algorithm inserts
    # the current item into its proper relative spot in the list of previous items.  Once the end of the 
    # list is reached, it has been sorted, so no need to check there.  
    #
    # Although insertion sort is a significant speed improvement on both bubble sort and selection sort,
    # it'd still be suicide to try and use it on anything larger than a couple hundred elements, unless they 
    # only needed to be sorted once.
    #
    # ====Additional Optional Arguments:
    # * None

    def insertionSort(time=false,verbose=false,visual=false)
        startTime = Time.now() if time
        result = iSort(self.dup,verbose,visual)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
    # ===insertionSort!
    # Destructive version of insertionSort.  Modifies list in-place.
    
    def insertionSort!(time=false,verbose=false,visual=false)
        startTime = Time.now() if time
        result = iSort(self,verbose,visual)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
    
    def shSort(target, verbose, visual, increment)
    	compares = 0 if verbose
    	swaps = 0 if verbose
        while increment > 0
            for i in 0...target.length
                j = i
                temp = target[i]
                while (j >= increment) && (target[j - increment] > temp)
                    compares += 2 if verbose
                	swaps += 1 if verbose
                	 p "#{target[0...j-increment]} (#{target[j-increment]}) #{target[j - increment...j]} (#{target[j]}) #{target[j+1...target.length]}" if visual
                    target[j] = target[j - increment]
                    j = j - increment
                end
                swaps += 1 if verbose
                target[j] = temp
            end
            if increment / 2 != 0
                increment = increment / 2
            else
                if increment == 1
                    increment = 0
                else
                    increment = 1
                end
            end
        end
        return [target, compares, swaps] if verbose
        return target
    end
    
    private :shSort
    
   	# ===shellSort
   	# Shell Sort was developed by Donald Shell in 1959, and is the most efficient of the
   	# order n^2 sorting algorithms.  It operates on a principle similar to the comb sort
    # in that it uses ever-decreasing "gap sizes" to make comparisons.  However, where the
    # comb sort uses these gaps in a bubble sort, shell sort uses them in an insertion sort.  
    #
    # ====Available Optional Parameters
    # increment (int):: sets the value for the initial gap size.  
    
    def shellSort(time=false,verbose=false,visual=false,increment=3)
        startTime = Time.now() if time
        result = shSort(self.dup, verbose, visual, increment)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
   # ===shellSort!
   # Destructive version of shellSort.  Modifies list in-place.
    
    def shellSort!(time=false,verbose=false,visual=false,increment=3)
        startTime = Time.now() if time
        result = shSort(self, verbose, visual, increment)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
    

    def bgSort(target,verbose,visual)
    	compares = 0 if verbose
    	swaps = 0 if verbose
        while !(target.isSorted)
        	compares += target.length if verbose
            p target if visual
            swaps += target.length if verbose
            target.length.times do |i|
                swapPos = rand((target.length) -i ) + i
                target[i],target[swapPos] = target[swapPos],target[i]
            end
        end
        target
    end
    
    private :bgSort
    
    # ===bogoSort
    # From The Jargon Dictionary:
    # bogo-sort  /boh`goh-sort'/n.   (var. `stupid-sort')    The archetypical perversely awful algorithm (as opposed to     bubble sort, which is merely the generic bad    algorithm).  Bogo-sort is equivalent to repeatedly throwing a deck    of cards in the air, picking them up at random, and then testing    whether they are in order.  It serves as a sort of canonical    example of awfulness.  Looking at a program and seeing a dumb    algorithm, one might say "Oh, I see, this program uses    bogo-sort."  Esp.  appropriate for algorithms with factorial or    super-exponential running time in the average case and    probabilistically infinite worst-case running time.  Compare     bogus,  brute force,  lasherism.
    #
    # A spectacular variant of bogo-sort has been proposed which has the    interesting property that, if the Many Worlds interpretation of    quantum mechanics is true, it can sort an arbitrarily large array    in constant time.  (In the Many-Worlds model, the result of any quantum action is to split the universe-before into a sheaf of universes-after, one for each possible way the state vector can collapse; in any one of the universes-after the result appears random.)  The steps are: 1.Permute the array randomly using a quantum process, 2.If the array is not sorted, destroy the universe.     Implementation of step 2 is left as an exercise for the reader.
    # (http://info.astrian.net/jargon/terms/b/bogo-sort.html)
    
    def bogoSort(time=false,verbose=false,visual=false)
        startTime = Time.now() if time
        result = bgSort(self.dup, verbose, visual, increment)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
    # ===bogoSort!
    # Destructive (to more than processor cycles) version of bogoSort.  Modifies list in-place.
    
   	def bogoSort!(time=false,verbose=false,visual=false)
        startTime = Time.now() if time
        result = bgSort(self, verbose, visual, increment)
        endTime = Time.now() if time
        return [result, endTime - startTime] if time
        return result
    end
    
    # ===merge
    # Helper method for mSort.  Takes an array and four positions and merges
    # the high and low of all four positions into the original array in sorted order.
  	# Much simpler using Ruby than other versions I've seen.  
    
    def merge(target, trueLow, high, low, trueHigh)
    	# First, build a temporary array to hold the values we're sorting.  
    	# We put the second half of the array in reverse order to allow us to 
    	# merge more easily.  Since merge sort is recursive divide-and-conquer, 
    	# we know that the two sublists we're getting are already sorted, so if we 
    	# reverse one we'll have the lowest values at both ends of the temp array, 
    	# with higher values as we move in.  
    	temp = target[trueLow..high] + target[low..trueHigh].reverse
    	i = 0
    	j = temp.length - 1
    	k = 0
    	# i and j represent the two values we're comparing, which are at opposite 
    	# ends of the temp array.  Since we reversed one of the sublists, we know that
    	# these are the smallest values in the temp array.  
    	#
    	# Until i and j meet in the middle of the list:
    	while i <= j
    		if temp[i] <= temp[j]
    			# We kept trueLow so we'd know just where to insert this lovely min value
    			# we've found.  We need the k counter to be able to step through the actual 
    			# target array and insert values in the appropriate places.  
    			target[trueLow + k] = temp[i]
    			i += 1
    			k += 1
    		else
    			target[trueLow + k] = temp[j]
    			j -= 1
    			k += 1
    		end
    	end
    end
    
    private :merge
        
    def mSort(target, low, high)
    	if low < high
    		mSort(target, low, ((high + low) / 2).to_i)
    		mSort(target, ((high + low) / 2).to_i + 1, high)
    		merge(target, low, ((high+low)/2).to_i, ((high + low)/2).to_i + 1, high)
    	end
    	target
    end
    
    private :mSort
    
    # ===mergeSort
    # Merge sort is a recursive, divide-and-conquer sort algorithm.  What does this mean?
    # It operates by dividing whatever list it currently has in half, and calling itself on both halves.
    # Once it ends up with a list size of 1, that list is obviously sorted ([3] is a sorted array, even though 
    # it has only one value in it]) so it merges the sorted list with whatever the next sorted list it finds is, and 
    # continues in this manner until it's merging two halves of the original list.  Recursion is fnu!  Run a 
    # stack trace on this if you're not sure exactly what's going on.    
    
    def mergeSort(time=false,verbose=false,visual=false)
    	startTime = Time.now if time
    	result = mSort(self.dup, 0, self.length)
    	endTime = Time.now if time
    	return [result, endTime - startTime] if time
    	return result
    end
    
    # ===mergeSort!
    # Destructive version of mergeSort.  Modifies list in-place.
    
    def mergeSort!(time=false,verbose=false,visual=false)
    	startTime = Time.now if time
    	result = mSort(self, 0, self.length)
    	endTime = Time.now if time
    	return [result, endTime - startTime] if time
    	return result
    end
    
	def qSort(target,left,right,verbose,visual)
		lHold = left
		rHold = right
		pivot = target[left]
		while left < right
			while (target[right] >= pivot) && (left < right)
				right -= 1
			end
			if left != right
				target[left] = target[right]
				left += 1
			end
			while (target[left] <= pivot) && (left < right)
				left += 1
			end
			if left != right
				target[right] = target[left]
				right -= 1
			end
		end
		target[left] = pivot
		pivot = left
		left = lHold
		right = rHold
		if left < pivot
			qSort(target, left, pivot-1,verbose,visual)
		end
		if right > pivot
			qSort(target, pivot+1, right,verbose,visual)
		end
		target
	end
	
	private :qSort
	
	# ===quickSort
	# Quick sort is in the same class as merge sort, being a massively recursive, 
	# divide-and-conquer algorithm.  As such, it is very hard on stack memory, 
	# so care is advised if your stack limit is small.  It is quite fast, though. 
	

	def quickSort(time=false,verbose=false,visual=false,randomize=false)
		startTime = Time.now if time
		target = self.dup
		if randomize
			target.length.times do |i|
                swapPos = rand((target.length) -i ) + i
               	 target[i],target[swapPos] = target[swapPos],target[i]
            end
		end
		result = qSort(target,0,(target.length)-1,verbose,visual)
		endTime = Time.now if time
		return [result,endTime - startTime] if time
		return result
	end
	
	# ===quickSort!
	# Destructive version of quickSort.  Modifies list in-place. 

	def quickSort!(time=false,verbose=false,visual=false,randomize=false)
		startTime = Time.now if time
		target = self
		if randomize
			target.length.times do |i|
                swapPos = rand((target.length) -i ) + i
               	 target[i],target[swapPos] = target[swapPos],target[i]
            end
		end
		result = qSort(target,0,(target.length)-1,verbose,visual)
		endTime = Time.now if time
		return [result,endTime - startTime] if time
		return result
	end
	
	def hSort(target,verbose,visual)
	i = ((target.length) / 2) -1
		while i >= 0
			heap(target,i,target.length)
			i -= 1
		end
	i = (target.length) - 1
		while i >= 1
			temp = target[0]
			target[0] = target[i]
			target[i] = temp
			heap(target,0,i-1)
		i	 -= 1
		end
		target
	end

	private :hSort

	def heap(target,root,bottom)

	done = false
		while (root * 2) <= bottom && !(done)
			if root * 2 == bottom
				maxChild = root * 2;
			else
				if target[root * 2] > target[root * 2 + 1]
					maxChild = root * 2;
				else
					maxChild = root * 2 + 1
				end
			end

			if target[root] < target[maxChild]
				temp = target[root]
				target[root] = target[maxChild]
				target[maxChild] = temp
				root = maxChild
			else
				done = true
			end
		end

	end
	
	private :heap
	
	# ===heapSort
	# Heap sort is an order n log n sort that isn't recursive, meaning that for 
	# machines without a stack and where you don't want to de-curse quickSort,
	# it's either this or comb sort.  This is much faster.  
	# Works by building a heap out of the items to be sorted, taking the root of the 
	# heap and placing it at the end of the list, and rebuilding the heap.  Repeat 
	# as necessary.  

	def heapSort(time=false,verbose=false,visual=false)
		startTime = Time.now if time
		result = hSort(self.dup,verbose,visual)
		endTime = Time.now if time
		return [result,endTime - startTime] if time
		return result
	end
	
	# ===heapSort!
	# Destructive version of heapSort.  Modifies list in-place. 
	
	def heapSort!(time=false,verbose=false,visual=false)
		startTime = Time.now if time
		result = hSort(self,verbose,visual)
		endTime = Time.now if time
		return [result,endTime - startTime] if time
		return result
	end
    
    # ===rubySort
    # Adds timing capability to the built-in sort function.  Call it with 
    # <array>.rubySort(true) to get both the sorted list and time returned in an
    # array, or with <array>.rubySort(true)[1] to get just the time.  Useful for 
    # comparing roll-your-own sorts with the built-in one on speed.  HINT: It's much faster.
    
    def rubySort(time=false)
    	startTime = Time.now if time
    	result = self.sort
    	endTime = Time.now if time
    	return [result, endTime - startTime] if time
    	return result
    end


end