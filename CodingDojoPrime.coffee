## Codigo
class Player
  constructor: (@name)->  
    @score = 0
    @advantage = false


class Game
  constructor: (player1, player2)-> 
    @winner= false 
    @duece = false
    @player1 = player1
    @player2 = player2
    @player1.score = 0
    @player2.score = 0

  verifyPlayer: (player)-> 
    #if(player != @player1 && player != @player2)
    #  throw "Payer invalid"

  isPlayes1:(player)-> 
    player == @player1
  
  isPlayes2:(player)-> 
    player == @player2

  makeNormalScore: (player)->
    if(player.score < 30)
      player.score += 15
      return true
    else if(player.score < 40)
      player.score += 10
      return true
    return false

  makeAdvantage: (whoScoredPlayer,enemyPlayer)->
    if(enemyPlayer.advantage)
      enemyPlayer.advantage = false
    else
      whoScoredPlayer.advantage = true

  makeWinner: (whoScoredPlayer,enemyPlayer)->
    if (whoScoredPlayer.score == 40 && enemyPlayer.score < 40) or (whoScoredPlayer.advantage && !enemyPlayer.advantage)
      @winner = whoScoredPlayer
    else 
      this.makeAdvantage(whoScoredPlayer,enemyPlayer)

  enemyPlayer: (player)->
    if(this.isPlayes1(player))
      @player2
    else
      @player1

  verifyDuce: (whoScoredPlayer,enemyPlayer)->
    if(whoScoredPlayer.score ==40 && enemyPlayer.score==40)
      @duece = true


  score: (player)->
    this.verifyPlayer(player)
    if(!this.makeNormalScore(player))
      this.makeWinner(player,this.enemyPlayer(player))
    this.verifyDuce(player,this.enemyPlayer(player))


