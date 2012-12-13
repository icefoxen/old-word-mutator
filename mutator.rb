#!/usr/bin/env ruby
# String handling is being a pissy pain in the ass, is the only real problem
# here.
# I blame ruby's string.slice.

def randomLetter
   return rand( 26 ) + 97
end


# Add a random letter to a random place in a word
def addLetter( s )
   if s.length <= 2 then
      return s.chr + randomLetter
   end
   print s, " ", s.length, "\n"
   place = rand( s.length ) 
   letter = randomLetter
   first = s[0..place]
   last = s[place+1 .. s.length-1]
   return first + letter.chr + last
   
end


# Remove a random letter from a random place in a word
def remLetter( s )
   if not s then
      s = ""
   end
   if s.length <= 2 then
      return s
   end
   place = rand( s.length )
   first = s[0..place]
   last = s[place+2 .. s.length-1]
   return first + last
end

def randomString( len=20 )
   len = rand( len ) + 1
   str = ""
   len.times { |i|
      str << randomLetter
   }
   return str
end



def pokeLetter( s )
   s = s.clone
   place = rand( s.length )
   letter = s[place]
   poke = rand( 6 ) - 3

   if ((s[place] + poke) > 122) or ((s[place] + poke) < 97) then
      s[place] = (s[place] - poke)
   else
      s[place] = s[place] + poke
   end
   
   return s
end


def changeLetter( s )
   s = s.clone
   place = rand( s.length )
   s[place] = randomLetter
   return s
end


# We have three possible mutations:
# Add a random letter, remove a random letter,
# and alter a letter to a different (random) letter.
# Lots of random, ne?
def mutateString( s )
   chance = rand()
   if chance < 0.2 then  # Add random letter
      return addLetter( s )
   elsif chance < 0.4 then # Remove random letter
      return remLetter( s )
   elsif chance < 0.6 then # Mutate random letter
      return changeLetter( s )
   elsif chance < 0.9 then # Roll again, twice.  ^_^
      return mutateString( mutateString( s ) )
   end
end



# ...ugh.  Until I can think of a way to breed strings that makes sense,
# I can't really progress here...  hmm.
# Let's just do it with mutation, then.
#def breed( s1, s2 )
#
#end


def levenshteinDistance( s1, s2 )
   # Make a table of s1.length+1 rows by s2.length+1 columns
   table = Array.new( s1.length + 1 )
   table.collect! { |x| Array.new( s2.length + 1, 0 ) }

   s1.length.times { |i|
      table[i][0] = i
   }
   s2.length.times { |i|
      table[0][i] = i
   }
   (1..(s1.length)).each { |i|
      (1..(s2.length)).each { |j|
         cost = 0
         if s1[i] != s2[j] then
            cost = 1
         end
         table[i][j] = [
            table[i-1][j] + 1,      # Deletion
            table[i][j-1] + 1,      # Insertion
            table[i-1][j-1] + cost  # Substitution
         ].min
      }
   }
   return table[-1][-1]
end


def newGeneration( size )
   a = Array.new( size, "" )
   a = a.collect { |x| randomString }
   return a
end

# Each generation, we keep the best half, and fill the rest out with random
# stuffs.
def nextGeneration( previousGeneration, target )
   def compWords( s1, s2, target )
      l1 = levenshteinDistance( s1, target )
      l2 = levenshteinDistance( s2, target )
      return l1 <=> l2
   end
   gensize = previousGeneration.length
   gen = previousGeneration.sort { |x,y| compWords(x,y,target) }
   gen = gen[0..gensize/2]

   while gen.length < gensize do
      gen << randomString()
   end
   return gen 
end


def mutateGeneration( generation )
   return generation.collect { |x| mutateString(x) }
end

def runGeneration( gen, target )
   return mutateGeneration( nextGeneration( gen, target ) )
end

def runGenerations( gen, count, target )
   for i in 0..count do
      print "Running generation ", i, "\n"
      print gen.join(", "), "\n"
      gen = runGeneration( gen, target )
      print gen.join(", "), "\n"
   end
   return gen
end

gen = newGeneration( 10 )
runGenerations( gen, 1, "foobar" )
