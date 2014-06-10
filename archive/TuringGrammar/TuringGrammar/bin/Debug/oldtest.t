var game_choice : string := ""
%Arcade
exit when 5 ~= 1

procedure Arcade()

    loop
    color (54)
    colorback (black)
    cls()
    locate(2,3)
    locate (maxrow - 6, 15)
    put "Money: $", money

    Pic.ScreenLoad ("Arcade.bmp", 348, 570, picCopy)
    Pic.ScreenLoad ("Snake.bmp", 325, 50, picCopy)
    Pic.ScreenLoad ("Dodge.bmp", 325, 360, picCopy)

    locate (20, maxcol div 2 - (length ("Dodge ($5 per game)") div 2))
    put "Dodge ($5 per game)"

    locate (22, maxcol div 2)
    put "OR"

    locate (24, maxcol div 2 - (length ("Snake ($10 per game)") div 2))
    put "Snake ($10 per game)"
    
    exit when 5 ~= -1
    %end loop
    %end Arcade
    


    locate (maxrow - 4, maxcol - 20)
    put "Stronghold"
    drawbox (maxx - 205, 55, maxx - 55, 105, 54)
    loop
        buttonwait ("down", x, y, btn, updown)
        game_choice := ""
        if x > 325 and x < 625 then
        if y < 250 and y > 50 then
            if money > 9 then
            money := money - 10
            game_choice := "snake"
            end if
        elsif y < 560 and y > 360 then
            if money > 4 then
            money := money - 5
            game_choice := "dodge"
            end if
        end if
        elsif x > maxx - 205 and x < maxx - 55 then
        if y < 105 and y > 55 then
            game_choice := "none"
        end if
        end if

        exit when not (game_choice = "")      %Makes sure only to exit when there has been a valid click
        sound (440, 200)
    end loop
    exit when game_choice = "none"

    

    % ??????????????????????????????????????????????????????????????????????????????????????????????????????????????
    % ??????????????????????????????????????????????????????????????????????????????????????????????????????????????

    %This is where the code for snake begins
    if game_choice = "snake" then
        setscreen ("nobuttonbar")
        setscreen ("nocursor")




        segment (1, 1) := 200
        segment (1, 2) := 200


        %Beginning of program
        %loop
        valid := ""
        dx := 0
        dy := 0
        x := 20
        y := 20
        coverx := 200
        covery := 200
        life := ""
        length1 := 1
        segment (1, 1) := 200
        segment (1, 2) := 200
        score := 0
        keytemp := ""
        eat := ""
        whatside := ""
        score := 0
        colorback (white)
        cls()
        color (black)
        setscreen ("echo")
        loop

        put "What difficulty would you like to play at (1-3 where 3 is the hardest)? " ..
        getch (difchoice)
        delay (100)
        dif := 0

        case difchoice of
            label "1" :
            game_speed := 65
            dif := 1
            label "2" :
            game_speed := 40
            dif := 2
            label "3" :
            game_speed := 25
            dif := 3
            label :
        end case
        exit when dif ~= 0
        cls()
        end loop
        setscreen ("noecho")

        colorback (black)
        cls

        drawfillbox (120, 120, maxx - 120, maxy - 120, white)
        randint (foodx, 150, maxx - 150)
        randint (foody, 150, maxy - 150)

        color (54)
        locate (maxrow - 1, maxcol - 15)
        put "Score = ", score

        drawfillbox (foodx, foody, foodx + foodsize, foody + foodsize, 10)
        eat := ""
        drawbox (segment (1, 1), segment (1, 2), segment (1, 1) + size, segment (1, 2) + size, 42)
        drawbox (segment (1, 1) + 1, segment (1, 2) + 1, segment (1, 1) + size - 1, segment (1, 2) + size - 1, 12)
        drawfillbox (segment (1, 1) + 2, segment (1, 2) + 2, segment (1, 1) + size - 2, segment (1, 2) + size - 2, red)
        loop
        View.Update

        getch (key)
        if ord (key) = 205 then
            if keytemp ~= "l" then
                keytemp := "r"
                dx := size
                dy := 0
            end if
        end if
        if ord (key) = 203 then
        if keytemp ~= "r" then
            keytemp := "l"
            dx := -size
            dy := 0
            end if
        end if
        if ord (key) = 200 then
        if keytemp ~= "d" then
            keytemp := "u"
            dx := 0
            dy := size
            end if
        end if

        if ord (key) = 208 then
        if keytemp ~= "u" then
            keytemp := "d"
            dx := 0
            dy := -size
            end if
        end if

        if keytemp = "u" then
            if whatside = "t" then
            life := "dead"
            end if
        elsif keytemp = "d" then
            if whatside = "b" then
            life := "dead"
            end if
        elsif keytemp = "r" then
            if whatside = "r" then
            life := "dead"
            end if
        elsif keytemp = "l" then
            if whatside = "l" then
            life := "dead"
            end if
        end if

        exit when life ~= ""
        loop
            if eat = "eaten" then
            valid := ""
            score := score + dif

            loop
                drawfillbox (foodx, foody, foodx + foodsize, foody + foodsize, white)
                randint (foodx, 150, maxx - 150)
                randint (foody, 150, maxy - 150)
                if whatdotcolor (foodx, foody) = white and whatdotcolor (foodx + size, foody + size) = white and whatdotcolor (foodx + size, foody) = white and whatdotcolor (foodx,
                    foody +
                    size)
                    = white then
                valid := "yes"

                drawfillbox (foodx, foody, foodx + foodsize, foody + foodsize, 10)
                end if
                color (54)
                locate (maxrow - 1, maxcol - 15)
                put "Score = ", score
                exit when valid = "yes"
            end loop
            end if
            eat := ""
            loop


            for decreasing i : length1 + 1 .. 2
                segment (i, 1) := segment (i - 1, 1)
                segment (i, 2) := segment (i - 1, 2)
            end for
            coverx := segment (length1 + 1, 1)
            covery := segment (length1 + 1, 2)
            segment (1, 1) := segment (1, 1) + dx
            segment (1, 2) := segment (1, 2) + dy

            for i : 1 .. length1
                drawbox (segment (i, 1), segment (i, 2), segment (i, 1) + size, segment (i, 2) + size, 42)
                drawbox (segment (i, 1) + 1, segment (i, 2) + 1, segment (i, 1) + size - 1, segment (i, 2) + size - 1, 12)
                drawfillbox (segment (i, 1) + 2, segment (i, 2) + 2, segment (i, 1) + size - 2, segment (i, 2) + size - 2, red)
            end for
            exit when eat ~= ""
            exit when life = "dead"
            if eat = "" then
                drawfillbox (coverx, covery, coverx + size, covery + size, white)
            end if
            %Detection


            %Bottom Detection

            if whatdotcolor (segment (1, 1) + size div 2, segment (1, 2) - 1) = 10 then
                eat := "eaten"
                length1 := length1 + 1

            elsif whatdotcolor (segment (1, 1) + size div 2, segment (1, 2) - 1) = black then
                life := "dead"

                %Right Detection
            elsif whatdotcolor (segment (1, 1) + size + 1, segment (1, 2) + size div 2) = 10 then
                eat := "eaten"
                length1 := length1 + 1

            elsif whatdotcolor (segment (1, 1) + size + 1, segment (1, 2) + size div 2) = black then
                life := "dead"

                %Top Detection
            elsif whatdotcolor (segment (1, 1) + size div 2, segment (1, 2) + size + 1) = 10 then
                eat := "eaten"
                length1 := length1 + 1

            elsif whatdotcolor (segment (1, 1) + size div 2, segment (1, 2) + size + 1) = black then
                life := "dead"

                %Left Detection
            elsif whatdotcolor (segment (1, 1) - 1, segment (1, 2) + size div 2) = 10 then
                eat := "eaten"
                length1 := length1 + 1

            elsif whatdotcolor (segment (1, 1) - 1, segment (1, 2) + size div 2) = black then
                life := "dead"

            end if
            exit when life ~= ""

            %To see if you are along side youself
            whatside := ""
            if whatdotcolor (segment (1, 1) + size div 2, segment (1, 2) - 4) = red then
                whatside := "b"
            elsif whatdotcolor (segment (1, 1) + size + 4, segment (1, 2) + size div 2) = red then
                whatside := "r"
            elsif whatdotcolor (segment (1, 1) + size div 2, segment (1, 2) + size + 4) = red then
                whatside := "t"
            elsif whatdotcolor (segment (1, 1) - 4, segment (1, 2) + size div 2) = red then
                whatside := "l"
            end if


            %To see if you hit yourself

            %Bottom Detection
            if keytemp = "d" then
                if whatdotcolor (segment (1, 1) + size div 2, segment (1, 2) - 4) = red then
                life := "dead"
                end if

                %Right Detection
            elsif keytemp = "r" then
                if whatdotcolor (segment (1, 1) + size + 4, segment (1, 2) + size div 2) = red then
                life := "dead"
                end if

                %Top Detection
            elsif keytemp = "u" then
                if whatdotcolor (segment (1, 1) + size div 2, segment (1, 2) + size + 4) = red then
                life := "dead"
                end if

                %Left Detection
            elsif keytemp = "l" then
                if whatdotcolor (segment (1, 1) - 4, segment (1, 2) + size div 2) = red then
                life := "dead"
                end if
            end if

            %Done snake detection


            exit when eat = "eaten"


            delay (game_speed)
            exit when hasch
            end loop
            exit when life ~= ""
            exit when hasch
        end loop
        exit when life ~= ""
        end loop
        delay (300)
        colorback (white)
        cls

        color (black)
        put "You died with a score of ", score
        delay (1000)
        cls
        var ch : string (1)
        %This loop just makes sure that there are no keys in the buffer left over from pressing the arrow keys.
        loop
        exit when not hasch
        getch (ch)         % Discard this character
        end loop
        %end loop
        %This is where the code for snake ends.

        colorback (black)
        cls

        % ??????????????????????????????????????????????????????????????????????????????????????????????????????????????
        % ##############################################################################################################

    elsif game_choice = "dodge" then

        %This is where the code for dodge begins

        setscreen ("graphics")

        cls
        x1 := maxx div 2
        x2 := maxx div 2 + 25
        y1 := maxy div 2
        y2 := maxy div 2 + 25
        dx := 0
        dy := 0
        key := ""
        using := ""
        dead := ""
        done := ""
        for i : 1 .. 4
        c (i) := 0
        end for
        nope := ""
        win := ""

        loop

        put "What difficulty would you like to play at (1-3 where 3 is the hardest)? " ..
        getch (difchoice)
        delay (100)
        dif := 0

        case difchoice of
            label "1" :
            speed := 1
            dif := 1
            label "2" :
            speed := 2
            dif := 2
            label "3" :
            speed := 3
            dif := 3
            label :
        end case
        exit when dif ~= 0
        cls
        end loop
        setscreen ("offscreenonly")
        % const uarrow : char := chr (200)
        % const larrow : char := chr (203)
        % const rarrow : char := chr (205)
        % const darrow : char := chr (201)
        % var keys : array char of boolean
        % Input.KeyDown (keys)


        %Board
        loop
        colorback (black)
        cls
        drawfillbox (1, 1, maxx, maxy, black)
        drawfillbox (40, 40, maxx - 40, maxy - 40, (15))
        drawfillbox (100, 100, 200, 200, black)
        drawfillbox (200, 250, 250, 300, black)
        drawfillbox (400, 250, 500, 300, black)
        drawfillbox (200, 150, 250, 200, black)
        drawfillbox (350, 75, 550, 150, black)
        drawfillbox (120, 280, 160, 320, black)
        drawfillbox (x1, y1, x2, y2, red)
        drawfill (2, 2, black, black)


        %Drawing things to get

        if c (1) = 0
            then
            drawfillbox (55, 55, 90, 90, green)
        end if
        if c (2) = 0
            then
            drawfillbox (maxx - 90, maxy - 90, maxx - 45, maxy - 45, blue)
        end if
        if c (3) = 0
            then
            drawfillbox (maxx - 80, 45, maxx - 45, 90, yellow)
        end if
        if c (4) = 0 then
            drawfillbox (90, maxy - 90, 45, maxy - 45, purple)
        end if


        color (red)
        locate (1, maxcol div 2 - (length ("Dodge the obstacles") div 2))
        put "Dodge the Obstacles"
        % locate (maxrow - 1, 1)
        % put "Squares gotten= ", count
        View.Update
        getch (key)
        if ord (key) = 205 then
            dx := speed
            dy := 0
            % x1 := x1 + dx
            % x2 := x2 + 1
        end if
        if ord (key) = 203 then
            dx := -speed
            dy := 0

            % x1 := x1 - 1
            %     x2 := x2 - 1
        end if
        if ord (key) = 200 then
            dx := 0
            dy := speed
            % y1 := y1 + 1
            %     y2 := y2 + 1
        end if
        if ord (key) = 208 then
            dx := 0
            dy := -speed
            % y1 := y1 - 1
            %     y2 := y2 - 1
        end if
        loop
            colorback (black)
            cls
            drawfillbox (1, 1, maxx, maxy, black)
            drawfillbox (40, 40, maxx - 40, maxy - 40, (15))
            drawfillbox (100, 100, 200, 200, black)
            drawfillbox (200, 250, 250, 300, black)
            drawfillbox (400, 250, 500, 300, black)
            drawfillbox (200, 150, 250, 200, black)
            drawfillbox (350, 75, 550, 150, black)
            drawfillbox (120, 280, 160, 320, black)
            drawfillbox (x1, y1, x2, y2, red)
            drawfill (2, 2, black, black)


            %Drawing things to get

            if c (1) = 0
                then
            drawfillbox (55, 55, 90, 90, green)
            end if
            if c (2) = 0
                then
            drawfillbox (maxx - 90, maxy - 90, maxx - 45, maxy - 45, blue)
            end if
            if c (3) = 0
                then
            drawfillbox (maxx - 80, 45, maxx - 45, 90, yellow)
            end if
            if c (4) = 0 then
            drawfillbox (90, maxy - 90, 45, maxy - 45, purple)
            end if


            color (red)


            locate (1, maxcol div 2 - (length ("Dodge the obstacles") div 2))
            put "Dodge the Obstacles"
            View.Update


            delay (1)
            %Moving the square
            x1 := x1 + dx
            x2 := x2 + dx
            y1 := y1 + dy
            y2 := y2 + dy

            %Checking to see if it hit something

            if whatdotcolor (x1, y1) = black then
            % x1 := x1 + 1
            % x2 := x2 + 1
            using := "z"
            end if
            if whatdotcolor (x2, y2) = black then
            % x1 := x1 - 1
            % x2 := x2 - 1
            using := "z"
            end if
            if whatdotcolor (x1, y2) = black then
            % y1 := y1 + 1
            % y2 := y2 + 1
            using := "z"
            end if
            if whatdotcolor (x2, y1) = black then
            % y1 := y1 - 1
            % y2 := y2 - 1
            using := "z"
            end if
            nope := ""
            %Checking to see if I got a blue thing




            if whatdotcolor (x1, y1) = blue then
            % x1 := x1 + 1
            % x2 := x2 + 1
            count := count + 1
            c (2) := 1

            end if
            if whatdotcolor (x2, y2) = blue then
            % x1 := x1 - 1
            % x2 := x2 - 1
            count := count + 1
            c (2) := 1
            end if
            if whatdotcolor (x1, y2) = blue then
            % y1 := y1 + 1
            % y2 := y2 + 1
            count := count + 1
            c (2) := 1
            end if
            if whatdotcolor (x2, y1) = blue then
            % y1 := y1 - 1
            % y2 := y2 - 1
            count := count + 1
            c (2) := 1
            end if


            %Checking to see if I got a green thing



            if whatdotcolor (x1, y1) = green then
            % x1 := x1 + 1
            % x2 := x2 + 1
            count := count + 1
            c (1) := 1
            end if
            if whatdotcolor (x2, y2) = green then
            % x1 := x1 - 1
            % x2 := x2 - 1
            count := count + 1
            c (1) := 1
            end if
            if whatdotcolor (x1, y2) = green then
            % y1 := y1 + 1
            % y2 := y2 + 1
            count := count + 1
            c (1) := 1
            end if
            if whatdotcolor (x2, y1) = green then
            % y1 := y1 - 1
            % y2 := y2 - 1
            count := count + 1
            c (1) := 1
            end if


            %Checking to see if I got a yellow thing

            if whatdotcolor (x1, y1) = yellow then
            % x1 := x1 + 1
            % x2 := x2 + 1
            count := count + 1
            c (3) := 1
            end if
            if whatdotcolor (x2, y2) = yellow then
            % x1 := x1 - 1
            % x2 := x2 - 1
            count := count + 1
            c (3) := 1
            end if
            if whatdotcolor (x1, y2) = yellow then
            % y1 := y1 + 1
            % y2 := y2 + 1
            count := count + 1
            c (3) := 1
            end if
            if whatdotcolor (x2, y1) = yellow then
            % y1 := y1 - 1
            % y2 := y2 - 1
            count := count + 1
            c (3) := 1
            end if


            %Checking to see if I got a purple thing

            if whatdotcolor (x1, y1) = purple then
            % x1 := x1 + 1
            % x2 := x2 + 1
            count := count + 1
            c (4) := 1
            end if
            if whatdotcolor (x2, y2) = purple then
            % x1 := x1 - 1
            % x2 := x2 - 1
            count := count + 1
            c (4) := 1
            end if
            if whatdotcolor (x1, y2) = purple then
            % y1 := y1 + 1
            % y2 := y2 + 1
            count := count + 1
            c (4) := 1
            end if
            if whatdotcolor (x2, y1) = purple then
            % y1 := y1 - 1
            % y2 := y2 - 1
            count := count + 1
            c (4) := 1
            end if


            %To see if i won yet

            if c (1) = 1
                then
            if c (2) = 1
                then
                if c (3) = 1
                    then
                if c (4) = 1
                    then
                    win := "yes"
                end if
                end if
            end if
            end if


            exit when hasch
            exit when using = "z"
            exit when win = "yes"

        end loop


        exit when win = "yes"
        exit when using = "z"

        end loop
        delay (400)

        setscreen ("nooffscreenonly")
        colorback (white)
        cls
        color (black)
        if win = "yes" then
        put "You Won!!!"
        end if
        if using = "z" then
        put "You died!!!"
        end if
        color (54)
        delay (2500)





        %This is where the code for dodge ends

        %Putting the screen settings back to normal


        setscreen ("graphics:950;650")
        colorback (black)
        cls

        % ##############################################################################################################
        % ##############################################################################################################



    end if

    end loop
    setscreen ("graphics:950;650")
    colorback (black)
    cls
    setscreen ("nooffscreenonly")



end Arcade
*/
