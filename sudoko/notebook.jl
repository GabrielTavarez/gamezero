### A Pluto.jl notebook ###
# v0.14.9

using Markdown
using InteractiveUtils

# ╔═╡ 7fa1a2aa-b5ed-11ec-2115-4baff8e2ad0d
begin
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
end

# ╔═╡ 805a414f-c6f1-4df2-80ae-c79b3631f735
begin
	possibilidades = Array{Any, 2}(undef, 9,9)
	fill!(possibilidades, [])
end

# ╔═╡ 7c428f9d-2257-408a-847e-7d980b579b7f
verifica_possibilidades!(possibilidades,tabuleiro, 1, 1)

# ╔═╡ 4ccb4a48-68fa-46eb-845f-bf49f7ce5d65
begin
	lin = 3
	col = 4
	
	lin_pos = mod(lin,3) == 0 ? 3 : mod(lin,3)
	col_pos = mod(col,3) == 0 ? 3 : mod(col,3)
	
	
	quadrante = tabuleiro[lin - (lin_pos-1):lin+(3-lin_pos), col - (col_pos - 1):col+(3 - col_pos)]
	
end

# ╔═╡ 0f3493ce-f8f7-46e3-952b-ead5ee12d9e3
function verifica_possibilidades!(possibilidades,tabuleiro, lin, col)
	numeros = [1,2,3,4,5,6,7,8,9]
	#possibilidades[lin, col] = []
	
	
	
	lin_pos = mod(linha,3) == 0 ? 3 : mod(linha,3)
	col_pos = mod(coluna,3) == 0 ? 3 : mod(coluna,3)
	
	
	quadrante = tabuleiro[linha - (lin_pos-1):linha+(3-lin_pos), coluna - (col_pos - 1):coluna+(3 - col_pos)]
	
	for numero in numeros
		possivel = false
		
		#verifica linha
		if numero in tabuleiro[linha,:]
			possivel = true
		#verifica colun
		elseif numero in tabuleiro[:, coluna]
			possivel = true
			
		#verifica quadrante
		elseif numero in quadrante
			possivel = true
		end
		
		if possivel 
			append!(possibilidades[linha,coluna], numero)	
		end
		
	end
	
end

# ╔═╡ b41760fe-6f2f-48f4-991a-4b93f4205d4a
begin
	linha = 1
	coluna = 1
	
	while linha <= 9
		while coluna <= 9			
			verifica_possibilidades!(possibilidades,tabuleiro, linha, coluna)
			#if possibilidades vazio
			#	preenche tabuleiro
			#	reinicia linha e coluna
		coluna+=1                     
		end
	linha+=1
	end
	
	
	
end

# ╔═╡ Cell order:
# ╠═7fa1a2aa-b5ed-11ec-2115-4baff8e2ad0d
# ╠═805a414f-c6f1-4df2-80ae-c79b3631f735
# ╠═b41760fe-6f2f-48f4-991a-4b93f4205d4a
# ╠═7c428f9d-2257-408a-847e-7d980b579b7f
# ╠═0f3493ce-f8f7-46e3-952b-ead5ee12d9e3
# ╠═4ccb4a48-68fa-46eb-845f-bf49f7ce5d65
