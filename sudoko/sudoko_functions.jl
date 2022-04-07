function print_tabuleiro(tabuleiro)
    tabuleiro = tabuleiro'
    print("\n"*"-"^23*"\n")
    for elemento in 1:length(tabuleiro)
        if mod(elemento, 9) == 1
            print("| ")
        end    
        
        if tabuleiro[elemento] == 0
           print(". ") 
        else
            print(tabuleiro[elemento], " ")
        end

        if mod(elemento, 3) == 0
            print("|")
        end

        if mod(elemento,27) == 0
            print("\n"*"-"^23)
        end

        if mod(elemento, 9) ==0
            print("\n")
        end
    end

end


#Retorna um vetor com todos os numeros possíveis de se colocar naquela posição
function verifica_possibilidades!(tabuleiro, linnha, coluna)
	numeros = [1,2,3,4,5,6,7,8,9]
	possibilidades = []
	
	lin_pos = mod(linha,3) == 0 ? 3 : mod(linha,3)
	col_pos = mod(coluna,3) == 0 ? 3 : mod(coluna,3)
	
	quadrante = tabuleiro[linha - (lin_pos-1):linha+(3-lin_pos), coluna - (col_pos - 1):coluna+(3 - col_pos)]
	
	for numero in numeros
		possivel = false
		
		#verifica linha
		if !(numero in tabuleiro[linha,:])
			possivel = true
		#verifica colun
		elseif !(numero in tabuleiro[:, coluna])
			possivel = true
			
		#verifica quadrante
		elseif !(numero in quadrante)
			possivel = true
		end
		
		if possivel 
			append!(possibilidades, numero)	
		end	
	end
    return possibilidades
end



#Retorna um booleano se um valor pode ser colocado naquela linha e coluna
function permitido(valor, linha, coluna, tabuleiro)
    lin_pos = mod(linha,3) == 0 ? 3 : mod(linha,3)

    col_pos = mod(coluna,3) == 0 ? 3 : mod(coluna,3)

    quadrante = tabuleiro[linha - (lin_pos-1):linha+(3-lin_pos), coluna - (col_pos - 1):coluna+(3 - col_pos)]

    return !(tabuleiro[linha,coluna] != 0 || valor in tabuleiro[linha, :] || valor in tabuleiro[:, coluna] || valor in quadrante)
end


#Retorna uma liste de número que não existema naquel intervalo (linha, coluna ou quadrante)
function get_missing_numbers(intervalo)
    numeros = 1:length(intervalo)
    ausentes = []
    for numero in numeros
        if !(numero in intervalo)
            push!(ausentes, numero)
        end
    end
    return ausentes
end

#retorna uma matriz 3x3 dos quadrantes 
function get_quadrante(quad_lin,quad_col, tabuleiro)
    return tabuleiro[
        (quad_lin-1)*3 + 1:(quad_lin-1)*3 + 3, #linhas
        (quad_col-1)*3 + 1:(quad_col-1)*3 + 3, #colunas
        ]

end