### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 886e0746-927d-11eb-0689-3b1b73fc1065
begin
	using DataFrames
	using Plots
end

# ╔═╡ 65756cbe-927a-11eb-2304-4351b9496aaf
md"
# SOLUCIÓN GUÍA 3
**Estudiante:** René David Hernández

**No. Cuenta:** 20131003636
"

# ╔═╡ 79f59f76-927d-11eb-2656-addad4eb7b6c
md"## Carga de paquetes a utilizar"

# ╔═╡ 207afa92-927b-11eb-308c-bd7b474ec484
md"
## Paso \# 1
Con apoyo de alguna herramienta (Excel de preferencia o un lenguaje de programación), construya un generador de números pseudo-aleatorios para:

1.Método cuadrado medio

2.Método congruencial

Los parámetros de cada uno de los métodos tienen que poder manipularse en la herramienta.
"

# ╔═╡ 888e7cf8-927b-11eb-02ef-634edeb9f210
md"
#### Solución al paso \# 1
"

# ╔═╡ 4e31e6ac-9290-11eb-0a77-db94b8e695dd
md"
##### 1
A continuación se presenta el código para la creación de número aleatorios con el método del cuadrado medio. Para ello se implementan dos funciones:

+ La primera 'middlesquaremethod' toma como parámetro el número semilla, la cantidad de números aleatorios por obtener y el número de dígitos de los números generados.

+ La segunda función 'selectmiddlenumber' selecciona de un número ($N_1$), otro número ($N_2$), seleccionando de $N_1$ los dígitos centrales acorde al número de digitos requeridos para $N_2$. Se agregan ceros de ser necesario. 

El método muchas veces requiere que el número de dígitos del número semilla $seed>3$.
"

# ╔═╡ 6d3ff892-9284-11eb-149a-65d7ddaa2da9
function selectmiddlenumber(number², digits)
	if number² ≠ 0
		paddingnumber = length(number²) - digits
		if paddingnumber%2 ≠ 0
			number² = string("0", number²) 
			paddingnumber += 1
		end
		nbegin = Int(paddingnumber/2) + 1
		nend = Int(nbegin + digits) - 1
		return parse(Int64, number²[nbegin:nend])
	elseif number² == 0
		return 0
	end
end

# ╔═╡ cfe93ade-927b-11eb-187b-036bea5cbf40
function middlesquaremethod(seed::Int64, n::Int64, digits::Int64)
	set = []
	for i in 1:n
		middlenumber = selectmiddlenumber(string(seed^2), digits)
		seed = middlenumber
		push!(set, parse(Float64, string("0.", middlenumber)))
	end
	return set
end

# ╔═╡ c623d56c-9293-11eb-3ff8-1d0117961f2b
middlesquaremethod(154, 12, 3)

# ╔═╡ 3762fc56-9293-11eb-026f-f333035d1d5e
md"
##### 2

Se construye la función 'congruentialmethod', el cual recibe como parámetros de entrada a: el valor semilla $x_0$, el factor de multiplicación $a$, la constante aditiva $c$, y el valor de módulo $m$. Acorde a la fórmula recursiva del método para generar los números aleatorios dado por:

$x_{n+1}=(a x_n + c)mod\ m$
"

# ╔═╡ d3d5c118-9293-11eb-26c9-8b374ab93605
function congruentialmethod(x₀, a, c, m, n)
	set = []
	for i in 1:n
		x = (a*x₀+c)%m
		push!(set, x)
		x₀ = x
	end
	return set
end

# ╔═╡ ebf00dcc-9297-11eb-0191-410d80a07cb2
congruentialmethod(7, 1, 7, 13, 16)

# ╔═╡ 155a0ed0-9298-11eb-2ff9-2b417ba46be6
md"
## Paso \# 2
Empleando los generadores realizadosen el paso 1, resuelva:

