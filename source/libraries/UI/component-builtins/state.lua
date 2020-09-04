-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Mooshua

-- Creates full (WITH history) state

return function (UseSpawn,...) 

    --[[
        @Description
            Creates a new basic state object
        
        @Params
            Bool, UseSpawn
                Whether or not to create a new thread for every function (Reccomended)

        @Returns
            Table, StateObject
    ]]

    local Context = {...}

    local Bind = {
        On = {},
        OnNot = {},
        Use = {},
        UseNot = {},
        Inject = {},
    }

    local Public = {
        history = {},
        state = nil
    }

    local function Update(New)

        for _,Call in pairs(Bind.Inject) do
            --  Run injections
            New = Call(New,unpack(Context))
        end

        --   I hate this.

        local Old = Public.state

        if (Old == New) then
            return nil
        end

        Public.state = New

        table.insert( Public.history, 1, Old )

        local function F(Call,...)

            local Info = {...}

            if (UseSpawn) then
                spawn(function()
                    Call(unpack(Info))
                end)
            else
                Call(unpack(Info))
            end

        end

        --  Whoo boy
        --  Call every function in a thread

        for _,Call in pairs(Bind.On[New] or {}) do
            F(Call,unpack(Context))
        end

        for _,Call in pairs(Bind.OnNot[Old] or {}) do
            F(Call,unpack(Context))
        end

        for _,Call in pairs(Bind.Use) do
            F(Call,New,unpack(Context))
        end

        for _,Call in pairs(Bind.UseNot) do
            F(Call,Old,unpack(Context))
        end

    end

    Public.inject = function(Call)

        table.insert(Bind.Inject,#Bind.Inject + 1,Call)

    end

    Public.on = function(Enum,Call)

        --[[
            @Description
                Binds a function to be called when a specific state is pushed

             @Params
                Any, State
                    The state that, when pushed, will trigger the function
                Function, F
                    The function which will be called

            @Returns
                Void, Nil, Null
                
        ]]
        
        Bind.On[Enum] = Bind.On[Enum] or {}
        table.insert(Bind.On[Enum],1,Call)

    end

    Public.off = function(Enum,Call)

        --[[
            @Description
                Binds a function to be called when a specific state is pushed to history.

             @Params
                Any, State
                    The state that, when it enters history, trigger the function
                Function, F
                        The function which will be called.

            @Returns
                Void, Nil, Null
                
        ]]

        Bind.OnNot[Enum] = Bind.OnNot[Enum] or {}
        table.insert(Bind.OnNot[Enum],1,Call)

    end

    Public.use = function(Call)

        --[[
            @Description
                Binds a function to be called when ANY state is pushed
            
            @Params
                Function, F
                    The function to be called. The function will be called with the state as the first argument. 
            
            @Returns
                Void, Nil, None
        ]]

        table.insert(Bind.Use, 1, Call)

    end

    Public.historyUse = function(Call)

        --[[
            @Description
                Binds a function to be called when ANY state is pushed to HISTORY
            
            @Params
                Function, F
                    The function to be called. The function will be called with the old state as the first argument. 
            
            @Returns
                Void, Nil, None
        ]]

        table.insert(Bind.UseNot,1,Call)

    end

    Public.push = function(State)

        --[[
            @Description
                Pushes a new state into the object, and pushes the previous state into history. 

            @Params
                Any, State
                    The State to be pushed

            @Returns
                Void, Nil, None
        ]]

        Update(State)

    end

    Public.pop = function()

        --[[
            @Description
                Takes the previous state and pushes it onto the object ("undo")
            
            @Params
                None
            
            @Returns
                Void, Nil, None
        ]]

        if (Public.history[1]) then
            Update(table.remove(Public.history,1))
        end

    end

    return Public
end