## Teste

  $(()->
    module("Game")
    test("Start player", ()-> equal(new Player().score, 0, "Quando um player eh criado, seu placar comeca com 0"))

    startGameTest = ()->
            player1 = new Player()
            player2 = new Player()
            game = new Game(player1,player2)
            equal(player1.score,player2.score,"Quando o jogo comeca o placar comeca igual")
            equal(0,player1.score,"Quando o jogo comeca o placar do player 1 é 0")
            equal(0,player2.score,"Quando o jogo comeca o placar do player 2 é 0")
            equal(false,player1.advantage,"Quando o jogo comeca o player 1 nao tem a vantagen")
            equal(false,player2.advantage,"Quando o jogo comeca o placar 2  nao tem a vantagen")

    test("Start game", startGameTest)

    point1Test = ()->
          player1 = new Player()
          player2 = new Player()
          game1 = new Game(player1,player2)
          game1.score(player1)
          equal(player1.score,15, "No primeiro ponto o jogador deve ter 15 pontos")
    test("Primeiro ponto", point1Test)

    point2Test = ()->
          player1 = new Player()
          player2 = new Player()
          game1 = new Game(player1,player2)
          game1.score(player1)
          game1.score(player1)
          equal(player1.score,30, "No segundo ponto o jogador deve ter 30 pontos")
    test("Segundo ponto",point2Test)

    point3Test = ()->
          player1 = new Player()
          player2 = new Player()
          game1 = new Game(player1,player2)
          game1.score(player1)
          game1.score(player1)
          game1.score(player1)
          equal(player1.score,40, "No terceiro ponto o jogador deve ter 40 pontos")
    test("Terceito ponto",point3Test)

    point4Test = ()->
          player1 = new Player()
          player2 = new Player()
          game1 = new Game(player1,player2)
          game1.score(player1)
          game1.score(player1)
          game1.score(player1)
          game1.score(player1)
          equal(player1.score,40, "No quinto ponto o jogador continua com 40 pontos")
    test("Quarto ponto",point4Test)    

    point5Test = ()->
          player1 = new Player()
          player2 = new Player()
          game1 = new Game(player1,player2)
          game1.score(player1)
          game1.score(player1)
          game1.score(player1)
          game1.score(player1)
          game1.score(player1)
          equal(player1.score,40, "No quinto ponto o jogador continua com 40 pontos")
          equal(game1.winner,player1, "No quinto o jogador ganha")
    test("Quinto ponto",point5Test)

    gameTiedTest = ()->#ouEmpateTest
          player1 = new Player("Playe 1")
          player2 = new Player("Playe 2")
          game1 = new Game(player1,player2)
          game1.score(player1)
          game1.score(player1)
          game1.score(player1)
          
          game1.score(player2)
          game1.score(player2)
          game1.score(player2)

          equal(player1.score,40, "O Jogador 1 tem 40 pointo no empate de 4 a 4")
          equal(player2.score,40, "O Jogador 2 tem 40 pointo no empate de 4 a 4")
          equal(game1.winner,false, "o jogo nao tem ganhador")
          equal(game1.duece,true, "o jogo fica dueceado")

    test("Empate 40 a 40",gameTiedTest)   
    
    advantagePlayer1Test = ()->
          player1 = new Player()
          player2 = new Player()
          game1 = new Game(player1,player2)
          game1.score(player1)
          game1.score(player1)
          game1.score(player1)
          
          game1.score(player2)
          game1.score(player2)
          game1.score(player2)

          game1.score(player1)

          equal(player1.score,40, "O Jogador 1 tem 40 pontos")
          equal(player2.score,40, "O Jogador 2 tem 40 pointo")
          ok(player1.advantage, "O Jogador 1 tem a vantagens")
          ok(!player2.advantage, "O Jogador 2 nao tem a vantagens")
          equal(game1.winner,false, "o jogo nao tem ganhador")
          equal(game1.duece,true, "o jogo fica dueceado")
    test("Vantagen do jogador 1",advantagePlayer1Test)

    advantagePlayer2Test = ()->
          player1 = new Player()
          player2 = new Player()
          game1 = new Game(player1,player2)
          game1.score(player1)
          game1.score(player1)
          game1.score(player1)
          
          game1.score(player2)
          game1.score(player2)
          game1.score(player2)

          game1.score(player2)

          equal(player1.score,40, "O Jogador 1 tem 40 pontos")
          equal(player2.score,40, "O Jogador 2 tem 40 pointo")
          ok(!player1.advantage, "O Jogador 1 nao tem a vantagen")
          ok(player2.advantage, "O Jogador 2 tem a vantagen")
          equal(game1.winner,false, "o jogo nao tem ganhador")
          equal(game1.duece,true, "o jogo fica dueceado")
    test("Vantagen do jogador 2",advantagePlayer1Test)

    gameTiedAfterAnvantegePlayer1Test = ()->
          player1 = new Player()
          player2 = new Player()
          game1 = new Game(player1,player2)
          game1.score(player1)
          game1.score(player1)
          game1.score(player1)
          
          game1.score(player2)
          game1.score(player2)
          game1.score(player2)

          game1.score(player1)
          game1.score(player2)

          equal(player1.score,40, "O Jogador 1 tem 40 pontos")
          equal(player2.score,40, "O Jogador 2 tem 40 pointo")
          ok(!player1.advantage, "O Jogador 1 nao tem a vantagen")
          ok(!player2.advantage, "O Jogador 2 nao tem a vantagen")
          equal(game1.winner,false, "o jogo nao tem ganhador")
          equal(game1.duece,true, "o jogo fica dueceado")
    test("Empate apos vantagen do jogador 1",gameTiedAfterAnvantegePlayer1Test)

    player2WinAfterTied = ()->
          player1 = new Player()
          player2 = new Player()
          game1 = new Game(player1,player2)
          game1.score(player1)
          game1.score(player1)
          game1.score(player1)
          
          game1.score(player2)
          game1.score(player2)
          game1.score(player2)

          game1.score(player1)
          game1.score(player2)
          game1.score(player2)
          game1.score(player2)

          equal(player1.score,40, "O Jogador 1 tem 40 pontos")
          equal(player2.score,40, "O Jogador 2 tem 40 pointo")
          ok(!player1.advantage, "O Jogador 1 nao tem a vantagen")
          ok(player2.advantage, "O Jogador 2 nao tem a vantagen")
          equal(game1.winner,player2, "o Jogador 2 ganhou")
          equal(game1.duece,true, "o jogo fica dueceado")
    test("Empate apos vantagen do jogador 1",player2WinAfterTied)    
     
  );