##### 1 
Genere 50 números aleatorios, mediante el generador de cuadrados medios cuya semilla sea:
+ 4567234902(4 dígitos)
"

# ╔═╡ 1214b520-929a-11eb-1872-1535607f4c08
array₁ = middlesquaremethod(4567234902, 50, 4)

# ╔═╡ e89aff9a-92a3-11eb-130f-31dbddbad543
plot(array₁, title="Números Aleatorios Generados", xlabel="Índice", ylabel="Valor de Número Aleatorio", xticks=0:2:length(array₁))

# ╔═╡ 2d37ef38-9299-11eb-2486-5ffb66609d8e
md"
+ 3567345(3 dígitos) 
"

# ╔═╡ b773ed8a-929b-11eb-0046-a9c64693d1ba
array₂ = middlesquaremethod(3567345, 50, 3)

# ╔═╡ 111c6774-92a4-11eb-071d-9ff01b9a8df3
plot(array₂, title="Números Aleatorios Generados", xlabel="Índice", ylabel="Valor de Número Aleatorio", xticks=0:2:length(array₂))

# ╔═╡ 2e8ae456-9299-11eb-22d0-e5e53ec6dd42
md"

+ 1234500012(4 dígitos)
"

# ╔═╡ c6ce85c4-929b-11eb-14ab-1941bc202841
array₃ = middlesquaremethod(1234500012, 50, 4)

# ╔═╡ 24daed12-92a4-11eb-26e4-4d629f87465f
plot(array₃, title="Números Aleatorios Generados", xlabel="Índice", ylabel="Valor de Número Aleatorio", xticks=0:2:length(array₃))

# ╔═╡ 112305e4-9299-11eb-091a-59fcb6a91517
md"
##### 2
Determine la cantidad de números en la cola (si lo tiene) y la cantidad de números del período de los siguientes generadores congruenciales mixtoso multiplicativos:

+ $x_0 = 15, a= 8, c=16, m=100$
"

# ╔═╡ e13a784c-929c-11eb-38b2-59481512d46f
exercice₁ = congruentialmethod(15, 8, 16, 100, 45)

# ╔═╡ 856d06b2-929d-11eb-0e93-677648a4e341
plot(exercice₁, title="Números Aleatorios Ejercicio 1", xlabel="Índice", ylabel="Valor de Número Aleatorio", xticks=0:2:length(exercice₁))

# ╔═╡ 99c34cfa-929f-11eb-39ee-65fa387f5aab
md"
Acorde a la gráfica observada, la cola es 1 y el período es 20.
"

# ╔═╡ 7527ff72-9299-11eb-39c7-11e83aaea225
md"
+ $x_0 = 13, a= 50, c=17, m=64$
"

# ╔═╡ 7b45108c-929d-11eb-247e-a5ae91f9613f
exercice₂ = congruentialmethod(13, 50, 17, 64, 50)

# ╔═╡ c2663758-929f-11eb-03e4-534ad7ef15a3
plot(exercice₂, title="Números Aleatorios Ejercicio 2", xlabel="Índice", ylabel="Valor de Número Aleatorio", xticks=1:2:length(exercice₂))

# ╔═╡ 023d50e6-92a0-11eb-3ccc-db7a4e0e67e3
md"
Acorde a la gráfica se observa que luego del quinto elemento generado el número 31 se repite. Concluyo que la cola es 4 y la longitud del ciclo sería 1.
"

# ╔═╡ afa2f526-9299-11eb-0185-65c0dee660f6
md"
+ $x_0 = 7, a= 5, c=24, m=32$
"

# ╔═╡ 7c932292-929d-11eb-11b1-c9b486bf482b
exercice₃ = congruentialmethod(7, 5, 24, 32, 50)

# ╔═╡ ff8dabe2-92a0-11eb-2609-d314775b7465
plot(exercice₃, title="Números Aleatorios Ejercicio 3", xlabel="Índice", ylabel="Valor de Número Aleatorio", xticks=1:2:length(exercice₃))

