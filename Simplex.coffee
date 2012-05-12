#caso de teste

#Z max 7x1+3x2+2x3
#R1=5x1+2x2+2x3 <=19
#R2=2x1+1x2+2x3 <= 8
#ResultadoFinal x1=3, x2=2,x3=0,x4=0,x5=0 z=27
class Operacao
	colunaQueEntra: ()->
		menor = 0
		for i in this.z()
			if(menor>i) 
		 		menor =i
		this.z().indexOf(menor)
	z:()-> @r[this.iDeZ()]
	iDeZ:()-> @r.length-1
	linhaQueSai: ()-> 
		coluna = this.colunaQueEntra()
		menor = 100000
		i = 0
		linhaQueSai = 0
		for linha in @r
			if(i < this.iDeZ())
				valor = linha[linha.length-1] / linha[coluna]
				if(menor > valor)
					menor = valor 
					linhaQueSai = i
			i++
		linhaQueSai

	mostraCabecalho:()->
		i = 1
		linha = @r[0]
		ret = ""
		for valor in linha
			if(i==linha.length)
				isai = "TI"
			else	
				isai = "x#{i++}"
			ret += "\t#{isai}\t|"
		console.log ret

	mostraLinhas: ()->
		for linha in @r
			ret = ""
			for valor in linha
				ret += "\t#{valor}\t|"
			console.log ret
	mostraDetalhes:()->
		console.log "Coluna que Entra"
		console.log (this.colunaQueEntra()+1)
		console.log ("Linha que Sai")
		console.log (this.linhaQueSai()+1)
		console.log ("Valor Pivo")
		console.log (this.valorPivo())

	mostra: ()->
		this.mostraCabecalho()
		this.mostraLinhas()
		this.mostraDetalhes()

	valorPivo:()->
		@r[this.linhaQueSai()][this.colunaQueEntra()]
	mariz : ()-> 
		@r

	aredonda: (valor)->
		((Math.round(valor*100))/100)

	resolve:()->
		novaMatriz = this.mariz()
		pivo = this.valorPivo()
		i=0
		linhaQueSai = this.linhaQueSai();
		colunaQueEntra = this.colunaQueEntra();
		for valor in novaMatriz[linhaQueSai]
			novaMatriz[linhaQueSai][i]=novaMatriz[linhaQueSai][i]/pivo
			i++
		#console.log novaMatriz
		i=0
		for linha in novaMatriz
			valorParaSomar = linha[colunaQueEntra] * -1
			#console.log "Valor para somar:"+ valorParaSomar
			if(i != linhaQueSai)
			#	console.log "Esta fazendo linha" +i
				j=0
				for valor in linha 
					linha[j] = this.aredonda(valor+valorParaSomar*(novaMatriz[linhaQueSai][j]))
					j++
			i++
	eParaContinuar:()->
		for valor in this.z()
			if(valor <0)
				return true
		return false

	valorFinalX:(i)->
		valorFinal=0
		j=0
		for valor in @r[i]
			if(valor != 0)
				if(valor==1)
					valorFinal = @r[i][@r[i].length-1] 
				else 
					0
		  j++
		valorFinal

	mostraExprecaoFinal:()->
		i = 1
		linha = @r[0]
		ret = ""
		for valor in linha
			if(i==linha.length)
				continue
			else
				valor = this.valorFinalX(i)
				isai = "x#{i++}"
			ret += "\t#{isai} = #{valor},\t|"
		console.log ret

	resolveDeUmaVez:()->
		i=0
		while(this.eParaContinuar())
			console.log("Matriz #{i}")
			this.resolve()
			this.mostra()
			i++
		#this.mostraExprecaoFinal();




#code				
o = new Operacao
o.r = [[5,2,2,1,0,19],[2,1,2,0,1,8],[-7,-3,-2,0,0,0]]
o.resolveDeUmaVez()