local playlist = {}
local queue = {}
local iterationQ = 1
love.graphics.setFont(love.graphics.newFont("nihonium.ttf", 30))
function createSongs()
    for i = 1, 10 do
        table.insert(playlist,     {
            name = "song"..i,
            standard = math.random(1,1000),
            rating = math.random(1,10),
        })
    end
end

function addToQueue(song)
    local temp = queue
    local firstSong = queue[1]

    queue = {}
    queue[1] = firstSong
    queue[2] = song

    for i = 2, #temp do
        table.insert(queue, temp[i])
    end
end
function printList(arr, arrname)
    print("Array of "..arrname)
    for i = 1, #arr do
        print(arr[i].name.. " : ".. arr[i].standard .. " : " .. arr[i].rating)
    end
    print("         ")

end
function loadQueue(placeholderT, sortMethod)
    print("----------------------------------------")
    -- Super Smart Shuffle
    local currentlyPlaying = table.remove(placeholderT, 1)
    table.insert(queue, currentlyPlaying)
    --[[local inputSong = table.remove(playlist, math.random(1,#playlist))
        table.insert(queue, inputSong)
    ]]
    local sortedS = {}
    for i = 1, #placeholderT do
        sortedS[i] = placeholderT[i]
        
    end
    for k in pairs(placeholderT) do
        placeholderT[k] = nil
    end
    local n = #sortedS
    for j = 1, n - 1 do  -- Outer loop for multiple passes
        for i = 1, n - j do  -- Inner loop for adjacent comparisons
            --sortedS[i].rating < sortedS[i + 1].rating or ( sortedS[i].rating == sortedS[i + 1].rating and sortedS[i].standard < sortedS[i + 1].standard)
            if sortedS[i].rating * sortedS[i].standard < sortedS[i + 1].rating * sortedS[i + 1].standard then
                local t = sortedS[i + 1]
                sortedS[i + 1] = sortedS[i]
                sortedS[i] = t

            end
        end
    end
    local lists = {
        a = {}, b = {}
    }
    local m = math.floor(n/2)
    for i = 1, m do
        lists.a[i] = sortedS[i]
    end
    for i = m + 1, n do
        lists.b[i - m] = sortedS[i]
    end
    local aVal = sortMethod or 1
    local bVal = 1
    for i = 1, #lists.a + #lists.b do
        if #lists.a > 0 and #lists.b > 0 then
            local prob = math.random(1, 100)
            local gProb = aVal / (aVal + bVal) * 100
            local opt = prob <= gProb and "a" or "b"
            
            local inputSong = table.remove(lists[opt], math.random(1, #lists[opt]))
            table.insert(queue, inputSong)
        elseif #lists.a > 0 then
            local inputSong = table.remove(lists.a, math.random(1, #lists.a))
            table.insert(queue, inputSong)
        elseif #lists.b > 0 then
            local inputSong = table.remove(lists.b, math.random(1, #lists.b))
            table.insert(queue, inputSong)
        else
            break  -- Break the loop if both lists are empty
        end

    end
    
end

function love.update()
    if #queue == 0 then
        iterationQ = 0
    end
end

function nextSong()
    fullPlayed()
    iterationQ = iterationQ + 1
    print(iterationQ)
    loadQueue(queue, iterationQ)
end

function fullPlayed()
    table.remove(queue, 1)
    printList(queue, "Queue")
end
function love.load()
    createSongs()
    printList(playlist, "Playlist")

end
function love.keypressed(key)
    if key == "w" then
        addToQueue({name = "song"..math.random(11,20),
        standard = math.random(1,1000),
        rating = math.random(1,10)
        })
        printList(queue, "Queue")
    elseif key == "e" then
        nextSong()
    elseif key == "space" then
        fullPlayed()
    elseif key == "return" then
        loadQueue(playlist, 1)
    elseif key == "q" then
        createSongs()
    end
end
function printTable(tab, x, y)
    for i = 1, #tab do
        local val = tab[i]
        love.graphics.setColor(0,val.standard * val.rating/10000,0)
        love.graphics.print(val.name .. " : " .. val.standard .. " : " .. val.rating, x, (y) * i )
        love.graphics.setColor(1,1,1)

    end
end
function love.draw()
    love.graphics.print("Playlist Songs", 50, 10)
    printTable(playlist, 50, 30)

    love.graphics.print("Queue Songs", 300, 10)
    printTable(queue, 300, 30)
end


