# Intro a la seguridad de smart contracts en Foundry @ Ethereum Argentina

[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

Repositorio del taller "Intro a la seguridad de smart contracts en Foundry" dictado presencialmente el 19 de Agosto del 2023 para [Ethereum Argentina](https://ethereumargentina.org/).

## Tabla de Contenidos

- [Introducción](#introducción)
- [Recorrido](#recorrido)
- [Requisitos preliminares](#requisitos-preliminares)
- [Preparación](#preparación)
- [Uso](#uso)
- [Aviso importante](#aviso-importante)

## Introducción 

Durante el workshop vas a aprender, desde cero, los pasos fundamentales para usar [Foundry](https://book.getfoundry.sh/), un framework de testing de contratos inteligentes. 

Crearemos nuestro propio contrato para mintear NFTs, y veremos paso a paso como Foundry nos permite ponerlo a prueba para encontrar fallas y vulnerabilidades de seguridad.

Por si acaso aclaramos que **el taller NO se trata de cómo construir tu propio NFT**. Sólo utilizaremos un simple contrato de NFTs para mostrar las características de Foundry como una excelente herramienta de testing de smart contracts.

## Recorrido

1. Breve introducción al taller
    - Presentación y objetivos
    - Qué pasa si no testeas tus smart contracts.
2. Comentarios iniciales sobre Foundry
    - ¿Qué es? ¿Para qué se usa? ¿Por qué es tan bueno? ¿Y [Hardhat](hardhat.org)?
3. Instalación de Foundry
4. Creación de un proyecto de Foundry
    - Comandos básicos.
    - Estructura.
    - [Standard library](https://book.getfoundry.sh/forge/forge-std) para testing.
5. Creación de un contrato simple de NFT
    - Vistazo general del [wizard de OpenZeppelin Contracts](https://wizard.openzeppelin.com/)
    - Cómo armar un contrato de NFTs en 10 segundos.
    - Cómo importar el contrato en Foundry.
6. Troubleshooting e instalación de dependencias
7. Testing, testing, testing
    - Constructores.
    - Cheatcodes de Foundry.
    - Tests para verificar funcionalidad.
    - Tests de seguridad para evitar mal manejo de fondos, reentrancy, errores de aritmética, logging incorrecto.

## Requisitos preliminares

- Entorno local de programación con las utilidaded de línea de comandos [curl](https://curl.se/download.html) y [bash](https://www.gnu.org/software/bash/)
- Tener instalado un IDE como [VSCode](https://code.visualstudio.com/).
  - Si usás VSCode, instalá la extensión para [Solidity](https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity).
- Conocimientos básicos de programación de contratos inteligentes en [Solidity](https://soliditylang.org/).
- Conocimientos básicos sobre NFTs (Non-Fungible Tokens), y estar familiarizado con su implementación tecnológica siguiendo el [estándar ERC721](https://eips.ethereum.org/EIPS/eip-721).

## Preparación

Si querés adelantar algunos pasos previo al taller, te recomendamos:

1. Descargar [Foundry](https://book.getfoundry.sh/) con el comando:

```bash
curl -L https://foundry.paradigm.xyz | bash
```

2. Ejecutar el commando `foundryup`
3. Verificar la instalación de las tres herramientas más importantes de Foundry (`forge`, `cast` y `chisel`) ejecutando los comandos:

```bash
forge --version
> forge 0.2.0 (06a17bf 2023-08-19T00:14:54.453240995Z)

chisel --version
> chisel 0.2.0 (06a17bf 2023-08-19T00:14:54.457250529Z)

cast --version
> cast 0.2.0 (06a17bf 2023-08-19T00:14:54.444477665Z)
```

4. Clonar este repositorio a tu ambiente de desarrollo
```bash
git clone https://github.com/theredguild/workshop-ethargentina-2023.git
```

## Probando el setup

Asegurarse de estar en el directorio del proyecto
```bash
cd workshop-ethargentina-2023
```

Podés ejecutar los tests con el comando:

```bash
forge test
```

Si bien vas a ver que ya hay código dentro de este repositorio, NO está completo. Iremos explicándolo y mejorándolo durante el taller.

Para saber más sobre el comando `forge test`, podés referirte a [la documentación](https://book.getfoundry.sh/forge/tests).

## Recursos adicionales

- [Foundry book](book.getfoundry.sh/)
- [How to Foundry 2.0 by Brock Elmore](https://www.youtube.com/watch?v=EHrvD5c93JU)
- [Wizard de OpenZeppelin Contracts](https://wizard.openzeppelin.com/)

## Aviso importante

Este repositorio ha sido creado para ser utilizado con fines educacionales, como acompañamiento de un taller dictado en la edición 2023 de [Ethereum Argentina](https://ethereumargentina.org/).

No debe ser considerado ni reproducido sin el contexto brindado durante el taller. Todo el código incluido tiene errores y vulnerabilidades de seguridad.
