include("sudoko_functions.jl")

tabuleiro = [
		3 5 0   0 0 0   0 0 8;
		0 0 0   1 5 4   0 7 0;
		0 0 0   6 0 3   2 0 0;
		
		0 4 1   7 0 8   9 2 0;
		0 9 0   0 0 0   0 1 0;
		0 3 5   4 0 9   8 6 0;
		
		0 0 9   5 0 1   0 0 0;
		0 1 0   8 7 6   0 0 0;
		5 0 0   0 0 0   0 8 1;
] 


completo = false
numero_de_verificacoes = 0
while !(completo)

    #Verifica todas a linhas
    do_lines = true
    while do_lines
        do_lines = false #a principio não é pra reprocessar linha
        for lin in 1:9
            do_line = true
            while do_line == true
                numeros_necessarios_dic = Dict{Any, Any}()
                empty!(numeros_necessarios_dic)

                for numero in get_missing_numbers(tabuleiro[lin,:])
                    merge!(numeros_necessarios_dic, Dict(numero => []))
                end
                numeros_necessarios_dic


                #ve onde pode colocar cada numero
                for col in 1:9
                    for numero in keys(numeros_necessarios_dic)
                        if permitido(numero, lin, col, tabuleiro)
                            append!(numeros_necessarios_dic[numero],col)
                        end
                    end
                end

                #verifica se algum ali só pode ir em uma posição
                if length(numeros_necessarios_dic) > 0
                    for numero in keys(numeros_necessarios_dic)
                        if length(numeros_necessarios_dic[numero]) == 1
                            col = numeros_necessarios_dic[numero][1]
                            tabuleiro[lin, col] = numero
                            println("Adicionado numero ", numero, " na posição (", lin, ", ", col, ")")
                            do_line = true #reprocessar essa linha de novo
                            do_lines = true #reprocessar todas as linhas de novo
                        else
                            do_line = false #não reprocessar a linha
                        end
                    end
                else
                    do_line = false #não reprocessar a linha
                end
            end
        end
    end



    #Verifica todas as colunas
    do_cols = true
    while do_cols
        do_cols = false #a principio não é pra reprocessar colunas
        for col in 1:9

            do_col = true
            while do_col == true
                do_col = false
                numeros_necessarios_dic = Dict{Any, Any}()
                empty!(numeros_necessarios_dic)

                intervalo = tabuleiro[:,col]

                for numero in get_missing_numbers(intervalo)
                    merge!(numeros_necessarios_dic, Dict(numero => []))
                end

                #ve onde pode colocar cada numero
                for lin in 1:9
                    for numero in keys(numeros_necessarios_dic)
                        if permitido(numero, lin, col, tabuleiro)
                            append!(numeros_necessarios_dic[numero],lin)
                        end
                    end
                end

                #verifica se algum ali só pode ir em uma posição
                if length(numeros_necessarios_dic) > 0
                    for numero in keys(numeros_necessarios_dic)
                        if length(numeros_necessarios_dic[numero]) == 1
                            lin = numeros_necessarios_dic[numero][1]
                            tabuleiro[lin, col] = numero
                            println("Adicionado numero ", numero, " na posição (", lin, ", ", col, ")")
                            do_col = true #reprocessar essa coluna de novo
                            do_cols = true #reprocessar todas as colunas de novo

                        end
                    end
                end
            end
        end
    end


    #Verifica todos os quadrantes
    do_quadrantes = true
    while do_quadrantes
        do_quadrantes = false
        for quad_lin in 1:3
            for quad_col in 1:3
                do_quadrante = true
                while do_quadrante
                    do_quadrante = false
                    numeros_necessarios_dic = Dict{Any, Any}()
                    empty!(numeros_necessarios_dic)

                    intervalo = get_quadrante(quad_lin,quad_col, tabuleiro)
                    for numero in get_missing_numbers(intervalo)
                        merge!(numeros_necessarios_dic, Dict(numero => []))
                    end

                    for lin in 1:3
                        for col in 1:3
                            for numero in keys(numeros_necessarios_dic)
                                if permitido(numero, (quad_lin-1)*3 + lin, (quad_col-1)*3 + col, tabuleiro)
                                    push!(numeros_necessarios_dic[numero],[(quad_lin-1)*3 + lin, (quad_col-1)*3 + col])
                                end
                            end
                        end
                    end


                    #verifica se algum ali só pode ir em uma posição
                    if length(numeros_necessarios_dic) > 0
                        for numero in keys(numeros_necessarios_dic)
                            if length(numeros_necessarios_dic[numero]) == 1
                                lin = numeros_necessarios_dic[numero][1][1]
                                col = numeros_necessarios_dic[numero][1][2]
                                tabuleiro[lin, col] = numero
                                println("Adicionado numero ", numero, " na posição (", lin, ", ", col, ")")
                                do_quadrante = true #reprocessar essa coluna de novo
                                do_quadrantes = true #reprocessar todas as colunas de novo
                            end
                        end
                    end
                end
            end
        end
    end

    #Verifica se acabou o jogo
    if !(0 in tabuleiro)
        global completo = true
        println("[Completo]", numero_de_verificacoes, " verificações")
    end
    global numero_de_verificacoes += 1

    if numero_de_verificacoes > 1000
       println("[ERRO] Mais de 1000 verificações")
       break
    end
end


print_tabuleiro(tabuleiro)