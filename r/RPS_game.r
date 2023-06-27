#RPS games
#
#

rps_game <- function() {
  #greetings msg
  print("Rock Paper Scissors Game!")
  print("Choose your weapon!")
  print("1: Rock, 2: Paper, 3: Scissors, 4: Score summary, 5: Finish the game.")


#empty objects
player_choice <- "Lets play"
count_win <- 0
count_lose <- 0
count_draw <- 0

# loop
while (player_choice != "Finish the game.") {
  print("Rock, Paper, Scissor, what will you pick?: ")
  
  #bot's turn
  opp_weapon <- sample(c(1,2,3), size = 1)
  opp_choice <- factor(opp_weapon,
                 levels = c(1, 2, 3),
                 labels = c("Rock", "Paper", "Scissors"))
  
  #player's turn
  player_choice <- readLines("stdin", n=1)
  if (player_choice == "1") {
    player_choice <- "Rock"
  } else if (player_choice == "2") {
    player_choice <- "Paper"
  } else if (player_choice == "3") {
    player_choice <- "Scissors"
  } else if (player_choice == "4") {
    player_choice <- "Score Summary"
  } else if (player_choice == "5") {
    player_choice <- "Finish the game."
  }
  
  #scoring
  if (opp_choice == "Rock" & player_choice == "Paper" |
      opp_choice == "Paper" & player_choice == "Scissors" |
      opp_choice == "Scissors" & player_choice == "Rock") {
    count_win <- count_win + 1
  } else if (opp_choice == player_choice) {
    count_draw <- count_draw + 1
  } else if (opp_choice == "Rock" & player_choice == "Scissors" |
             opp_choice == "Paper" & player_choice == "Rock" |
             opp_choice == "Scissors" & player_choice == "Paper") {
    count_lose <- count_lose + 1
  }
  
  #display
  if (player_choice == "Finish the game.") {
    print("Ending the game, here's your score.")
    print(paste("Wins: ", count_win,
                "Loses: ", count_lose,
                "Draws: ", count_draw))
    break
  } else if (player_choice %in% c("Rock", "Paper", "Scissors")) {
    print(paste("You:", player_choice, "VS Bot:", opp_choice))
  } else if (player_choice == "Score Summary") {
    print(paste("Wins: ", count_win,
                "Loses: ", count_lose,
                "Draws: ", count_draw))
  } else {
    print("SIKE! That's the wrong number.")
    }
  }
}

rps_game()