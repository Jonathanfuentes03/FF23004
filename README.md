# Operaciones Matemáticas en Ensamblador

Este repositorio forma parte de una práctica académica cuyo objetivo es comprender el funcionamiento de bajo nivel de operaciones aritméticas básicas utilizando lenguaje ensamblador NASM. 

---

## Estructura del Proyecto

Cada operación matemática ha sido organizada en su propio directorio, lo que facilita su mantenimiento y ejecución:

```
ff23004/
├── Division/
│   ├── Division.asm        # Código fuente NASM para división
│   ├── division.o          # Archivo objeto generado
│   └── division            # Ejecutable resultante
├── Multiplicacion/
│   ├── multiplicacion.asm  # Código fuente NASM para multiplicación
│   ├── multiplicacion.o    # Archivo objeto
│   └── multiplicacion      # Ejecutable generado
├── Resta/
│   ├── resta.asm           # Código fuente NASM para resta
│   ├── resta.o             # Archivo objeto
│   └── resta               # Ejecutable generado
```

---

## Propósito de los ejercicios

### Resta
El archivo `resta.asm` implementa una operación de resta simple entre dos valores definidos dentro del programa. Se utiliza para ilustrar el uso de registros, instrucciones `sub`, y llamadas al sistema para mostrar resultados por consola.

### Multiplicación
El archivo `multiplicacion.asm` realiza la multiplicación entre dos números enteros. Demuestra el uso de la instrucción `imul` y la manipulación de registros de propósito general.

### División
`Division.asm` efectúa la división de dos enteros. Incluye el manejo de `idiv` y cómo obtener cociente y residuo en los registros `rax` y `rdx`, respectivamente.

---

## Requisitos del sistema

Para ejecutar y/o recompilar los archivos de este proyecto, necesitas:

- Sistema operativo basado en Linux (preferentemente x86_64)
- NASM (Netwide Assembler)
- `ld` o `gcc` para enlazado

Instalación de NASM en Ubuntu/Debian:
```bash
sudo apt update
sudo apt install nasm
```

---

##  Compilación y ejecución (ejemplo)

```bash
cd Multiplicacion
nasm -f elf64 multiplicacion.asm -o multiplicacion.o
ld multiplicacion.o -o multiplicacion
./multiplicacion
```