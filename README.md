# Oversmart-Shuffle
Oversmart Shuffle algorithm for shuffling songs

Optimised : 
### Function: `loadQueue(placeholderT, sortMethod)`

This function sorts and shuffles a playlist into a queue using a custom sorting method and a probabilistic merging technique.

**Steps:**

1. **Initialize Queue:**
   - Move the first element from `placeholderT` to the `queue`.

2. **Sort Playlist:**
   - Copy and clear `placeholderT`.
   - Perform a bubble sort on the copied list (`sortedS`) based on a custom metric: `rating * standard`.

3. **Split Sorted Playlist:**
   - Split `sortedS` into two halves, `lists.a` and `lists.b`.

4. **Merge into Queue:**
   - Merge `lists.a` and `lists.b` back into the `queue` using a probabilistic selection:
     - Calculate the selection probability for `lists.a` using the formula:  
       `gProb = aVal / (aVal + bVal) * 100`
     - Randomly pick elements from `lists.a` or `lists.b` based on the calculated probability.

5. **Completion:**
   - Continue merging until both `lists.a` and `lists.b` are empty.


PseudoCode:

function loadQueue(placeholderT, sortMethod)

    // Move the first element of placeholderT to the queue
    currentlyPlaying = REMOVE the first element from placeholderT
    ADD currentlyPlaying to queue

    // Create a sorted copy of placeholderT
    sortedS = EMPTY LIST
    FOR each element in placeholderT
        ADD element to sortedS

    // Clear the original placeholderT
    CLEAR all elements in placeholderT

    // Bubble Sort sortedS based on a custom condition
    n = LENGTH of sortedS
    FOR j from 1 to n-1
        FOR i from 1 to n-j
            IF (sortedS[i].rating * sortedS[i].standard) < (sortedS[i + 1].rating * sortedS[i + 1].standard)
                SWAP sortedS[i] with sortedS[i + 1]

    // Split sortedS into two lists
    lists = {a: EMPTY LIST, b: EMPTY LIST}
    m = FLOOR(n/2)
    FOR i from 1 to m
        ADD sortedS[i] to lists.a
    FOR i from m+1 to n
        ADD sortedS[i] to lists.b

    aVal = sortMethod OR 1
    bVal = 1

    // Merge lists into queue with a probability-based decision
    FOR i from 1 to (LENGTH of lists.a + LENGTH of lists.b)
        IF lists.a is NOT EMPTY and lists.b is NOT EMPTY
            prob = RANDOM NUMBER between 1 and 100
            gProb = aVal / (aVal + bVal) * 100
            opt = IF prob <= gProb THEN "a" ELSE "b"

            inputSong = REMOVE random element from lists[opt]
            ADD inputSong to queue
        ELSE IF lists.a is NOT EMPTY
            inputSong = REMOVE random element from lists.a
            ADD inputSong to queue
        ELSE IF lists.b is NOT EMPTY
            inputSong = REMOVE random element from lists.b
            ADD inputSong to queue
        ELSE
            BREAK the loop IF both lists are empty