# ╔═╡ 2d6163c8-92a2-11eb-1e06-2f043805177f
md"
Acorde a la gráfica la cola es 7, y el periodo 15.
"

# ╔═╡ cf1e3082-9299-11eb-3ddd-83ca64353577
md"
+ $x_0 = 7, a= 5, c=0, m=64$
"

# ╔═╡ 7e11a0b2-929d-11eb-39a1-3d781093114c
exercice₄ = congruentialmethod(7, 5, 0, 64, 50)

# ╔═╡ a62a303c-92a2-11eb-0d93-675cba73582c
plot(exercice₄, title="Números Aleatorios Ejercicio 4", xlabel="Índice", ylabel="Valor de Número Aleatorio", xticks=1:2:length(exercice₄))

# ╔═╡ f3197e20-92a2-11eb-2ef6-0943bfef1165
md"
Acorde a la gráfica la cola es 9, y el periodo 16.
"

# ╔═╡ e60cf29a-9299-11eb-1748-1d5c5405aa72
md"
+ $x_0 = 9, a= 11, c=0, m=128$
"

# ╔═╡ 7fef0a02-929d-11eb-03ad-5f050044a5cb
exercice₅ = congruentialmethod(9, 11, 0, 128, 55)

# ╔═╡ f521d5a0-92a2-11eb-05ab-0d12a9b04d13
plot(exercice₅, title="Números Aleatorios Ejercicio 4", xlabel="Índice", ylabel="Valor de Número Aleatorio", xticks=0:2:length(exercice₅))

# ╔═╡ f65356cc-92a2-11eb-3d35-a11007114732
md"
Acorde a la gráfica la cola es 1, y el periodo 32.
"

# ╔═╡ d1acc700-92a3-11eb-28f0-dfd91d8ffb00
md"
##### 3
Proponga 2 combinaciones que “logren” generar al menos 100 números aleatorios distintos.
"

# ╔═╡ 7f2ff38e-92a4-11eb-3200-87483665d025
md"
###### Propuesta 1
"

# ╔═╡ 43734f12-92a4-11eb-2d01-b9f3a004cdfc
array₄ = middlesquaremethod(26038, 100, 5)

# ╔═╡ 513f04b0-92a4-11eb-3511-191f753834e4
plot(array₄, title="Números Aleatorios Generados", xlabel="Índice", ylabel="Valor de Número Aleatorio", xticks=0:10:length(array₄))

# ╔═╡ c03fc3ee-92a5-11eb-17ab-8904915c1a19
length(unique(array₄))

# ╔═╡ df3d7552-92a5-11eb-1e09-9fcda51b834a
md"
La línea anterior demuestra que se han generado $100$ números aleatorios sin repetirse.
"

# ╔═╡ 8e66120c-92a4-11eb-26ff-5910db7d4d27
md"
###### Propuesta 2
"

# ╔═╡ 95128cfc-92a4-11eb-3a9b-1d390028e7d7
array₅ = middlesquaremethod(49063345, 100, 5)

# ╔═╡ 9a2e4dd4-92a4-11eb-2d11-bfdc3e5148f8
plot(array₅, title="Números Aleatorios Generados", xlabel="Índice", ylabel="Valor de Número Aleatorio", xticks=0:10:length(array₅))

# ╔═╡ fbba971e-92a5-11eb-35c2-9910edbd3a01
length(unique(array₅))

# ╔═╡ fcaa506a-92a5-11eb-1f24-f3551cb7bea1
md"
La línea anterior demuestra que se han generado $100$ números aleatorios sin repetirse.
"

