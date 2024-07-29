#!/bin/bash
hacer_pregunta() {
local pregunta="$1"
local respuesta="$2"
local respuesta_usuario
echo "$pregunta"
read -p "Respuesta: " respuesta_usuario
if [ "$respuesta_usuario" == "$respuesta" ]; then
	echo "¡Respuesta correcta!"
	return 0
else
	echo "Respuesta incorrecta."
	return 1
fi
}
buscar_tesoro() {
echo "¡Felicidades!Has respondido correctamente todas las preguntas."
read -p "Nombre del ganador: " nombre_ganador
echo "$nombre_ganador" >> ganadores.txt
echo "=== Top 3 Ganadores ==="
awk 'NR <= 3' ganadores.txt
}
juego_principal() {
clear
echo "¡Bienvenido al juego de busqueda del tesoro!"
preguntas=("Pregunta nivel 1: ¿Que sistema operativo podria hacer una sola tarea a la vez?" "Pregunta nivel 2: ¿En que año fue creado el primer sistema operativo por un ordenador IBM 704?" "Pregunta nivel 3: ¿Que tipo de sistema operativo permite utilizar los recursos de un solo ordenador?" "Pregunta nivel 4: ¿Cuales son los 3 sistemas operativos mas populares?")
respuestas=("MS-DOS" "1956" "El Centralizado" "Microsoft Windows, Linux, MacOS")
while true; do
	> ganadores.txt
	respuestas_correctas=0
	for ((i=0; i<${#preguntas[@]}; i++)); do
	hacer_pregunta "${preguntas[$i]}" "${respuestas[$i]}"
	if [ $? -eq 0 ]; then
		((respuestas_correctas++))
	else
		echo "Lo siento, has perdido. Intentalo de nuevo."
		break
	fi
done
	if [ $respuestas_correctas -eq ${#preguntas[@]} ]; then
		buscar_tesoro
	fi
read -p "¿Quieres volver a jugar? (si/no): " jugar_de_nuevo
echo "Respuesta del usuario a la pregunta de reinicio: $jugar_de_nuevo"
if [ "$jugar_de_nuevo" != "si" ]; then
	echo "¡Gracias por jugar!"
	break
fi
clear
done
}
juego_principal

