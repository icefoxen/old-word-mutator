# Yayz, I have python mode again!
# Anyway, this takes a word and does genetic algorithm stuff to
# turn it into another word.
#
# 'Cause I wanna play with genetic algorithms.
# Breed, mutate, select!

import random






# Apparently python doesn't let you go string[x] = "a"
# Now that's fucked up.

def str2list( s ):
    res = []
    for x in s:
        res += x
    return res

def getRandomLetter():
    return [chr( random.randrange( 26 ) + 96 )]

def newString( length ):
    a = []
    while len( a ) < length:
        a += ' '
    return a


# Mutators

# Adds a letter at random
def addLetter( word ):
    place = random.randrange( len( word ))
    before = word[:place]
    after = word[place:]
    return before + getRandomLetter() + after

# Removes a letter at random
def removeLetter( word ):
    place = random.randrange( len( word ) - 1 )
    before = word[:place]
    after = word[place+1:]
    return before + after


def alterLetterSlightly( word ):
    place = random.randrange( len( word ) )
    letter = word[place]
    offset = random.randrange( 6 ) - 3

    # This is fucked up, I can't get the ASCII index of a letter.
    letternum = XXX( letter )
    
    if (letternum + offset < 97):
        letter = chr( letternum - offset )
    elif (letternum + offset > (97 + 25)):
        letter = chr( letternum - offset )
    else:
        letter = chr( letternum + offset )

    word[place] = letter
    return word

def alterLetterCompletely( word ):
    place = random.randrange( len( word ) )
    word[place] = getRandomLetter()
    return word





# Cross-breeding words!  How kinky.
def breed( word1, word2 ):
    newlength = (len( word1 ) + len( word2 )) / 2
    child = newString( newlength )
    
    for x in range( newlength ):
        if random.choice( [True, False] ):
            if len( word1 ) <= x:
                child[x] = word2[x]
            else:
                child[x] = word1[x]
        else:
            child[x] = word2[x]
    return child


# Delta is what chance of mutation there is.
# We say that 70% of all mutations are slight alterations, 10%
# are complete alterations, 10% are adding a letter, and 10% are removing
# a letter.
def mutate( word ):
    pass


# Now we need to have a suitability criteria to know how close a word
# is to the desired one.
# The suitability is a number.  Each letter difference makes a word
# less suitable by a value equal to the distance between the letter and
# the target letter.  Each letter too many or too few increases the
# suitability number by, say, 30.  A suitability of 0 indicates a
# perfect match.
# 
# The word we want here is "Hamming distance"
# However, a more accurate wossname would be Levenshtein distance,
# apparently.

#def hamdist(s1, s2):
#   assert len(s1) == len(s2)
#   return sum(ch1 != ch2 for ch1, ch2 in zip(s1, s2))

def levenshtein( s1, s2 ):
   table = []  # s1.len rows, s2.len columns
   for c in s1:
      table[c


    



# Bah, we should just make a random string.
SRCWORD = str2list( "foobarbop" )
DESTWORD = str2list( "nyarlathotep" )