# ╔═╡ Cell order:
# ╟─65756cbe-927a-11eb-2304-4351b9496aaf
# ╟─79f59f76-927d-11eb-2656-addad4eb7b6c
# ╠═886e0746-927d-11eb-0689-3b1b73fc1065
# ╟─207afa92-927b-11eb-308c-bd7b474ec484
# ╟─888e7cf8-927b-11eb-02ef-634edeb9f210
# ╟─4e31e6ac-9290-11eb-0a77-db94b8e695dd
# ╠═cfe93ade-927b-11eb-187b-036bea5cbf40
# ╠═6d3ff892-9284-11eb-149a-65d7ddaa2da9
# ╠═c623d56c-9293-11eb-3ff8-1d0117961f2b
# ╟─3762fc56-9293-11eb-026f-f333035d1d5e
# ╠═d3d5c118-9293-11eb-26c9-8b374ab93605
# ╠═ebf00dcc-9297-11eb-0191-410d80a07cb2
# ╟─155a0ed0-9298-11eb-2ff9-2b417ba46be6
# ╠═1214b520-929a-11eb-1872-1535607f4c08
# ╠═e89aff9a-92a3-11eb-130f-31dbddbad543
# ╟─2d37ef38-9299-11eb-2486-5ffb66609d8e
# ╠═b773ed8a-929b-11eb-0046-a9c64693d1ba
# ╠═111c6774-92a4-11eb-071d-9ff01b9a8df3
# ╟─2e8ae456-9299-11eb-22d0-e5e53ec6dd42
# ╠═c6ce85c4-929b-11eb-14ab-1941bc202841
# ╠═24daed12-92a4-11eb-26e4-4d629f87465f
# ╟─112305e4-9299-11eb-091a-59fcb6a91517
# ╠═e13a784c-929c-11eb-38b2-59481512d46f
# ╠═856d06b2-929d-11eb-0e93-677648a4e341
# ╟─99c34cfa-929f-11eb-39ee-65fa387f5aab
# ╟─7527ff72-9299-11eb-39c7-11e83aaea225
# ╠═7b45108c-929d-11eb-247e-a5ae91f9613f
# ╠═c2663758-929f-11eb-03e4-534ad7ef15a3
# ╟─023d50e6-92a0-11eb-3ccc-db7a4e0e67e3
# ╟─afa2f526-9299-11eb-0185-65c0dee660f6
# ╠═7c932292-929d-11eb-11b1-c9b486bf482b
# ╠═ff8dabe2-92a0-11eb-2609-d314775b7465
# ╟─2d6163c8-92a2-11eb-1e06-2f043805177f
# ╟─cf1e3082-9299-11eb-3ddd-83ca64353577
# ╠═7e11a0b2-929d-11eb-39a1-3d781093114c
# ╠═a62a303c-92a2-11eb-0d93-675cba73582c
# ╟─f3197e20-92a2-11eb-2ef6-0943bfef1165
# ╟─e60cf29a-9299-11eb-1748-1d5c5405aa72
# ╠═7fef0a02-929d-11eb-03ad-5f050044a5cb
# ╠═f521d5a0-92a2-11eb-05ab-0d12a9b04d13
# ╟─f65356cc-92a2-11eb-3d35-a11007114732
# ╟─d1acc700-92a3-11eb-28f0-dfd91d8ffb00
# ╟─7f2ff38e-92a4-11eb-3200-87483665d025
# ╠═43734f12-92a4-11eb-2d01-b9f3a004cdfc
# ╠═513f04b0-92a4-11eb-3511-191f753834e4
# ╠═c03fc3ee-92a5-11eb-17ab-8904915c1a19
# ╟─df3d7552-92a5-11eb-1e09-9fcda51b834a
# ╟─8e66120c-92a4-11eb-26ff-5910db7d4d27
# ╠═95128cfc-92a4-11eb-3a9b-1d390028e7d7
# ╠═9a2e4dd4-92a4-11eb-2d11-bfdc3e5148f8
# ╠═fbba971e-92a5-11eb-35c2-9910edbd3a01
# ╟─fcaa506a-92a5-11eb-1f24-f3551cb7bea1
